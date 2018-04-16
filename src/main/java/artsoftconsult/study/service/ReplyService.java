package artsoftconsult.study.service;

import artsoftconsult.study.model.Question;
import artsoftconsult.study.model.Reply;
import artsoftconsult.study.repository.QuestionRepository;
import artsoftconsult.study.repository.ReplyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;

@Service
public class ReplyService {

    @Autowired
    private ReplyRepository replyRepository;

    @Autowired
    private QuestionRepository questionRepository;

    public Integer findCount(Long questionId, boolean role_admin) {
        if(role_admin)
            return replyRepository.findCount(questionId);
        else
            return replyRepository.findCountWithoutDisabled(questionId);
    }

    public Boolean save(Reply reply) {
        Reply saved = replyRepository.save(prepareForSave(reply));
        return (saved != null);
    }

    private Reply prepareForSave(Reply reply) {
        reply.setReplyId(null);
        reply.setBestAnswer(false);
        reply.setCreationDate(new Date(System.currentTimeMillis()));
        reply.setEnabled(true);
        reply.setScore((long) 0);
        reply.setReplyComment(null);
        return reply;
    }

    public void vote(Long replyId, Long userId, String type) {
        Integer newVote;
        if (type.equals("UPVOTE")) {
            newVote = 1;
        } else {
            newVote = -1;
        }
        Integer oldVote = replyRepository.findVoteType(replyId, userId);
        if (oldVote == null) {
            oldVote = 0;
        }
        if (!oldVote.equals(newVote)) {
            replyRepository.changeVote(replyId, userId, newVote);
            replyRepository.updateScore(replyId, newVote * 2);
        } else {
            replyRepository.newVote(replyId, userId, newVote);
            replyRepository.updateScore(replyId, newVote);
        }
    }

    public void toggleStatus(Long replyId) {
        replyRepository.toggleEnabled(replyId);
    }

    public void update(Reply reply) {
        Reply reply1FromDb = replyRepository.findByReplyId(reply.getReplyId());
        if (reply.getUser().getUserId().equals(reply1FromDb.getUser().getUserId()))
            replyRepository.updateContent(reply.getContent(), reply.getReplyId());
    }

    @Transactional
    public void favorite(Long replyId, Long questionId, Long userId) {
        Question questionFromDb = questionRepository.findByQuestionId(questionId);
        if (questionFromDb.getUser().getUserId().equals(userId)) {
            replyRepository.removeFavorite(questionId);
            replyRepository.makeFavorite(replyId);
        }
    }
}
