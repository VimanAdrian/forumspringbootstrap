package artsoftconsult.study.controller;

import artsoftconsult.study.dto.model.QuestionDTO;
import artsoftconsult.study.dto.model.ReplyDTO;
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
import org.springframework.web.bind.annotation.*;

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
    Boolean makeReply(@ModelAttribute("ReplyDTO") ReplyDTO reply, @ModelAttribute("QuestionDTO") QuestionDTO questionDto) {
        User user = getCurrentUser();
        if (user != null) {
            Reply replyFromDto = new Reply();
            modelMapper.map(reply, replyFromDto);
            replyFromDto.setUser(user);
            replyFromDto.setQuestion(questionService.find(questionDto.getQuestionId(), null));
            return replyService.save(replyFromDto);
        }
        return false;
    }

    @RequestMapping(value = "/voteReply", method = RequestMethod.POST, produces = "application/json")
    public @ResponseBody
    Boolean makeVote(HttpServletRequest request, HttpServletResponse response, @RequestParam("type") String type, @RequestParam("replyId") Long replyId) {
        replyService.vote(replyId, getCurrentUser().getUserId(), type);
        return true;
    }

    @RequestMapping(value = "/toggleReplyStatus", method = RequestMethod.POST)
    public @ResponseBody
    Boolean toggleReplyStatus(@RequestParam("replyId") Long replyId, HttpServletResponse response) {
        replyService.toggleStatus(replyId);
        return true;
    }

    @RequestMapping(value = "/editReply", method = RequestMethod.POST)
    public @ResponseBody
    Boolean makeEdit(@ModelAttribute("ReplyDTO") ReplyDTO replyDTO) {
        User user = getCurrentUser();
        if (user != null) {
            Reply reply = new Reply();
            modelMapper.map(replyDTO, reply);

            reply.setUser(user);
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



