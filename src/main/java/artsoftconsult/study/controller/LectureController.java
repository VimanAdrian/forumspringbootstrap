package artsoftconsult.study.controller;

import artsoftconsult.study.dto.model.LectureDTO;
import artsoftconsult.study.dto.model.PageDTO;
import artsoftconsult.study.model.Lecture;
import artsoftconsult.study.model.Page;
import artsoftconsult.study.model.User;
import artsoftconsult.study.model.VirtualClass;
import artsoftconsult.study.service.LectureService;
import artsoftconsult.study.service.UserService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class LectureController {

    @Autowired
    private UserService userService;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private LectureService lectureService;

    private User getCurrentUser() {
        User user = null;
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetail = (UserDetails) auth.getPrincipal();
            user = userService.find(userDetail.getUsername());
        }
        return user;
    }

    @RequestMapping(value = "/newLecture", method = RequestMethod.POST)
    public @ResponseBody
    Long newLecture(@RequestParam("lectureTitle") String title,
                    @RequestParam("lectureDescription") String description,
                    @RequestParam("classId") Long classId,
                    @RequestParam("visibility") String visibility,
                    @RequestParam("active") Boolean active,
                    @ModelAttribute("PageDTTO") PageDTO[] pageDTOS,
                    HttpServletRequest request, HttpServletResponse response) {
        User user = getCurrentUser();
        if (user != null) {
            return lectureService.save(title, description, classId, visibility, active, pageDTOS, user);
        }
        return -1l;
    }

    @RequestMapping(value = "/newPage", method = RequestMethod.POST)
    public @ResponseBody
    Long newLecture(@RequestParam("content") String content,
                    @RequestParam("lectureId") Long lectureId,
                    HttpServletRequest request, HttpServletResponse response) {
        User user = getCurrentUser();
        if (user != null) {
            return lectureService.save(content, lectureId, user);
        }
        return 0L;
    }

    @RequestMapping(value = "/editLecture", method = RequestMethod.POST)
    public @ResponseBody
    Boolean makeEdit(@ModelAttribute("LectureDTO") LectureDTO lectureDTO) {
        User user = getCurrentUser();
        if (user != null) {
            Lecture lecture = new Lecture();
            modelMapper.map(lectureDTO, lecture);
            VirtualClass virtualClass = new VirtualClass();
            virtualClass.setUser(user);
            lecture.setVirtualClass(virtualClass);
            lectureService.update(lecture);
            return true;
        }
        return false;
    }

    @RequestMapping(value = "/editPage", method = RequestMethod.POST)
    public @ResponseBody
    Boolean makeEditPage(@ModelAttribute("PageDTO") PageDTO pageDTO) {
        User user = getCurrentUser();
        if (user != null) {
            Page page = new Page();
            modelMapper.map(pageDTO, page);
            VirtualClass virtualClass = new VirtualClass();
            Lecture lecture = new Lecture();
            virtualClass.setUser(user);
            lecture.setVirtualClass(virtualClass);
            page.setLecture(lecture);
            lectureService.updatePage(page);
            return true;
        }
        return false;
    }

    @RequestMapping(value = "/voteLecture", method = RequestMethod.POST, produces = "application/json")
    public @ResponseBody
    boolean makeVote(HttpServletRequest request, HttpServletResponse response, @RequestParam("lectureId") Long lectureId, @RequestParam("type") String type) {
        lectureService.vote(lectureId, getCurrentUser().getUserId(), type);
        return true;
    }

    @RequestMapping(value = "/deleteLecture", method = RequestMethod.POST, produces = "application/json")
    public @ResponseBody
    boolean deleteLecture(HttpServletRequest request, HttpServletResponse response, @RequestParam("lectureId") Long lectureId) {
        lectureService.deleteLecture(lectureId, getCurrentUser().getUserId());
        return true;
    }

    @RequestMapping(value = "/deletePage", method = RequestMethod.POST, produces = "application/json")
    public @ResponseBody
    boolean deletePage(HttpServletRequest request, HttpServletResponse response, @RequestParam("pageId") Long pageId) {
        lectureService.deletePage(pageId, getCurrentUser().getUserId());
        return true;
    }
}
