package artsoftconsult.study.controller;

import artsoftconsult.study.model.User;
import artsoftconsult.study.service.QuestionCommentService;
import artsoftconsult.study.service.QuestionService;
import artsoftconsult.study.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class QuestionCommentController {

    @Autowired
    private UserService userService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private QuestionCommentService questionCommentService;

    @RequestMapping(value = "/makeQuestionComment", method = RequestMethod.POST)
    public @ResponseBody
    Boolean makeQuestionComment(@RequestParam("parentId") Long parentId, @RequestParam("content") String content) {
        return questionCommentService.save(parentId, content);
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
