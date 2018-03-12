package artsoftconsult.study.controller;

import artsoftconsult.study.service.CategoryService;
import artsoftconsult.study.service.PostService;
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
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

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

    private ModelAndView addUserInfo(ModelAndView modelAndView) {
        User user = getCurrentUser();
        if (user != null) {
            modelAndView.addObject("user", user);
            modelAndView.addObject("newAnswers", false);
            modelAndView.addObject("topQuestions", false);
            List<Post> newAnswers = userService.newAnswers(user);
            List<Post> topQuestions = userService.topQuestions(user);
            if (newAnswers.size() > 0) {
                Post[] list = newAnswers.toArray(new Post[0]);
                modelAndView.addObject("newAnswers", true);
                modelAndView.addObject("answerList", list);
            }
            if (topQuestions.size() > 0) {
                Post[] list2 = topQuestions.toArray(new Post[0]);
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

    @RequestMapping(value = "/update", method = RequestMethod.GET)
    public ModelAndView goToUpdate(@RequestParam(value = "uploadFailure", required = false) String uploadFailure,
                                   @RequestParam(value = "uploadSuccess", required = false) String uploadSuccess,
                                   @RequestParam(value = "updateFailure", required = false) String updateFailure,
                                   @RequestParam(value = "updateSuccess", required = false) String updateSuccess) {
        ModelAndView model = new ModelAndView();
        model.addObject("modalUpdate", true);
        if (uploadFailure != null) {
            model.addObject("uploadFailure", "Upload failed!");
        }
        if (uploadSuccess != null) {
            model.addObject("uploadSuccess", "Upload succeeded!");
        }
        if (updateFailure != null) {
            model.addObject("updateFailure", "Update failed!");
        }
        if (updateSuccess != null) {
            model.addObject("updateSuccess", "Update succeeded!");
        }
        model.setViewName("bootstrapUserPage");
        return addUserInfo(model);
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
            modelAndView.addObject("adminSucces", "User is now admin!");
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
        modelAndView.setViewName("deprecated/adminUsers");
        return modelAndView;
    }

    @RequestMapping(value = "/admin/posts", method = RequestMethod.GET)
    public ModelAndView goToAdminPostsPage() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("deprecated/postSearchResults");
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
            model.setViewName("bootstrapQuestionPage");
            return model;
        }
        if (postID != null) {
            //TODO FIX unauthenticated SHIT!!!
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
            model.setViewName("bootstrapQuestionPage");
            return addUserInfo(model);
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
            model.setViewName("deprecated/postSearchResults");
            model.addObject("categoryList", categoryService.getAllCategories());
            model.addObject("searchParam", search);
            return model;
        }
        model.setViewName("deprecated/index");
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
        model.setViewName("deprecated/403");
        return model;
    }

    @RequestMapping(value = "/newPost", method = RequestMethod.GET)
    public ModelAndView goToNewPost() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("bootstrapNewQuestion");
        return addUserInfo(modelAndView);
    }

    @RequestMapping(value = "/account", method = RequestMethod.GET)
    public ModelAndView goToAccount(@RequestParam(value = "username", required = false) String username) {
        ModelAndView model = new ModelAndView();
        model.setViewName("deprecated/accountPage");
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
        modelAndView.setViewName("bootstrapUserPage");
        modelAndView.addObject("userID", id);
        modelAndView.addObject("modal", true);
        if (userService.usePasswordReset(token, Integer.valueOf(id))) {
            modelAndView.addObject("validToken", 1);
        } else {
            modelAndView.addObject("validToken", 0);
        }
        return modelAndView;
    }

    @RequestMapping(value = "forgotPassword", method = RequestMethod.GET)
    public ModelAndView goToForgotPassword() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("deprecated/accountForgotPassword");
        return modelAndView;
    }

    @RequestMapping(value = "stack", method = RequestMethod.GET)
    public ModelAndView stack() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("postSearchResultsStack");
        return modelAndView;
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