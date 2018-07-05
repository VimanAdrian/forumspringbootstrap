package artsoftconsult.study.controller;

import artsoftconsult.study.model.User;
import artsoftconsult.study.service.AdminService;
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
public class AdminController {

    @Autowired
    private UserService userService;
    @Autowired
    private AdminService adminService;

    private User getCurrentUser() {
        User user = null;
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetail = (UserDetails) auth.getPrincipal();
            user = userService.find(userDetail.getUsername());
        }
        return user;
    }

    @RequestMapping(value = "/adminDeleteQuestion", method = RequestMethod.POST)
    public @ResponseBody
    Boolean deleteQuestion(@RequestParam("id") Long id) {
        if (getCurrentUser().getRole().equals("ROLE_ADMIN")) {
            adminService.deleteQuestion(id);
            return true;
        }
        return false;
    }

    @RequestMapping(value = "/adminDeleteReply", method = RequestMethod.POST)
    public @ResponseBody
    Boolean deleteReply(@RequestParam("id") Long id) {
        if (getCurrentUser().getRole().equals("ROLE_ADMIN")) {
            adminService.deleteReply(id);
            return true;
        }
        return false;
    }

    @RequestMapping(value = "/adminDeleteClass", method = RequestMethod.POST)
    public @ResponseBody
    Boolean deleteClass(@RequestParam("id") Long id) {
        if (getCurrentUser().getRole().equals("ROLE_ADMIN")) {
            adminService.deleteClass(id);
            return true;
        }
        return false;
    }

    @RequestMapping(value = "/adminDeleteLecture", method = RequestMethod.POST)
    public @ResponseBody
    Boolean deleteLecture(@RequestParam("id") Long id) {
        if (getCurrentUser().getRole().equals("ROLE_ADMIN")) {
            adminService.deleteLecture(id);
            return true;
        }
        return false;
    }

    @RequestMapping(value = "/adminDeletePage", method = RequestMethod.POST)
    public @ResponseBody
    Boolean deletePage(@RequestParam("id") Long id) {
        if (getCurrentUser().getRole().equals("ROLE_ADMIN")) {
            adminService.deletePage(id);
            return true;
        }
        return false;
    }

}
