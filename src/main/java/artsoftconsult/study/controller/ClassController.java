package artsoftconsult.study.controller;

import artsoftconsult.study.model.User;
import artsoftconsult.study.service.UserService;
import artsoftconsult.study.service.VirtualClassService;
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
public class ClassController {

    @Autowired
    private UserService userService;

    @Autowired
    private VirtualClassService virtualClassService;

    private User getCurrentUser() {
        User user = null;
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetail = (UserDetails) auth.getPrincipal();
            user = userService.find(userDetail.getUsername());
        }
        return user;
    }

    @RequestMapping(value = "/newClass", method = RequestMethod.POST)
    public @ResponseBody
    Long
    newClass(@RequestParam("title") String[] title, @RequestParam("content") String content, @RequestParam("tags") String tags, HttpServletRequest request, HttpServletResponse response) {
        User user = getCurrentUser();
        if (user != null) {
            Long saveResponse = virtualClassService.save(title, content, tags, user);
            return saveResponse;
        }
        return -1l;
    }

}
