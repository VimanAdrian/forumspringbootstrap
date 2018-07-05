package artsoftconsult.study.service;

import artsoftconsult.study.model.Lecture;
import artsoftconsult.study.model.Question;
import artsoftconsult.study.model.VirtualClass;
import artsoftconsult.study.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AdminService {

    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private LectureRepository lectureRepository;
    @Autowired
    private PageRepository pageRepository;
    @Autowired
    private PageCommentRepository pageCommentRepository;
    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private ReplyRepository replyRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private VirtualClassRepository virtualClassRepository;

    @Transactional
    public void deleteQuestion(Long questionId) {
        Question question = questionRepository.findByQuestionIdAndDeletedFalse(questionId);
        question.getReplies().forEach(reply -> deleteReply(reply.getReplyId()));
        questionRepository.logicalDelete(questionId);
    }

    @Transactional
    public void deleteReply(Long replyId) {
        replyRepository.logicalDelete(replyId);
    }

    @Transactional
    public void deleteClass(Long classId) {
        VirtualClass virtualClass = virtualClassRepository.findByVirtualClassIdAndDeletedFalse(classId);
        virtualClass.getLectures().forEach(lecture -> {
            lecture.getPages().forEach(page -> deletePage(page.getPageId()));
            deleteLecture(lecture.getLectureId());
        });
        virtualClassRepository.logicalDelete(classId);
    }

    @Transactional
    public void deleteLecture(Long lectureId) {
        Lecture lecture = lectureRepository.findByLectureIdAndDeletedFalse(lectureId);
        lecture.getPages().forEach(page -> deletePage(page.getPageId()));
        lectureRepository.logicalDelete(lectureId);
    }

    @Transactional
    public void deletePage(Long pageId) {
        pageRepository.logicalDelete(pageId);
    }
}
