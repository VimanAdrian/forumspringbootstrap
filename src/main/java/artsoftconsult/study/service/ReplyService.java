package artsoftconsult.study.service;

import artsoftconsult.study.model.Reply;
import artsoftconsult.study.model.User;
import artsoftconsult.study.repository.implementation.PostRepository;
import artsoftconsult.study.repository.implementation.ReplyRepository;
import artsoftconsult.study.repository.implementation.UserRepository;
import artsoftconsult.study.utils.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyService {

    @Autowired
    private ReplyRepository replyRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PostRepository postRepository;
    @Autowired
    private Email email;

    public boolean save(Reply reply) {
        if (replyRepository.save(reply)) {
            String postUrl = "http://localhost:8080/post?postID=" + reply.getPost().getPostId() + "&page=0";
            User user = userRepository.findById(postRepository.findPoster(reply.getPost().getPostId()));
            email.sendNewReplyEmain(user.getEmail(), user.getUsername(), postUrl, reply.getContent());
            return true;
        } else
            return false;
    }

    public Integer postNrPages(String postID, boolean role_admin) {
        double nrPag = replyRepository.postNrPages(Integer.valueOf(postID), role_admin) / 20;
        return (int) Math.round(nrPag);
    }

    public boolean vote(Integer replyId, Integer userID, String type) {
        if (type.equals("upvote"))
            return replyRepository.vote(replyId, userID, 1);
        return replyRepository.vote(replyId, userID, -1);
    }

    public boolean favorite(Integer replyID, Integer postID) {
        return replyRepository.favorite(replyID, postID);
    }

    public boolean toggleStatus(Integer replyId) {
        return replyRepository.toggleStatus(replyId);
    }

    public Reply bestReply(String postID, String username) {
        return replyRepository.bestReply(Integer.valueOf(postID), userRepository.findId(username));
    }
}
