package artsoftconsult.study.service;

import artsoftconsult.study.model.*;
import artsoftconsult.study.repository.PageCommentRepository;
import artsoftconsult.study.repository.PageRepository;
import artsoftconsult.study.repository.QuestionCommentRepository;
import artsoftconsult.study.repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.sql.Date;

@Service
public class CommentService {

    @Autowired
    private UserService userService;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private QuestionCommentRepository questionCommentRepository;

    @Autowired
    private PageRepository pageRepository;

    @Autowired
    private PageCommentRepository pageCommentRepository;

    public Boolean saveQuestionComment(Long parentId, String content) {
        User user = getCurrentUser();
        Question question = questionRepository.findByQuestionId(parentId);
        if ((user != null) && (question != null)) {
            QuestionComment questionComment = new QuestionComment();
            questionComment.setQuestion(question);
            questionComment.setUser(user);
            questionComment.setContent(content);
            questionComment.setCreationDate(new Date(System.currentTimeMillis()));
            if (questionCommentRepository.saveAndFlush(questionComment) != null)
                return true;
        }
        return false;
    }

    public Boolean savePageComment(Long parentId, String content) {
        User user = getCurrentUser();
        Page page = pageRepository.findByPageId(parentId);
        if ((user != null) && (page != null)) {
            PageComment pageComment = new PageComment();
            pageComment.setPage(page);
            pageComment.setUser(user);
            pageComment.setContent(content);
            pageComment.setCreationDate(new Date(System.currentTimeMillis()));
            if (pageCommentRepository.saveAndFlush(pageComment) != null)
                return true;
        }
        return false;
    }

    private User getCurrentUser() {
        User user = null;
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetail = (UserDetails) auth.getPrincipal();
            user = userService.find(userDetail.getUsername());
        }
        return user;
    }

}
