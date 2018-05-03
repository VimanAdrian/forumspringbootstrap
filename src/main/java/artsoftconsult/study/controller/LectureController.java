package artsoftconsult.study.controller;

import artsoftconsult.study.dto.model.PageDTO;
import artsoftconsult.study.model.User;
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
    Long
    newLecture(@RequestParam("lectureTitle") String title,
               @RequestParam("lectureDescription") String description,
               @RequestParam("classId") Long classId,
               @RequestParam("visibility") String visibility,
               @RequestParam("active") Boolean active,
               @ModelAttribute("PageDTTO") PageDTO[] pageDTOS,
               HttpServletRequest request, HttpServletResponse response) {
        User user = getCurrentUser();
        if (user != null) {
            Long saveResponse = lectureService.save(title, description, classId, visibility, active, pageDTOS, user);
            return saveResponse;
        }
        return -1l;
    }

}
