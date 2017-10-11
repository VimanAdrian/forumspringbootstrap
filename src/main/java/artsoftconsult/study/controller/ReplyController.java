package artsoftconsult.study.controller;

import artsoftconsult.study.model.Post;
import artsoftconsult.study.model.Reply;
import artsoftconsult.study.model.User;
import artsoftconsult.study.service.ReplyService;
import artsoftconsult.study.service.UserService;
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
public class ReplyController {

    @Autowired
    private ReplyService replyService;
    @Autowired
    private UserService userService;

    public ReplyController() {
    }

    @RequestMapping(value = "/makeReply", method = RequestMethod.POST)
    public void makeReply(@ModelAttribute("Reply") Reply reply, @ModelAttribute("Post") Post post, @RequestParam("page") String page, HttpServletResponse response) {
        User user = new User();
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetail = (UserDetails) auth.getPrincipal();
            user.setUsername(userDetail.getUsername());
        }
        reply.setUser(user);
        reply.setPost(post);
        //System.out.println(reply);
        if (replyService.save(reply)) {
            try {
                response.sendRedirect("/post?postID=" + post.getPostId() + "&page=" + page);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    //without ajax
    /*
    @RequestMapping(value = "/voteReply", method = RequestMethod.POST)
    public void makeVote(HttpServletRequest request,
                         HttpServletResponse response,
                         @RequestParam("postID") String postID,
                         @RequestParam("page") String page,
                         @RequestParam("replyID") String replyID,
                         @RequestParam("type") String type) {
        replyService.vote(Integer.valueOf(replyID), userService.find(request.getUserPrincipal().getName()).getUserId(), type);
        try {
            String redirect = "/post?postID=" + postID + "&page=" + page;
            response.sendRedirect(redirect);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    */

    @RequestMapping(value = "/voteReply", method = RequestMethod.POST, produces = "application/json")
    public @ResponseBody
    boolean makeVote(HttpServletRequest request, HttpServletResponse response, @RequestParam("type") String type, @RequestParam("replyID") String replyID) {
        System.out.println(type);
        System.out.println(replyID);
        System.out.println();
        return replyService.vote(Integer.valueOf(replyID), userService.find(request.getUserPrincipal().getName()).getUserId(), type);
    }

    @RequestMapping(value = "/favoriteReply", method = RequestMethod.POST)
    public void makeFavorite(@RequestParam("postID") String postID, @RequestParam("replyID") String replyID, @RequestParam("page") String page, HttpServletResponse response) {
        replyService.favorite(Integer.valueOf(replyID), Integer.valueOf(postID));
        try {
            String redirect = "/post?postID=" + postID + "&page=" + page;
            response.sendRedirect(redirect);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/toggleReplyStatus", method = RequestMethod.POST)
    public void toggleReplyStatus(@RequestParam("replyID") String replyID, @RequestParam("page") String page, @RequestParam("postID") String postID, HttpServletResponse response) {
        replyService.toggleStatus(Integer.valueOf(replyID));
        try {
            String redirect = "/post?postID=" + postID + "&page=" + page;
            response.sendRedirect(redirect);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}



