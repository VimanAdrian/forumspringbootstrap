package artsoftconsult.study.controller;

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
import java.io.IOException;
import java.io.Serializable;

@Controller
public class UserController implements Serializable {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public @ResponseBody
    Boolean register(@ModelAttribute("User") User user, HttpServletResponse response) {
        return userService.save(user);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public void update(@ModelAttribute("User") User user, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetail = (UserDetails) auth.getPrincipal();
            user.setUsername(userDetail.getUsername());
        }
        if (userService.updateUser(user))
            try {
                response.sendRedirect("/update?updateSuccess");
            } catch (IOException e) {
                e.printStackTrace();
            }
        else
            try {
                response.sendRedirect("/update?updateFailed");
            } catch (IOException e) {
                e.printStackTrace();
            }
    }

    @RequestMapping(value = "/makeAdmin", method = RequestMethod.POST)
    public void makeAdmin(@ModelAttribute("User") User user,
                          @RequestParam(value = "page", required = false) String page,
                          @RequestParam(value = "user", required = false) String username,
                          HttpServletResponse response) {
        //System.out.println(page);
        boolean succes = userService.makeAdmin(user);
        if (username != null) {
            try {
                response.sendRedirect("/account?username=" + username);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else if (succes)
            try {
                response.sendRedirect("/admin/users?page=" + page + "&adminSucces");
            } catch (IOException e) {
                e.printStackTrace();
            }
        else
            try {
                response.sendRedirect("/admin/users?page=" + page + "&error");
            } catch (IOException e) {
                e.printStackTrace();
            }
    }

    @RequestMapping(value = "/toggleEnabled", method = RequestMethod.POST)
    public void toggleEnabled(@ModelAttribute("User") User user,
                              @RequestParam(value = "page", required = false) String page,
                              @RequestParam(value = "user", required = false) String username,
                              HttpServletResponse response) {
        Integer res = userService.toggleEnabled(user);
        if (username != null) {
            try {
                response.sendRedirect("/account?username=" + username);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else if (res == 1)
            try {
                response.sendRedirect("/admin/users?page=" + page + "&enableSucces");
            } catch (IOException e) {
                e.printStackTrace();
            }
        else if (res == 2)
            try {
                response.sendRedirect("/admin/users?page=" + page + "&disableSucces");
            } catch (IOException e) {
                e.printStackTrace();
            }
        else
            try {
                response.sendRedirect("/admin/users?page=" + page + "&error");
            } catch (IOException e) {
                e.printStackTrace();
            }
    }

    @RequestMapping(value = "/forgotPassword", method = RequestMethod.POST)
    public @ResponseBody
    Boolean sendPasswordReset(@ModelAttribute("User") User user, HttpServletResponse response) {
        user = userService.find(user.getUsername());
        if (user.getEmail() != null) {
            return userService.sendPasswordReset(user);
        } else {
            return false;
        }
    }

    @RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
    public @ResponseBody
    Boolean resetPassword(@ModelAttribute("User") User user, HttpServletResponse response) {
        return userService.resetPassword(user);
    }

}