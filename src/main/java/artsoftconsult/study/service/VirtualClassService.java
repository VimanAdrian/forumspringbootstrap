package artsoftconsult.study.service;

import artsoftconsult.study.model.Category;
import artsoftconsult.study.model.Lecture;
import artsoftconsult.study.model.User;
import artsoftconsult.study.model.VirtualClass;
import artsoftconsult.study.repository.CategoryRepository;
import artsoftconsult.study.repository.LectureRepository;
import artsoftconsult.study.repository.VirtualClassRepository;
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

    private VirtualClass prepareForSave(VirtualClass virtualClass) {

        virtualClass.setActive(true);
        virtualClass.setCreated(new Date(System.currentTimeMillis()));
        virtualClass.setLastActive(new Date(System.currentTimeMillis()));
        virtualClass.setScore(0l);
        virtualClass.setViews(0l);
        virtualClass.setVisibility("public");
        return virtualClass;
    }

    private Lecture prepareForSave(Lecture lecture) {

        lecture.setActive(true);
        lecture.setCreated(new Date(System.currentTimeMillis()));
        lecture.setLastActive(new Date(System.currentTimeMillis()));
        lecture.setScore(0l);
        lecture.setViews(0l);
        lecture.setVisibility("public");
        return lecture;
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
            lectures.add(prepareForSave(lecture));
        }
        lectureRepository.save(lectures);

        if (saved != null) {
            return saved.getVirtualClassId();
        } else
            return -1l;
    }
}
