package artsoftconsult.study.service;

import artsoftconsult.study.model.*;
import artsoftconsult.study.repository.*;
import artsoftconsult.study.utils.MyAttributeProvider;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Service
public class SearchService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private LectureRepository lectureRepository;

    @Autowired
    private PageRepository pageRepository;

    @Autowired
    private VirtualClassRepository virtualClassRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private UserRepository userRepository;

    @Transactional(readOnly = true)
    protected Page<Question> initializeQuestion(Page<Question> questionPage) {
        questionPage.getContent().forEach(question -> Hibernate.initialize(question.getQuestionCategories()));
        questionPage.getContent().forEach(question -> question.getReplies().forEach(reply -> reply.setContent(MyAttributeProvider.commonMark(reply.getContent()))));
        questionPage.getContent().forEach(question -> question.getQuestionComments().forEach(comment -> comment.setContent(MyAttributeProvider.commonMark(comment.getContent()))));
        return questionPage;
    }

    @Transactional(readOnly = true)
    protected Page<VirtualClass> initializeVirtualClass(Page<VirtualClass> virtualClassPage) {
        virtualClassPage.getContent().forEach(virtualClass -> Hibernate.initialize(virtualClass.getVirtualClassCategories()));
        virtualClassPage.getContent().forEach(virtualClass -> virtualClass.getLectures().forEach(lecture -> lecture.setDescription(MyAttributeProvider.commonMark(lecture.getDescription()))));
        return virtualClassPage;
    }

    @Transactional(readOnly = true)
    protected Page<Lecture> initializeLecture(Page<Lecture> lecturePage) {
        Hibernate.initialize(lecturePage.getContent());
        lecturePage.getContent().forEach(lecture -> lecture.setDescription(MyAttributeProvider.commonMark(lecture.getDescription())));
        return lecturePage;
    }

    @Transactional(readOnly = true)
    public Page<Question> searchQuestionByTag(String tag, Integer page, Integer size) {
        Category searchedBy = categoryRepository.findByUrl(tag);
        Pageable pageable = new PageRequest(page, size, Sort.Direction.DESC, "score");
        if (searchedBy != null) {
            Page<Question> questionPage = questionRepository.findByQuestionCategoriesAndDeletedFalse(pageable, searchedBy);
            return initializeQuestion(questionPage);
        }
        return new PageImpl<>(new ArrayList<>(), pageable, 0);
    }

    @Transactional(readOnly = true)
    public Page<VirtualClass> searchVirtualClassByTag(String tag, Integer page, Integer size) {
        Category searchedBy = categoryRepository.findByUrl(tag);
        Pageable pageable = new PageRequest(page, size, Sort.Direction.DESC, "score");
        if (searchedBy != null) {
            Page<VirtualClass> virtualClassPage = virtualClassRepository.findByVirtualClassCategoriesAndDeletedFalse(pageable, searchedBy);
            return initializeVirtualClass(virtualClassPage);
        }
        return new PageImpl<>(new ArrayList<>(), pageable, 0);
    }

    public Page<Lecture> searchLectureByTag(String tag, Integer page, Integer size) {
        return null;
    }

    @Transactional(readOnly = true)
    public Page<Question> searchQuestionByFreeText(String search, Integer page, Integer size) {
        Pageable pageable = new PageRequest(page, size, Sort.Direction.DESC, "score");
        Page<Question> questionPage = questionRepository.findByTitleContainingOrContentContainingAndDeletedFalse(pageable, search, search);
        return initializeQuestion(questionPage);
    }

    @Transactional(readOnly = true)
    public Page<VirtualClass> searchVirtualClassByFreeText(String search, Integer page, Integer size) {
        Pageable pageable = new PageRequest(page, size, Sort.Direction.DESC, "score");
        Page<VirtualClass> virtualClassPage = virtualClassRepository.findByTitleContainingOrDescriptionContainingAndDeletedFalse(pageable, search, search);
        return initializeVirtualClass(virtualClassPage);
    }

    @Transactional(readOnly = true)
    public Page<Lecture> searchLectureByFreeText(String search, Integer page, Integer size) {
        Pageable pageable = new PageRequest(page, size, Sort.Direction.DESC, "score");
        Page<Lecture> lecturePage = lectureRepository.findByTitleContainingOrDescriptionContainingAndDeletedFalse(pageable, search, search);
        return initializeLecture(lecturePage);
    }

    @Transactional(readOnly = true)
    public Page<Question> searchQuestionByUser(String username, Integer page, Integer size) {
        if (username != null) {
            User searchedBy = userRepository.findByUsername(username);
            Pageable pageable = new PageRequest(page, size, Sort.Direction.DESC, "score");
            if (searchedBy != null) {
                Page<Question> questionPage = questionRepository.findByUserAndDeletedFalse(pageable, searchedBy);
                return initializeQuestion(questionPage);
            } else return new PageImpl<>(new ArrayList<>(), pageable, 0);
        }
        return searchQuestionByBrowse(page, size);
    }

    @Transactional(readOnly = true)
    public Page<VirtualClass> searchVirtualClassByUser(String username, Integer page, Integer size) {
        if (username != null) {
            User searchedBy = userRepository.findByUsername(username);
            Pageable pageable = new PageRequest(page, size, Sort.Direction.DESC, "score");
            if (searchedBy != null) {
                Page<VirtualClass> virtualClassPage = virtualClassRepository.findByUserAndDeletedFalse(pageable, searchedBy);
                return initializeVirtualClass(virtualClassPage);
            } else return new PageImpl<>(new ArrayList<>(), pageable, 0);
        }
        return searchVirtualClassByBrowse(page, size);
    }

    public Page<Lecture> searchLectureByUser(String username, Integer page, Integer size) {
        return null;
    }

    @Transactional(readOnly = true)
    public Page<Question> searchQuestionByBrowse(Integer page, Integer size) {
        Pageable pageable = new PageRequest(page, size, Sort.Direction.DESC, "created");
        Page<Question> questionPage = questionRepository.findByDeletedFalse(pageable);
        return initializeQuestion(questionPage);
    }

    @Transactional(readOnly = true)
    public Page<VirtualClass> searchVirtualClassByBrowse(Integer page, Integer size) {
        Pageable pageable = new PageRequest(page, size, Sort.Direction.DESC, "created");
        Page<VirtualClass> virtualClassPage = virtualClassRepository.findByDeletedFalse(pageable);
        return initializeVirtualClass(virtualClassPage);
    }

    @Transactional
    public Page<Question> searchQuestionByLecture(Long lectureId, Integer page, Integer size) {
        Lecture searchedBy = lectureRepository.findByLectureIdAndDeletedFalse(lectureId);
        Pageable pageable = new PageRequest(page, size, Sort.Direction.DESC, "score");
        if (searchedBy != null) {
            Page<Question> questionPage = questionRepository.findByLectureAndDeletedFalse(pageable, searchedBy);
            return initializeQuestion(questionPage);
        }
        return new PageImpl<>(new ArrayList<>(), pageable, 0);
    }
}
