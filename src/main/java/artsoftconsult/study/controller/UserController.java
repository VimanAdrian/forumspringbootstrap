package artsoftconsult.study.controller;

import artsoftconsult.study.dto.model.UserDTO;
import artsoftconsult.study.model.User;
import artsoftconsult.study.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.Serializable;

@Controller
public class UserController implements Serializable {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public @ResponseBody
    Integer register(@ModelAttribute("UserDTO") UserDTO user) {
        return userService.save(user);
    }

    @RequestMapping(value = "/updateUser", method = RequestMethod.POST)
    public @ResponseBody
    Integer update(@ModelAttribute("UserDTO") UserDTO user) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetail = (UserDetails) auth.getPrincipal();
            return userService.updateUser(user, userDetail.getUsername());
        }
        return -3;
    }

    @RequestMapping(value = "/forgotPassword", method = RequestMethod.POST)
    public @ResponseBody
    Boolean sendPasswordReset(@ModelAttribute("User") UserDTO user, HttpServletResponse response) {
        return userService.sendPasswordReset(user);
    }

    @RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
    public @ResponseBody
    Boolean resetPassword(@ModelAttribute("User") UserDTO user, HttpServletResponse response) {
        return userService.resetPassword(user);
    }

    @RequestMapping(value = "/resendToken", method = RequestMethod.POST)
    public @ResponseBody
    Boolean resendToken(@RequestParam("userId") Long userId) {
        return userService.resendToken(userId);
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