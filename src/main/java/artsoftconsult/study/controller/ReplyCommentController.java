package artsoftconsult.study.controller;

import artsoftconsult.study.service.ReplyCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ReplyCommentController {

    @Autowired
    private ReplyCommentService replyCommentService;

    @RequestMapping(value = "/makeReplyComment", method = RequestMethod.POST)
    public @ResponseBody
    Boolean makeReplyComment(@RequestParam("parentId") Long parentId, @RequestParam("content") String content) {
        return replyCommentService.save(parentId, content);
    }


}
