package artsoftconsult.study.service;

import artsoftconsult.study.model.Category;
import artsoftconsult.study.model.Lecture;
import artsoftconsult.study.model.Question;
import artsoftconsult.study.model.VirtualClass;
import artsoftconsult.study.repository.*;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Transactional
    public Page<Question> searchQuestionByTag(String tag, Integer page, Integer size) {
        Category searchedBy = categoryRepository.findByUrl(tag);
        Pageable pageable = new PageRequest(page, size, Sort.Direction.DESC, "score");
        if (searchedBy != null) {
            Page<Question> questionPage = questionRepository.findByQuestionCategoriesAndDeletedFalse(pageable, searchedBy);
            Hibernate.initialize(questionPage);
            return questionPage;
        } else return new PageImpl<Question>(new ArrayList<>(), pageable, 0);
    }

    @Transactional
    public Page<VirtualClass> searchVirtualClassByTag(String tag, Integer page, Integer size) {
        Category searchedBy = categoryRepository.findByUrl(tag);
        Pageable pageable = new PageRequest(page, size, Sort.Direction.DESC, "score");
        if (searchedBy != null) {
            Page<VirtualClass> virtualClassPage = virtualClassRepository.findByVirtualClassCategoriesAndDeletedFalse(pageable, searchedBy);
            Hibernate.initialize(virtualClassPage);
            return virtualClassPage;
        } else return new PageImpl<VirtualClass>(new ArrayList<>(), pageable, 0);
    }

    public Page<Lecture> searchLectureByTag(String tag, Integer page, Integer size) {
        return null;
    }

    public Page<Question> searchQuestionByFreeText(String search, Integer page, Integer size) {
        Pageable pageable = new PageRequest(page, size, Sort.Direction.DESC, "score");
        Page<Question> questionPage = questionRepository.findByTitleContainingOrContentContainingAndDeletedFalse(pageable, search, search);
        Hibernate.initialize(questionPage);
        return questionPage;
    }

    public Page<VirtualClass> searchVirtualClassByFreeText(String search, Integer page, Integer size) {
        Pageable pageable = new PageRequest(page, size, Sort.Direction.DESC, "score");
        Page<VirtualClass> questionPage = virtualClassRepository.findByTitleContainingOrDescriptionContainingAndDeletedFalse(pageable, search, search);
        Hibernate.initialize(questionPage);
        return questionPage;
    }

    public Page<Lecture> searchLectureByFreeText(String search, Integer page, Integer size) {
        Pageable pageable = new PageRequest(page, size, Sort.Direction.DESC, "score");
        Page<Lecture> questionPage = lectureRepository.findByTitleContainingOrDescriptionContainingAndDeletedFalse(pageable, search, search);
        Hibernate.initialize(questionPage);
        return questionPage;
    }
}
