package artsoftconsult.study.controller;

import artsoftconsult.study.dto.model.QuestionDTO;
import artsoftconsult.study.dto.model.UserDTO;
import artsoftconsult.study.model.Question;
import artsoftconsult.study.model.User;
import artsoftconsult.study.service.CategoryService;
import artsoftconsult.study.service.QuestionService;
import artsoftconsult.study.service.ReplyService;
import artsoftconsult.study.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
public class MainController {

    @Autowired
    private UserService userService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ReplyService replyService;

    private ModelAndView addUserInfo(ModelAndView modelAndView) {
        User user = getCurrentUser();
        if (user != null) {
            modelAndView.addObject("user", user);
            modelAndView.addObject("newAnswers", false);
            modelAndView.addObject("topQuestions", false);
            List<Question> newAnswers = userService.newAnswers(user);
            List<Question> topQuestions = userService.topQuestions(user);
            if (newAnswers.size() > 0) {
                Question[] list = newAnswers.toArray(new Question[0]);
                modelAndView.addObject("newAnswers", true);
                modelAndView.addObject("answerList", list);
            }
            if (topQuestions.size() > 0) {
                Question[] list2 = topQuestions.toArray(new Question[0]);
                modelAndView.addObject("topQuestions", true);
                modelAndView.addObject("questionList", list2);
            }
        }
        return modelAndView;
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView goToDefaultPage() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("bootstrapUserPage");
        return addUserInfo(modelAndView);
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView goToLogin() {
        ModelAndView model = new ModelAndView();
        model.setViewName("bootstrapUserPage");
        model.addObject("modal", true);
        return addUserInfo(model);
    }

    @RequestMapping(value = "/newQuestion", method = RequestMethod.GET)
    public ModelAndView goToNewPost() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("bootstrapNewQuestion");
        return addUserInfo(modelAndView);
    }

    @RequestMapping(value = "/newClass", method = RequestMethod.GET)
    public ModelAndView goToNewClass() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("bootstrapNewClass");
        return addUserInfo(modelAndView);
    }

    @RequestMapping(value = "/account", method = RequestMethod.GET)
    public ModelAndView goToAccount(@RequestParam(value = "username", required = false) String username, HttpServletResponse response) {
        ModelAndView model = new ModelAndView();
        model.setViewName("deprecated/accountPage");
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (username == null) {
            if (!(auth instanceof AnonymousAuthenticationToken)) {
                UserDetails userDetail = (UserDetails) auth.getPrincipal();
                model.addObject("user", userService.find(userDetail.getUsername()));
                model.addObject("myAccount", true);
                return model;
            } else {
                try {
                    response.sendRedirect("/");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        } else {
            if (!(auth instanceof AnonymousAuthenticationToken)) {
                UserDetails userDetail = (UserDetails) auth.getPrincipal();
                if (username.equals(userDetail.getUsername())) {
                    model.addObject("user", userService.find(username));
                    model.addObject("myAccount", true);
                    return model;
                }
            } else {
                model.addObject("user", userService.find(username));
                model.addObject("myAccount", false);
            }
        }
        return model;
    }

    @RequestMapping(value = "/question", method = RequestMethod.GET)
    public ModelAndView goToPost(@RequestParam(value = "questionId", required = true) Long questionId, HttpServletRequest request) {
        ModelAndView model = new ModelAndView();
        User user = getCurrentUser();
        QuestionDTO question = questionService.find(questionId, user);
        model.addObject("question", question);
        model.setViewName("bootstrapQuestionPage");
        return addUserInfo(model);
    }

    @RequestMapping(value = "class", method = RequestMethod.GET)
    public ModelAndView goToClass(@RequestParam(value = "classId", required = true) Long classId) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("bootstrapUserPage");
        return addUserInfo(modelAndView);
    }

    //deprecated
    @RequestMapping(value = "/activate", method = RequestMethod.GET)
    public ModelAndView activateAccount(@RequestParam(value = "token", required = false) String token,
                                        @RequestParam(value = "userId", required = true) String id,
                                        @RequestParam(value = "retryToken", required = false) String retryToken) {
        ModelAndView modelAndView = new ModelAndView();
        if (retryToken == null) {
            if (userService.useToken(token, Long.valueOf(id))) {
                modelAndView.setViewName("deprecated/login");
                modelAndView.addObject("msg", "Account activated successfully");
            } else {
                modelAndView.setViewName("deprecated/accountActivate");
                modelAndView.addObject("succes", false);
            }
            return modelAndView;
        } else {
            modelAndView.setViewName("deprecated/accountActivate");
            modelAndView.addObject("succes", true);
            UserDTO user = new UserDTO();
            user.setUserId(Long.valueOf(id));
            try {
                userService.sendToken(userService.find(user.getUserId()));
            } catch (Exception e) {
                modelAndView.addObject("succes", false);
            }
        }
        return modelAndView;
    }

    @RequestMapping(value = "/reset", method = RequestMethod.GET)
    public ModelAndView resetPassword(@RequestParam(value = "token", required = true) String token,
                                      @RequestParam(value = "userId", required = true) String id) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("bootstrapUserPage");
        modelAndView.addObject("userID", id);
        modelAndView.addObject("modal", true);
        if (userService.usePasswordReset(token, Long.valueOf(id))) {
            modelAndView.addObject("validToken", 1);
        } else {
            modelAndView.addObject("validToken", 0);
        }
        return modelAndView;
    }

    @RequestMapping(value = "/forgotPassword", method = RequestMethod.GET)
    public ModelAndView goToForgotPassword() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("deprecated/accountForgotPassword");
        return modelAndView;
    }

    //for 403 access denied page
    @RequestMapping(value = "/403", method = RequestMethod.GET)
    public ModelAndView goToAccesssDenied() {
        ModelAndView model = new ModelAndView();
        //check if user is login
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetail = (UserDetails) auth.getPrincipal();
            model.addObject("username", userDetail.getUsername());
        }
        model.setViewName("deprecated/403");
        return model;
    }

    //customize the error message
    private String getErrorMessage(HttpServletRequest request, String key) {

        Exception exception = (Exception) request.getSession().getAttribute(key);

        String error = "";
        if (exception instanceof BadCredentialsException) {
            error = "Invalid username and password!";
        } else if (exception instanceof DisabledException) {
            error = "You need to activate your account!";
        } else if (exception instanceof LockedException) {
            error = "Your account is locked!";
        } else {
            error = "Something went wrong with the login process...";
        }

        return error;
    }

    /**
     * Check if user is login by remember me cookie, refer
     * org.springframework.security.authentication.AuthenticationTrustResolverImpl
     */
    private boolean isRememberMeAuthenticated() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            return false;
        }
        return RememberMeAuthenticationToken.class.isAssignableFrom(authentication.getClass());
    }

    /**
     * save targetURL in session
     */
    private void setRememberMeTargetUrlToSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.setAttribute("targetUrl", "/admin/update");
        }
    }

    /**
     * get targetURL from session
     */
    private String getRememberMeTargetUrlFromSession(HttpServletRequest request) {
        String targetUrl = "";
        HttpSession session = request.getSession(false);
        if (session != null) {
            targetUrl = session.getAttribute("targetUrl") == null ? ""
                    : session.getAttribute("targetUrl").toString();
        }
        return targetUrl;
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