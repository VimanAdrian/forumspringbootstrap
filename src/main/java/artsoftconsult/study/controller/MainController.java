package artsoftconsult.study.controller;

import artsoftconsult.study.model.Post;
import artsoftconsult.study.model.User;
import artsoftconsult.study.service.CategoryService;
import artsoftconsult.study.service.PostService;
import artsoftconsult.study.service.ReplyService;
import artsoftconsult.study.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.RememberMeAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Controller
public class MainController {

    @Autowired
    private UserService userService;

    @Autowired
    private PostService postService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ReplyService replyService;

    @RequestMapping(value = "/bootstrapLogin", method = RequestMethod.GET)
    public ModelAndView goToBootstrapLogin(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("bootstrapNavigation");
        return modelAndView;
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView goToDefaultPage() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("bootstrapNavigation");
        return modelAndView;
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView goToLogin(@RequestParam(value = "loginFailure", required = false) String loginFailure,
                                  @RequestParam(value = "logoutSuccess", required = false) String logoutSuccess,
                                  @RequestParam(value = "resetSuccess", required = false) String resetSuccess,
                                  @RequestParam(value = "resetFailure", required = false) String resetFailure,
                                  @RequestParam(value = "sendSuccess", required = false) String sendSuccess,
                                  @RequestParam(value = "sendFailure", required = false) String sendFailure,
                                  @RequestParam(value = "registerSuccess", required = false) String registerSuccess,
                                  @RequestParam(value = "registerFailure", required = false) String registerFailure,
                                  HttpServletRequest request) {
        ModelAndView model = new ModelAndView();
        model.addObject("modal", true);
        if (loginFailure != null) {
            model.addObject("loginFailure", "Invalid username and password!");
        }
        if (logoutSuccess != null) {
            model.addObject("logoutSuccess", "You've been logged out successfully!");
        }
        if (resetSuccess != null) {
            model.addObject("resetSuccess", "Password reset successful!");
        }
        if(resetFailure != null){
            model.addObject("resetFailure", "Password reset failed!");
        }
        if (sendSuccess != null) {
            model.addObject("sendSuccess", "Email was sent successfully!");
        }
        if(sendFailure != null){
            model.addObject("sendFailure", "Email failed to send!");
        }
        if (registerSuccess != null) {
            model.addObject("registerSuccess", "You've been registered successfully.");
        }
        if(registerFailure != null){
            model.addObject("registerFailure", "Register failed!");
        }

        model.setViewName("bootstrapNavigation");
        return model;
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView goToRegister(@RequestParam(value = "error", required = false) String error, @RequestParam(value = "message", required = false) String message) {
        ModelAndView model = new ModelAndView();
        if (error != null) {
            model.addObject("error", "Something went wrong...");
        }
        if (message != null) {
            model.addObject("msg", "Registered successfully. Check your email to activate your account.");
        }
        model.setViewName("register");
        return model;
    }

    @RequestMapping(value = "/update", method = RequestMethod.GET)
    public ModelAndView goToUpdate(@RequestParam(value = "error", required = false) String error,
                                   @RequestParam(value = "makeAdmin", required = false) String makeAdmin) {
        ModelAndView model = new ModelAndView();
        if (error != null) {
            model.addObject("error", "Something went wrong...");
        }
        if (makeAdmin != null) {
            model.addObject("msg", "Updated successfully.");
        }
        model.addObject("user", userService.find(getCurrentUser()));
        model.setViewName("accountUpdate");
        return model;
    }

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public ModelAndView goToAdminPage() {
        ModelAndView model = new ModelAndView();
        model.setViewName("adminIndex");
        return model;
    }

    @RequestMapping(value = "/admin/users", method = RequestMethod.GET)
    public ModelAndView goToAdminUsersPage(@RequestParam(value = "page", required = true) String page,
                                           @RequestParam(value = "error", required = false) String error,
                                           @RequestParam(value = "adminSucces", required = false) String adminSucces,
                                           @RequestParam(value = "disableSucces", required = false) String disableSucces,
                                           @RequestParam(value = "enableSucces", required = false) String enableSucces) {
        ModelAndView modelAndView = new ModelAndView();
        if (error != null) {
            modelAndView.addObject("error", "Something went wrong...");
        }
        if (adminSucces != null) {
            modelAndView.addObject("adminSucces", "Users is now admin!");
        }
        if (disableSucces != null) {
            modelAndView.addObject("disableSucces", "User is now disabled!");
        }
        if (enableSucces != null) {
            modelAndView.addObject("enableSucces", "User is now enabled!");
        }
        modelAndView.addObject("userList", userService.getUserList(page));
        modelAndView.addObject("url", "/admin/users?page=");
        modelAndView.addObject("nrPagini", userService.getUserListNext());
        modelAndView.setViewName("adminUsers");
        return modelAndView;
    }

    @RequestMapping(value = "/admin/posts", method = RequestMethod.GET)
    public ModelAndView goToAdminPostsPage() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("postSearchResults");
        return modelAndView;
    }

    @RequestMapping(value = "/post", method = RequestMethod.GET)
    public ModelAndView goToPost(@RequestParam(value = "error", required = false) String error,
                                 @RequestParam(value = "postID", required = false) String postID,
                                 @RequestParam(value = "search", required = false) String search,
                                 @RequestParam(value = "page", required = false) String page,
                                 @RequestParam(value = "browse", required = false) String browse,
                                 @RequestParam(value = "disabled", required = false) String disabled,
                                 @RequestParam(value = "tag", required = false) String tag,
                                 @RequestParam(value = "user", required = false) String userID,
                                 HttpServletRequest request) {

        ModelAndView model = new ModelAndView();
        if (error != null) {
            model.addObject("error", "Something went wrong...");
            model.setViewName("postForm");
            return model;
        }
        if (postID != null) {
            Integer nrPagini = replyService.postNrPages(postID, request.isUserInRole("ROLE_ADMIN"));
            String url = "/post?postID=" + postID + "&page=";
            User user = new User();
            user.setAdmin(false);
            user.setUsername("unauthenticated");
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (!(auth instanceof AnonymousAuthenticationToken)) {
                user.setAdmin(request.isUserInRole("ROLE_ADMIN"));
                user.setUsername(request.getUserPrincipal().getName());
            }
            Post post = postService.find(postID, user, page);
            model.addObject("bestReply", replyService.bestReply(postID, user.getUsername()));
            model.addObject("url", url);
            model.addObject("nrPagini", nrPagini);
            model.addObject("post", post);
            model.addObject("voteType", postService.voteTypesAvailable(Integer.valueOf(postID), userService.find(user.getUsername()).getUserId()));
            model.setViewName("bootstrapPostPage");
            return model;
        }
        if (search != null) {
            boolean dis = false;
            String url = "/post?search";
            if (disabled != null) {
                dis = true;
                url = "/post?disabled=on&search";
            }
            Post[] list;
            Integer nrPagini;
            if (tag != null) {
                list = postService.searchByTag(tag, page, dis);
                nrPagini = postService.searchByTagNext(tag, dis);
                try {
                    url = url + "&tag=" + URLEncoder.encode(tag, "UTF-8") + "&page=";
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            } else if (userID != null) {
                list = postService.searchByUser(userID, page, dis);
                nrPagini = postService.searchByUserNext(userID, dis);
                url = url + "&user=" + userID + "&page=";
            } else if (browse != null) {
                list = postService.search(page, dis);
                nrPagini = postService.searchNext(dis);
                url = url + "&browse&page=";
            } else {
                list = postService.search(search, page, dis);
                nrPagini = postService.searchNext(search, dis);
                try {
                    url = url + "=" + URLEncoder.encode(search, "UTF-8") + "&page=";
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            }
            model.addObject("url", url);
            model.addObject("nrPagini", nrPagini);
            model.addObject("searchResults", list);
            model.setViewName("postSearchResults");
            model.addObject("categoryList", categoryService.getAllCategories());
            model.addObject("searchParam", search);
            return model;
        }
        model.setViewName("index");
        return model;
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
        model.setViewName("403");
        return model;
    }

    @RequestMapping(value = "/newPost", method = RequestMethod.GET)
    public ModelAndView goToNewPost() {
        ModelAndView model = new ModelAndView();
        model.setViewName("postForm");
        return model;
    }

    @RequestMapping(value = "/account", method = RequestMethod.GET)
    public ModelAndView goToAccount(@RequestParam(value = "username", required = false) String username) {
        ModelAndView model = new ModelAndView();
        model.setViewName("accountPage");
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (username == null) {
            if (!(auth instanceof AnonymousAuthenticationToken)) {
                UserDetails userDetail = (UserDetails) auth.getPrincipal();
                model.addObject("user", userService.find(userDetail.getUsername()));
                model.addObject("myAccount", true);
                return model;
            }
        }
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetail = (UserDetails) auth.getPrincipal();
            if (username.equals(userDetail.getUsername())) {
                model.addObject("user", userService.find(username));
                model.addObject("myAccount", true);
                return model;
            }
        }
        model.addObject("user", userService.find(username));
        model.addObject("myAccount", false);
        return model;
    }

    @RequestMapping(value = "/activate", method = RequestMethod.GET)
    public ModelAndView activateAccount(@RequestParam(value = "token", required = false) String token,
                                        @RequestParam(value = "userId", required = true) String id,
                                        @RequestParam(value = "retryToken", required = false) String retryToken) {
        ModelAndView modelAndView = new ModelAndView();
        if (retryToken == null) {
            if (userService.useToken(token, Integer.valueOf(id))) {
                modelAndView.setViewName("login");
                modelAndView.addObject("msg", "Account activated successfully");
            } else {
                modelAndView.setViewName("accountActivate");
                modelAndView.addObject("succes", false);
            }
            return modelAndView;
        } else {
            modelAndView.setViewName("accountActivate");
            modelAndView.addObject("succes", true);
            User user = new User();
            user.setUserId(Integer.valueOf(id));
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
        if (userService.usePasswordReset(token, Integer.valueOf(id))) {
            modelAndView.setViewName("accountResetPassword");
            modelAndView.addObject("userID", id);
            return modelAndView;
        } else {
            modelAndView.setViewName("accountForgotPassword");
            modelAndView.addObject("error", "There was a problem with your token. Please try again.");
            return modelAndView;
        }
    }

    @RequestMapping(value = "forgotPassword", method = RequestMethod.GET)
    public ModelAndView goToForgotPassword() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("accountForgotPassword");
        return modelAndView;
    }

    @RequestMapping(value = "stack", method = RequestMethod.GET)
    public ModelAndView stack() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("postSearchResultsStack");
        return modelAndView;
    }

    private String getCurrentUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetail = (UserDetails) auth.getPrincipal();
            return userDetail.getUsername();
        }
        return "";
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

}