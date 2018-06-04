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
        if (role_admin)
            return replyRepository.findCount(questionId);
        else
            return replyRepository.findCountWithoutDisabled(questionId);
    }

    public Boolean save(Reply reply, Long questionId) {
        Question question = questionRepository.findByQuestionId(questionId);
        reply.setQuestion(question);
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
        reply.setDeleted(false);
        return reply;
    }

    @Transactional
    public void vote(Long replyId, Long userId, String type) {
        Integer newVote;
        if (type.equals("Upvote")) {
            newVote = 1;
        } else {
            newVote = -1;
        }
        Integer oldVote = replyRepository.findVoteType(replyId, userId);
        if (oldVote == null) {
            oldVote = 0;
        }
        if (oldVote.equals(newVote)) {
        } else if (!oldVote.equals(0)) {
            replyRepository.changeVote(replyId, userId, newVote);
            replyRepository.updateScore(replyId, newVote * 2);
        } else {
            replyRepository.newVote(replyId, userId, newVote);
            replyRepository.updateScore(replyId, newVote);
        }
    }

    @Transactional
    public void update(Reply reply) {
        Reply reply1FromDb = replyRepository.findByReplyIdAndDeletedFalse(reply.getReplyId());
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

    @Transactional
    public Reply find(Long replyId) {
        return replyRepository.findOne(replyId);
    }

    @Transactional
    public void delete(Long replyId, Long userId) {
        Reply reply = replyRepository.findByReplyId(replyId);
        if (reply.getUser().getUserId().equals(userId)) {
            replyRepository.delete(replyId);
        }
    }
}
