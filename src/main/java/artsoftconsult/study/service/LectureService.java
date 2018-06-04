package artsoftconsult.study.service;

import artsoftconsult.study.dto.model.LectureDTO;
import artsoftconsult.study.dto.model.PageDTO;
import artsoftconsult.study.model.Lecture;
import artsoftconsult.study.model.Page;
import artsoftconsult.study.model.User;
import artsoftconsult.study.model.VirtualClass;
import artsoftconsult.study.repository.LectureRepository;
import artsoftconsult.study.repository.PageRepository;
import artsoftconsult.study.repository.VirtualClassRepository;
import artsoftconsult.study.utils.MyAttributeProvider;
import org.hibernate.Hibernate;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Service
public class LectureService {

    @Autowired
    private LectureRepository lectureRepository;

    @Autowired
    private VirtualClassRepository classRepository;

    @Autowired
    private PageRepository pageRepository;

    @Autowired
    private ModelMapper modelMapper;

    private Lecture prepareForSave(Lecture lecture) {
        lecture.setViews(0l);
        lecture.setScore(0l);
        lecture.setCreated(new Date(System.currentTimeMillis()));
        lecture.setLastActive(new Date(System.currentTimeMillis()));
        if (lecture.getDescription() == null)
            lecture.setDescription("");
        lecture.setDeleted(false);
        return lecture;
    }

    private Page prepareForSave(Page page) {
        page.setActive(true);
        page.setCreated(new Date(System.currentTimeMillis()));
        page.setLastActive(new Date(System.currentTimeMillis()));
        page.setScore(0L);
        page.setViews(0L);
        page.setVisibility("PUBLIC");
        page.setTitle("");
        page.setDeleted(false);
        return page;
    }

    @Transactional
    public Long save(String title, String description, Long classId, String visibility, Boolean active, PageDTO[] pageDTOS, User user) {
        VirtualClass virtualClass = classRepository.findByVirtualClassIdAndDeletedFalse(classId);
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
                pages.add(prepareForSave(page));
            }
            lecture.setPages(pages);
            Lecture saved = lectureRepository.save(prepareForSave(lecture));
            if (saved != null) {
                return saved.getLectureId();
            }
        }
        return -1l;
    }

    @Transactional
    public Long save(String content, Long lectureId, User user) {
        Lecture lecture = lectureRepository.findByLectureIdAndDeletedFalse(lectureId);
        if (lecture.getVirtualClass().getUser().getUserId().equals(user.getUserId())) {
            Page page = new Page();
            page.setLecture(lecture);
            page.setContent(content);
            page = pageRepository.save(prepareForSave(page));
            if (page != null) {
                lecture = lectureRepository.findByLectureIdAndDeletedFalse(lectureId);
                return (long) lecture.getPages().size();
            }
        }
        return 0L;
    }

    @Transactional
    public LectureDTO find(Long lectureId, User user) {
        lectureRepository.incrementView(lectureId);
        Lecture lecture = lectureRepository.findByLectureIdAndDeletedFalse(lectureId);
        Hibernate.initialize(lecture.getPages());
        Hibernate.initialize(lecture.getQuestions());

        LectureDTO lectureDTO = new LectureDTO();
        modelMapper.map(lecture, lectureDTO);
        lectureDTO.setRawDescription(lectureDTO.getDescription());
        lectureDTO.setDescription(MyAttributeProvider.commonMark(lectureDTO.getRawDescription()));
        Collection<PageDTO> pages = new ArrayList<>();
        for (PageDTO page : lectureDTO.getPages()) {
            if (!page.getDeleted()) {
                page.setRawContent(page.getContent());
                page.setContent(MyAttributeProvider.commonMark(page.getRawContent()));
                pages.add(page);
            }
        }
        lectureDTO.setPages(pages);
        if (user != null) { //authenticated
            Integer voteType = lectureRepository.findVoteType(lectureId, user.getUserId());
            if (voteType == null)
                lectureDTO.setVoteType(0);
            else if (voteType.equals(-1))
                lectureDTO.setVoteType(-1);
            else
                lectureDTO.setVoteType(1);
        } else
            lectureDTO.setVoteType(0);
        return lectureDTO;
    }

    @Transactional
    public void update(Lecture lecture) {
        Lecture lectureFromDb = lectureRepository.findByLectureIdAndDeletedFalse(lecture.getLectureId());
        if (lecture.getVirtualClass().getUser().getUserId().equals(lectureFromDb.getVirtualClass().getUser().getUserId())) {
            lectureRepository.updateTitleAndDescription(lecture.getTitle(), lecture.getDescription(), lecture.getLectureId());
        }
    }

    @Transactional
    public void updatePage(Page page) {
        Page pageFromDb = pageRepository.findByPageIdAndDeletedFalse(page.getPageId());
        if (page.getLecture().getVirtualClass().getUser().getUserId().equals(pageFromDb.getLecture().getVirtualClass().getUser().getUserId())) {
            pageRepository.updateContent(page.getContent(), page.getPageId());
        }
    }

    @Transactional
    public void vote(Long lectureId, Long userId, String type) {
        Integer newVote;
        if (type.equals("Upvote")) {
            newVote = 1;
        } else {
            newVote = -1;
        }
        Integer oldVote = lectureRepository.findVoteType(lectureId, userId);
        if (oldVote == null) {
            oldVote = 0;
        }
        if (oldVote.equals(newVote)) {
        } else if (!oldVote.equals(0)) {
            lectureRepository.changeVote(lectureId, userId, newVote);
            lectureRepository.updateScore(lectureId, newVote * 2);
        } else {
            lectureRepository.newVote(lectureId, userId, newVote);
            lectureRepository.updateScore(lectureId, newVote);
        }
    }

    @Transactional
    public void deleteLecture(Long lectureId, Long userId) {
        Lecture lectureFromDb = lectureRepository.findByLectureId(lectureId);
        if (lectureFromDb.getVirtualClass().getUser().getUserId().equals(userId)) {
            lectureRepository.logicalDelete(lectureId);
        }
    }

    @Transactional
    public void deletePage(Long pageId, Long userId) {
        Page pageFromDB = pageRepository.findByPageId(pageId);
        if (pageFromDB.getLecture().getVirtualClass().getUser().getUserId().equals(userId)) {
            pageRepository.logicalDelete(pageId);
        }
    }
}
