package artsoftconsult.study.controller;

import artsoftconsult.study.service.PostService;
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
public class PostController {

    @Autowired
    private PostService postService;
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/makePost", method = RequestMethod.POST)
    public void makePost(@ModelAttribute("Post") Post post, @RequestParam("tags") String tags, HttpServletRequest request, HttpServletResponse response) {
        User user = new User();
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetail = (UserDetails) auth.getPrincipal();
            user.setUsername(userDetail.getUsername());
        }
        post.setUser(user);
        //String tags = request.getParameter("tags");
        Integer saveResponse = postService.saveHibernate(post, tags);
        if (saveResponse != -1)
            try {
                String redirect = "/post?postID=" + saveResponse + "&page=" + 0;
                response.sendRedirect(redirect);
            } catch (IOException e) {
                e.printStackTrace();
            }
        else
            try {
                response.sendRedirect("post?error");
            } catch (IOException e) {
                e.printStackTrace();
            }
    }

    //without ajax
        /*
    @RequestMapping(value = "/votePost", method = RequestMethod.POST)
    public void makeVote(HttpServletRequest request, HttpServletResponse response, @RequestParam("page") String page) {
        String postID = request.getParameter("postID");
        String type = request.getParameter("type");
        postService.vote(Integer.valueOf(postID), userService.find(request.getUserPrincipal().getName()).getUserId(), type);
        try {
            String redirect = "/post?postID=" + postID + "&page=" + page;
            response.sendRedirect(redirect);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
        */

    @RequestMapping(value = "/votePost", method = RequestMethod.POST, produces = "application/json")
    public @ResponseBody
    boolean makeVote(HttpServletRequest request, HttpServletResponse response, @RequestParam("postID") String postId, @RequestParam("type") String type) {
        return postService.vote(Integer.valueOf(postId), userService.find(request.getUserPrincipal().getName()).getUserId(), type);
    }

    @RequestMapping(value = "/togglePostStatus", method = RequestMethod.POST)
    public @ResponseBody
    boolean makeDelete(HttpServletRequest request, HttpServletResponse response, @RequestParam("postID") String postID) {
        boolean succes = postService.togglePostStatus(Integer.valueOf(postID));
        return succes;
    }

    @RequestMapping(value = "/editPost", method = RequestMethod.POST)
    public @ResponseBody Boolean makeEdit(@ModelAttribute("Post") Post post) {
        postService.update(post);
        return true;
    }

}
