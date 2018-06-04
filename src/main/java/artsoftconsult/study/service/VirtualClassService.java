package artsoftconsult.study.service;

import artsoftconsult.study.dto.model.VirtualClassDTO;
import artsoftconsult.study.model.*;
import artsoftconsult.study.repository.CategoryRepository;
import artsoftconsult.study.repository.LectureRepository;
import artsoftconsult.study.repository.VirtualClassRepository;
import artsoftconsult.study.repository.VirtualClassRightsRepository;
import artsoftconsult.study.utils.MyAttributeProvider;
import org.hibernate.Hibernate;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Service
public class VirtualClassService {

    @Autowired
    private VirtualClassRepository virtualClassRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private LectureRepository lectureRepository;

    @Autowired
    private VirtualClassRightsRepository virtualClassRightsRepository;

    @Autowired
    private ModelMapper modelMapper;

    private VirtualClass prepareForSave(VirtualClass virtualClass) {
        virtualClass.setActive(true);
        virtualClass.setCreated(new Date(System.currentTimeMillis()));
        virtualClass.setLastActive(new Date(System.currentTimeMillis()));
        virtualClass.setScore(0l);
        virtualClass.setViews(0l);
        virtualClass.setVisibility("public");
        virtualClass.setDeleted(false);
        return virtualClass;
    }

    private Lecture prepareForSave(Lecture lecture) {
        lecture.setActive(true);
        lecture.setCreated(new Date(System.currentTimeMillis()));
        lecture.setLastActive(new Date(System.currentTimeMillis()));
        lecture.setScore(0l);
        lecture.setViews(0l);
        lecture.setVisibility("public");
        lecture.setDeleted(false);
        if (lecture.getDescription() == null) {
            lecture.setDescription("");
        }
        return lecture;
    }

    @Transactional
    public Long save(String[] title, Long virtualClassId, User user) {
        VirtualClass virtualClass = virtualClassRepository.findByVirtualClassIdAndDeletedFalse(virtualClassId);
        if (user.getUserId().equals(virtualClass.getUser().getUserId())) {
            Collection<Lecture> lectures = new ArrayList<>();
            for (int i = 0; i < title.length; i++) {
                Lecture lecture = new Lecture();
                lecture.setTitle(title[i]);
                lecture.setVirtualClass(virtualClass);
                if (lecture.getTitle().length() > 0)
                    lectures.add(prepareForSave(lecture));
            }
            lectureRepository.save(lectures);
        }
        return virtualClassId;
    }

    @Transactional
    public Long save(String[] title, String content, String tags, User user) {
        VirtualClass virtualClass = new VirtualClass();
        virtualClass.setTitle(title[0]);
        virtualClass.setDescription(content);

        List<Category> categories = new ArrayList<>();
        String[] tagsArray = tags.split(",");
        for (String tag : tagsArray) {
            Category oldCategory = categoryRepository.findByTitle(tag.toLowerCase());
            if (oldCategory != null) {
                categories.add(oldCategory);
            } else {
                Category newCategory = new Category();
                newCategory.setTitle(tag.toLowerCase());
                try {
                    newCategory.setUrl(URLEncoder.encode(tag.toLowerCase(), "UTF-8"));
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
                categories.add(newCategory);
            }
        }
        Iterable<Category> categoryIterable = categoryRepository.save(categories);
        Collection<Category> categoryCollection = new ArrayList<>();
        for (Category category : categoryIterable) {
            categoryCollection.add(category);
        }
        virtualClass.setVirtualClassCategories(categoryCollection);
        virtualClass.setUser(user);

        VirtualClass saved = virtualClassRepository.save(prepareForSave(virtualClass));

        Collection<Lecture> lectures = new ArrayList<>();
        for (int i = 1; i < title.length; i++) {
            Lecture lecture = new Lecture();
            lecture.setTitle(title[i]);
            lecture.setVirtualClass(saved);
            if (lecture.getTitle().length() > 0)
                lectures.add(prepareForSave(lecture));
        }
        lectureRepository.save(lectures);

        if (saved != null) {
            return saved.getVirtualClassId();
        } else
            return -1l;
    }

    private VirtualClass prepareForUpdate(VirtualClass classFromDb, VirtualClass classFromFront) {
        classFromDb.setDescription(classFromFront.getDescription());
        classFromDb.setTitle(classFromFront.getTitle());
        return classFromDb;
    }

    @Transactional
    public void update(VirtualClass virtualClass, String tags) {
        VirtualClass classFromDB = virtualClassRepository.findByVirtualClassIdAndDeletedFalse(virtualClass.getVirtualClassId());
        if (virtualClass.getUser().getUserId().equals(classFromDB.getUser().getUserId())) {
            List<Category> categories = new ArrayList<>();
            List<Category> newCategories = new ArrayList<>();
            for (String tag : tags.split(",")) {
                Category oldCategory = categoryRepository.findByTitle(tag.toLowerCase());
                if (oldCategory != null) {
                    if (!categories.contains(oldCategory))
                        categories.add(oldCategory);
                } else {
                    Category newCategory = new Category();
                    newCategory.setTitle(tag.toLowerCase());
                    try {
                        newCategory.setUrl(URLEncoder.encode(tag.toLowerCase(), "UTF-8"));
                    } catch (UnsupportedEncodingException e) {
                        e.printStackTrace();
                    }
                    if (!categories.contains(newCategory)) {
                        categories.add(newCategory);
                        newCategories.add(newCategory);
                    }
                }
            }
            categoryRepository.save(newCategories);
            classFromDB.getVirtualClassCategories().clear();
            classFromDB.getVirtualClassCategories().addAll(categories);
            virtualClassRepository.save(prepareForUpdate(classFromDB, virtualClass));
        } else {
            VirtualClassRights classRights = virtualClassRightsRepository.findByUserIdAndClassId(virtualClass.getVirtualClassId(), virtualClass.getUser().getUserId());
            if (classRights != null) {
                if (classRights.getCanEdit()) {
                    virtualClassRepository.save(prepareForUpdate(classFromDB, virtualClass));
                }
            }
        }
    }

    @Transactional
    public VirtualClassDTO find(Long classId, User user) {
        virtualClassRepository.incrementView(classId);
        VirtualClass virtualClass = virtualClassRepository.findByVirtualClassIdAndDeletedFalse(classId);
        Hibernate.initialize(virtualClass.getLectures());
        Hibernate.initialize(virtualClass.getVirtualClassCategories());
        Hibernate.initialize(virtualClass.getUser());

        VirtualClassDTO virtualClassDTO = new VirtualClassDTO();
        modelMapper.map(virtualClass, virtualClassDTO);
        virtualClassDTO.setRawDescription(virtualClassDTO.getDescription());
        virtualClassDTO.setDescription(MyAttributeProvider.commonMark(virtualClassDTO.getDescription()));
        if (user != null) { //authenticated
            Integer voteType = virtualClassRepository.findVoteType(classId, user.getUserId());
            if (voteType == null)
                virtualClassDTO.setVoteType(0);
            else if (voteType.equals(-1))
                virtualClassDTO.setVoteType(-1);
            else
                virtualClassDTO.setVoteType(1);
        } else
            virtualClassDTO.setVoteType(0);
        return virtualClassDTO;
    }


}
