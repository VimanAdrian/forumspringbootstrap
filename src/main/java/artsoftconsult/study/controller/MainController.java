package artsoftconsult.study.controller;

import artsoftconsult.study.dto.model.LectureDTO;
import artsoftconsult.study.dto.model.QuestionDTO;
import artsoftconsult.study.dto.model.VirtualClassDTO;
import artsoftconsult.study.model.Lecture;
import artsoftconsult.study.model.Question;
import artsoftconsult.study.model.User;
import artsoftconsult.study.model.VirtualClass;
import artsoftconsult.study.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
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

    @Autowired
    private VirtualClassService virtualClassService;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private SearchService searchService;

    private ModelAndView addUserInfo(ModelAndView modelAndView) {
        User user = getCurrentUser();
        if (user != null) {
            modelAndView.addObject("user", user);
            modelAndView.addObject("newClassActivity", false);
            modelAndView.addObject("newAnswers", false);
            modelAndView.addObject("topQuestions", false);
            List<VirtualClass> newClassActivity = userService.newClassActivity(user);
            List<Question> newAnswers = userService.newAnswers(user);
            List<Question> topQuestions = userService.topQuestions(user);
            if (newClassActivity.size() > 0) {
                VirtualClass[] list0 = newClassActivity.toArray(new VirtualClass[0]);
                modelAndView.addObject("newClassActivity", true);
                modelAndView.addObject("classList", list0);
            }
            if (newAnswers.size() > 0) {
                Question[] list1 = newAnswers.toArray(new Question[0]);
                modelAndView.addObject("newAnswers", true);
                modelAndView.addObject("answerList", list1);
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
    public ModelAndView goToDefaultPage(@RequestParam(value = "page", required = false, defaultValue = "0") Integer page,
                                        @RequestParam(value = "size", required = false, defaultValue = "20") Integer size,
                                        @RequestParam(value = "searchingFor", required = false, defaultValue = "question") String searchingFor) {
        if (getCurrentUser() != null) {
            return userPage(getCurrentUser().getUsername(), page, size, searchingFor, false, "", 0, null);
        } else {
            return userPage(null, page, size, searchingFor, false, "", 0, null);
        }
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView goToLogin() {
        return userPage(null, 0, 20, "question", true, "", -1, null);
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

    @RequestMapping(value = "/question", method = RequestMethod.GET)
    public ModelAndView goToPost(@RequestParam(value = "questionId", required = true) Long questionId, HttpServletRequest request) {
        ModelAndView model = new ModelAndView();
        User user = getCurrentUser();
        QuestionDTO question = questionService.find(questionId, user);
        model.addObject("question", question);
        model.setViewName("bootstrapQuestionPage");
        return addUserInfo(model);
    }

    @RequestMapping(value = "/class", method = RequestMethod.GET)
    public ModelAndView goToClass(@RequestParam(value = "classId", required = true) Long classId) {
        ModelAndView modelAndView = new ModelAndView();
        User user = getCurrentUser();
        VirtualClassDTO virtualClassDTO = virtualClassService.find(classId, user);
        modelAndView.addObject("virtualClass", virtualClassDTO);
        if (getCurrentUser() != null)
            modelAndView.addObject("followsClass", virtualClassService.followsClass(classId, user.getUserId()));
        modelAndView.setViewName("bootstrapClassPage");
        return addUserInfo(modelAndView);
    }

    @RequestMapping(value = "/lecture", method = RequestMethod.GET)
    public ModelAndView goToLecture(@RequestParam(value = "lectureId", required = true) Long lectureId,
                                    @RequestParam(value = "page", defaultValue = "0") Integer page) {
        ModelAndView modelAndView = new ModelAndView();
        User user = getCurrentUser();
        LectureDTO lectureDTO = lectureService.find(lectureId, user);
        modelAndView.addObject("lecture", lectureDTO);
        modelAndView.addObject("page", page);
        modelAndView.setViewName("bootstrapLecturePage");
        return addUserInfo(modelAndView);
    }

    @RequestMapping(value = "/activate", method = RequestMethod.GET)
    public ModelAndView activateAccount(@RequestParam(value = "token", required = false) String token,
                                        @RequestParam(value = "userId", required = true) String id) {
        if (userService.useToken(token, Long.valueOf(id))) {
            return userPage(null, 0, 20, "question", true, id, -1, true);
        } else {
            return userPage(null, 0, 20, "question", true, id, -1, false);
        }
    }

    @RequestMapping(value = "/reset", method = RequestMethod.GET)
    public ModelAndView resetPassword(@RequestParam(value = "token", required = true) String token,
                                      @RequestParam(value = "userId", required = true) String id) {
        if (userService.usePasswordReset(token, Long.valueOf(id))) {
            return userPage(null, 0, 20, "question", true, id, 1, null);
        } else {
            return userPage(null, 0, 20, "question", true, id, 0, null);
        }
    }

    @RequestMapping(value = "/tag", method = RequestMethod.GET)
    public ModelAndView searchByTag(@RequestParam(value = "tag") String tag,
                                    @RequestParam(value = "page", required = false, defaultValue = "0") Integer page,
                                    @RequestParam(value = "size", required = false, defaultValue = "20") Integer size,
                                    @RequestParam(value = "searchingFor", required = false, defaultValue = "question") String searchingFor) {
        ModelAndView modelAndView = new ModelAndView();
        Page<Question> questionPage = null;
        Page<VirtualClass> virtualClassPage = null;
        switch (searchingFor) {
            case "question":
                questionPage = searchService.searchQuestionByTag(tag, page, size);
                if (questionPage != null) modelAndView.addObject("questionPage", questionPage);
                break;
            case "virtualClass":
                virtualClassPage = searchService.searchVirtualClassByTag(tag, page, size);
                if (virtualClassPage != null) modelAndView.addObject("virtualClassPage", virtualClassPage);
                break;
            default:
                questionPage = searchService.searchQuestionByTag(tag, page, size);
                if (questionPage != null) modelAndView.addObject("questionPage", questionPage);
                searchingFor = "question";
                break;
        }
        modelAndView.addObject("searchingFor", searchingFor);
        modelAndView.addObject("tag", tag);
        modelAndView.addObject("showQuestion", true);
        modelAndView.addObject("showVirtualClass", true);
        modelAndView.addObject("showLecture", false);
        modelAndView.addObject("showUser", false);
        modelAndView.addObject("showSearchResults", true);
        modelAndView.addObject("questionUrl", "/tag?tag=" + tag + "&searchingFor=question&size=" + size + "&page=");
        modelAndView.addObject("virtualClassUrl", "/tag?tag=" + tag + "&searchingFor=virtualClass&size=" + size + "&page=");
        modelAndView.addObject("lectureUrl", "/tag?tag=" + tag + "&searchingFor=lecture&size=" + size + "&page=");
        modelAndView.setViewName("bootstrapSearchResults");
        return addUserInfo(modelAndView);
    }

    @RequestMapping(value = "/questions", method = RequestMethod.GET)
    public ModelAndView searchByLecture(@RequestParam(value = "lectureId") Long lectureId,
                                        @RequestParam(value = "page", required = false, defaultValue = "0") Integer page,
                                        @RequestParam(value = "size", required = false, defaultValue = "20") Integer size,
                                        @RequestParam(value = "searchingFor", required = false, defaultValue = "question") String searchingFor) {
        ModelAndView modelAndView = new ModelAndView();
        Page<Question> questionPage = null;
        switch (searchingFor) {
            case "question":
                questionPage = searchService.searchQuestionByLecture(lectureId, page, size);
                if (questionPage != null) modelAndView.addObject("questionPage", questionPage);
                break;
            default:
                questionPage = searchService.searchQuestionByLecture(lectureId, page, size);
                if (questionPage != null) modelAndView.addObject("questionPage", questionPage);
                searchingFor = "question";
                break;
        }
        modelAndView.addObject("searchingFor", searchingFor);
        modelAndView.addObject("lecture", lectureService.find(lectureId));
        modelAndView.addObject("showQuestion", true);
        modelAndView.addObject("showVirtualClass", false);
        modelAndView.addObject("showLecture", false);
        modelAndView.addObject("showUser", false);
        modelAndView.addObject("showSearchResults", true);
        modelAndView.addObject("questionUrl", "/questions?lectureId=" + lectureId + "&searchingFor=question&size=" + size + "&page=");
        modelAndView.addObject("virtualClassUrl", "/questions?lectureId=" + lectureId + "&searchingFor=virtualClass&size=" + size + "&page=");
        modelAndView.addObject("lectureUrl", "/questions?lectureId=" + lectureId + "&searchingFor=lecture&size=" + size + "&page=");
        modelAndView.setViewName("bootstrapSearchResults");
        return addUserInfo(modelAndView);
    }


    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public ModelAndView searchByFreeText(@RequestParam(value = "search") String search,
                                         @RequestParam(value = "page", required = false, defaultValue = "0") Integer page,
                                         @RequestParam(value = "size", required = false, defaultValue = "20") Integer size,
                                         @RequestParam(value = "searchingFor", required = false, defaultValue = "question") String searchingFor) {
        ModelAndView modelAndView = new ModelAndView();
        Page<Question> questionPage = null;
        Page<VirtualClass> virtualClassPage = null;
        Page<Lecture> lecturePage = null;
        switch (searchingFor) {
            case "question":
                questionPage = searchService.searchQuestionByFreeText(search, page, size);
                if (questionPage != null) modelAndView.addObject("questionPage", questionPage);
                break;
            case "virtualClass":
                virtualClassPage = searchService.searchVirtualClassByFreeText(search, page, size);
                if (virtualClassPage != null) modelAndView.addObject("virtualClassPage", virtualClassPage);
                break;
            case "lecture":
                lecturePage = searchService.searchLectureByFreeText(search, page, size);
                if (lecturePage != null) modelAndView.addObject("lecturePage", lecturePage);
                break;
            default:
                questionPage = searchService.searchQuestionByFreeText(search, page, size);
                if (questionPage != null) modelAndView.addObject("questionPage", questionPage);
                searchingFor = "question";
                break;
        }
        modelAndView.addObject("searchingFor", searchingFor);
        modelAndView.addObject("search", search);
        modelAndView.addObject("showQuestion", true);
        modelAndView.addObject("showVirtualClass", true);
        modelAndView.addObject("showLecture", true);
        modelAndView.addObject("showUser", false);
        modelAndView.addObject("showSearchResults", true);
        modelAndView.addObject("questionUrl", "/search?search=" + search + "&searchingFor=question&size=" + size + "&page=");
        modelAndView.addObject("virtualClassUrl", "/search?search=" + search + "&searchingFor=virtualClass&size=" + size + "&page=");
        modelAndView.addObject("lectureUrl", "/search?search=" + search + "&searchingFor=lecture&size=" + size + "&page=");
        modelAndView.setViewName("bootstrapSearchResults");
        return addUserInfo(modelAndView);
    }

    @RequestMapping(value = "/browse", method = RequestMethod.GET)
    public ModelAndView searchByFreeText(@RequestParam(value = "page", required = false, defaultValue = "0") Integer page,
                                         @RequestParam(value = "size", required = false, defaultValue = "20") Integer size,
                                         @RequestParam(value = "searchingFor", required = false, defaultValue = "question") String searchingFor) {
        ModelAndView modelAndView = new ModelAndView();
        Page<Question> questionPage = null;
        Page<VirtualClass> virtualClassPage = null;
        switch (searchingFor) {
            case "question":
                questionPage = searchService.searchQuestionByBrowse(page, size);
                if (questionPage != null) modelAndView.addObject("questionPage", questionPage);
                break;
            case "virtualClass":
                virtualClassPage = searchService.searchVirtualClassByBrowse(page, size);
                if (virtualClassPage != null) modelAndView.addObject("virtualClassPage", virtualClassPage);
                break;
            default:
                questionPage = searchService.searchQuestionByBrowse(page, size);
                if (questionPage != null) modelAndView.addObject("questionPage", questionPage);
                searchingFor = "question";
                break;
        }
        modelAndView.addObject("searchingFor", searchingFor);
        modelAndView.addObject("showQuestion", true);
        modelAndView.addObject("showVirtualClass", true);
        modelAndView.addObject("showLecture", false);
        modelAndView.addObject("showUser", false);
        modelAndView.addObject("showSearchResults", false);
        modelAndView.addObject("questionUrl", "/browse?searchingFor=question&size=" + size + "&page=");
        modelAndView.addObject("virtualClassUrl", "/browse?searchingFor=virtualClass&size=" + size + "&page=");
        modelAndView.addObject("lectureUrl", "/browse?searchingFor=lecture&size=" + size + "&page=");
        modelAndView.setViewName("bootstrapSearchResults");
        return addUserInfo(modelAndView);
    }

    @RequestMapping(value = "/account", method = RequestMethod.GET)
    public ModelAndView userPage(@RequestParam(value = "username") String username,
                                 @RequestParam(value = "page", required = false, defaultValue = "0") Integer page,
                                 @RequestParam(value = "size", required = false, defaultValue = "20") Integer size,
                                 @RequestParam(value = "searchingFor", required = false, defaultValue = "question") String searchingFor,
                                 Boolean showModal, String id, Integer validToken, Boolean activationSuccess) {
        ModelAndView modelAndView = new ModelAndView();
        Page<Question> questionPage = null;
        Page<VirtualClass> virtualClassPage = null;
        switch (searchingFor) {
            case "question":
                questionPage = searchService.searchQuestionByUser(username, page, size);
                if (questionPage != null) modelAndView.addObject("questionPage", questionPage);
                break;
            case "virtualClass":
                virtualClassPage = searchService.searchVirtualClassByUser(username, page, size);
                if (virtualClassPage != null) modelAndView.addObject("virtualClassPage", virtualClassPage);
                break;
            default:
                questionPage = searchService.searchQuestionByUser(username, page, size);
                if (questionPage != null) modelAndView.addObject("questionPage", questionPage);
                searchingFor = "question";
                break;
        }
        modelAndView.addObject("searchingFor", searchingFor);
        modelAndView.addObject("search", "");
        modelAndView.addObject("showQuestion", true);
        modelAndView.addObject("showVirtualClass", true);
        modelAndView.addObject("showLecture", false);
        if (username != null) {
            modelAndView.addObject("showUser", true);
            modelAndView.addObject("searchedUser", userService.find(username));
            modelAndView.addObject("questionUrl", "/account?username=" + username + "&searchingFor=question&size=" + size + "&page=");
            modelAndView.addObject("virtualClassUrl", "/account?username=" + username + "&searchingFor=virtualClass&size=" + size + "&page=");
            modelAndView.addObject("lectureUrl", "/account?username=" + username + "&searchingFor=lecture&size=" + size + "&page=");

        } else {
            modelAndView.addObject("showUser", false);
            modelAndView.addObject("showSearchResults", false);
            modelAndView.addObject("questionUrl", "/?searchingFor=question&size=" + size + "&page=");
            modelAndView.addObject("virtualClassUrl", "/?searchingFor=virtualClass&size=" + size + "&page=");
            modelAndView.addObject("lectureUrl", "/?searchingFor=lecture&size=" + size + "&page=");
        }
        modelAndView.addObject("modal", showModal);
        modelAndView.addObject("userID", id);
        modelAndView.addObject("validToken", validToken);
        modelAndView.addObject("activationSuccess", activationSuccess);
        modelAndView.setViewName("bootstrapSearchResults");
        return addUserInfo(modelAndView);
    }

    @RequestMapping(value = "/offline")
    public ModelAndView goToOfflinePage() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("bootstrapOfflineErrorPage");
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
     * saveQuestionComment targetURL in session
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