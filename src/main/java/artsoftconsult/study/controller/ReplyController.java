package artsoftconsult.study.controller;

import artsoftconsult.study.model.Reply;
import artsoftconsult.study.model.User;
import artsoftconsult.study.service.QuestionService;
import artsoftconsult.study.service.ReplyService;
import artsoftconsult.study.service.UserService;
import org.modelmapper.ModelMapper;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class ReplyController {

    @Autowired
    private ReplyService replyService;

    @Autowired
    private UserService userService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private ModelMapper modelMapper;

    @RequestMapping(value = "/makeReply", method = RequestMethod.POST)
    public @ResponseBody
    Boolean makeReply(@RequestParam("content") String content, @RequestParam("questionId") Long questionId) {
        User user = getCurrentUser();
        if (user != null) {
            Reply reply = new Reply();
            reply.setUser(user);
            reply.setContent(content);
            return replyService.save(reply, questionId);
        }
        return false;
    }

    @RequestMapping(value = "/voteReply", method = RequestMethod.POST, produces = "application/json")
    public @ResponseBody
    Boolean makeVote(HttpServletRequest request, HttpServletResponse response, @RequestParam("type") String type, @RequestParam("replyId") Long replyId) {
        replyService.vote(replyId, getCurrentUser().getUserId(), type);
        return true;
    }

    @RequestMapping(value = "/deleteReply", method = RequestMethod.POST)
    public @ResponseBody
    Boolean toggleReplyStatus(@RequestParam("replyId") Long replyId, HttpServletResponse response) {
        replyService.delete(replyId, getCurrentUser().getUserId());
        return true;
    }

    @RequestMapping(value = "/editReply", method = RequestMethod.POST)
    public @ResponseBody
    Boolean makeEdit(@RequestParam("content") String content, @RequestParam("replyId") Long replyId) {
        User user = getCurrentUser();
        if (user != null) {
            Reply reply = new Reply();
            reply.setUser(user);
            reply.setContent(content);
            reply.setReplyId(replyId);
            replyService.update(reply);
            return true;
        }
        return false;
    }


    @RequestMapping(value = "/favoriteReply", method = RequestMethod.POST)
    public @ResponseBody
    Boolean makeFavorite(@RequestParam("questionId") Long questionId, @RequestParam("replyId") Long replyId, HttpServletResponse response) {
        User user = getCurrentUser();
        if (user != null) {
            replyService.favorite(replyId, questionId, user.getUserId());
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



