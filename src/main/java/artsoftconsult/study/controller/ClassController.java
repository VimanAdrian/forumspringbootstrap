package artsoftconsult.study.controller;

import artsoftconsult.study.dto.model.VirtualClassDTO;
import artsoftconsult.study.model.User;
import artsoftconsult.study.model.VirtualClass;
import artsoftconsult.study.service.UserService;
import artsoftconsult.study.service.VirtualClassService;
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
public class ClassController {

    @Autowired
    private UserService userService;

    @Autowired
    private VirtualClassService virtualClassService;

    @Autowired
    private ModelMapper modelMapper;

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

    @RequestMapping(value = "/editClassAddLectures", method = RequestMethod.POST)
    public @ResponseBody
    Long editClass(@RequestParam("title") String[] title, @RequestParam("virtualClassId") Long virtualClassId) {
        User user = getCurrentUser();
        if (user != null) {
            Long saveResponse = virtualClassService.save(title, virtualClassId, user);
            return saveResponse;
        }
        return -1l;
    }

    @RequestMapping(value = "/editClass", method = RequestMethod.POST)
    public @ResponseBody
    Boolean editClass(@ModelAttribute("VirtualClassDTO") VirtualClassDTO classDTO, @RequestParam("tags") String tags) {
        User user = getCurrentUser();
        if (user != null) {
            VirtualClass virtualClass = new VirtualClass();
            modelMapper.map(classDTO, virtualClass);
            virtualClass.setUser(user);
            virtualClassService.update(virtualClass, tags);
            return true;
        }
        return false;
    }

    @RequestMapping(value = "/deleteClass", method = RequestMethod.POST)
    public @ResponseBody
    boolean makeDelete(HttpServletRequest request, HttpServletResponse response, @RequestParam("classId") Long classId) {
        return virtualClassService.delete(classId, getCurrentUser().getUserId());
    }

    @RequestMapping(value = "/followClass", method = RequestMethod.POST)
    public @ResponseBody
    boolean followClass(@RequestParam("classId") Long classId) {
        return virtualClassService.followClass(classId, getCurrentUser().getUserId());
    }

    @RequestMapping(value = "/unfollowClass", method = RequestMethod.POST)
    public @ResponseBody
    boolean unfollowClass(@RequestParam("classId") Long classId) {
        return virtualClassService.unfollowClass(classId, getCurrentUser().getUserId());
    }


}
