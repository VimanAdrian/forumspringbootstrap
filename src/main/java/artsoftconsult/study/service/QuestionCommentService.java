package artsoftconsult.study.service;

import artsoftconsult.study.model.Question;
import artsoftconsult.study.model.QuestionComment;
import artsoftconsult.study.model.User;
import artsoftconsult.study.repository.QuestionCommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.sql.Date;

@Service
public class QuestionCommentService {

    @Autowired
    private UserService userService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private QuestionCommentRepository questionCommentRepository;

    public Boolean save(Long parentId, String content) {
        User user = getCurrentUser();
        Question question = questionService.find(parentId);
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
