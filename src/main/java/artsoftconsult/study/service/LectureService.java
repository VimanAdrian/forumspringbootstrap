package artsoftconsult.study.service;

import artsoftconsult.study.dto.model.PageDTO;
import artsoftconsult.study.model.Lecture;
import artsoftconsult.study.model.Page;
import artsoftconsult.study.model.User;
import artsoftconsult.study.model.VirtualClass;
import artsoftconsult.study.repository.LectureRepository;
import artsoftconsult.study.repository.VirtualClassRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@Service
public class LectureService {

    @Autowired
    private LectureRepository lectureRepository;

    @Autowired
    private VirtualClassRepository classRepository;

    @Autowired
    private ModelMapper modelMapper;

    private Lecture prepareForSave(Lecture lecture) {
        lecture.setViews(0l);
        lecture.setScore(0l);
        lecture.setCreated(new Date(System.currentTimeMillis()));
        lecture.setLastActive(new Date(System.currentTimeMillis()));
        return lecture;
    }

    @Transactional
    public Long save(String title, String description, Long classId, String visibility, Boolean active, PageDTO[] pageDTOS, User user) {
        VirtualClass virtualClass = classRepository.findByVirtualClassId(classId);
        if (virtualClass.getUser().getUserId().equals(user.getUserId())) {
            Lecture lecture = new Lecture();
            lecture.setVirtualClass(virtualClass);
            lecture.setTitle(title);
            lecture.setDescription(description);
            lecture.setVisibility(visibility);
            lecture.setActive(active);

            List<Page> pages = new ArrayList<>();
            for (PageDTO pageDto : pageDTOS) {
                Page page = new Page();
                modelMapper.map(pageDto, page);
                pages.add(page);
            }
            lecture.setPages(pages);
            Lecture saved = lectureRepository.save(lecture);
            if (saved != null) {
                return saved.getLectureId();
            }
        }
        return -1l;
    }
}
