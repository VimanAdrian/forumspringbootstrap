package artsoftconsult.study.controller;

import artsoftconsult.study.dto.model.QuestionDTO;
import artsoftconsult.study.model.Question;
import artsoftconsult.study.model.User;
import artsoftconsult.study.service.QuestionService;
import artsoftconsult.study.service.UserService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class QuestionController {

    @Autowired
    private QuestionService questionService;
    @Autowired
    private UserService userService;
    @Autowired
    private ModelMapper modelMapper;

    @RequestMapping(value = "/askQuestion", method = RequestMethod.POST)
    public void makePost(@RequestParam("title") String title, @RequestParam("content") String content, @RequestParam("tags") String tags, HttpServletRequest request, HttpServletResponse response) {
        User user = getCurrentUser();
        if (user!=null) {
            Long saveResponse = questionService.save(title, content, tags, user);
            if (saveResponse != -1)
                try {
                    String redirect = "/question?questionId=" + saveResponse;
                    response.sendRedirect(redirect);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            else
                try {
                    response.sendRedirect("question?error");
                } catch (IOException e) {
                    e.printStackTrace();
                }
        }
    }

    @RequestMapping(value = "/voteQuestion", method = RequestMethod.POST, produces = "application/json")
    public @ResponseBody
    boolean makeVote(HttpServletRequest request, HttpServletResponse response, @RequestParam("questionId") Long questionId, @RequestParam("type") String type) {
        questionService.vote(questionId, getCurrentUser().getUserId(), type);
        return true;
    }

    @RequestMapping(value = "/toggleQuestionStatus", method = RequestMethod.POST)
    public @ResponseBody
    boolean makeDelete(HttpServletRequest request, HttpServletResponse response, @RequestParam("questionId") Long questionId) {
        return questionService.toggleQuestionStatus(questionId);
    }

    @RequestMapping(value = "/editQuestion", method = RequestMethod.POST)
    public @ResponseBody Boolean makeEdit(@ModelAttribute("QuestionDTO") QuestionDTO questionDTO) {
        User user = getCurrentUser();
        if (user!=null) {
            Question question = new Question();
            modelMapper.map(questionDTO, question);

            question.setUser(user);

            questionService.update(question);
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
