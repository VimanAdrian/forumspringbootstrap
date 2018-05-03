package artsoftconsult.study.service;

import artsoftconsult.study.model.Reply;
import artsoftconsult.study.model.ReplyComment;
import artsoftconsult.study.model.User;
import artsoftconsult.study.repository.ReplyCommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.sql.Date;

@Service
public class ReplyCommentService {

    @Autowired
    private ReplyCommentRepository replyCommentRepository;

    @Autowired
    private ReplyService replyService;

    @Autowired
    private UserService userService;

    public Boolean save(Long parentId, String content) {
        User user = getCurrentUser();
        Reply reply = replyService.find(parentId);
        if ((user != null) && (reply != null)) {
            ReplyComment replyComment = new ReplyComment();
            replyComment.setReply(reply);
            replyComment.setUser(user);
            replyComment.setContent(content);
            replyComment.setCreationDate(new Date(System.currentTimeMillis()));
            if (replyCommentRepository.saveAndFlush(replyComment) != null)
                return true;
        }
        return false;
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
