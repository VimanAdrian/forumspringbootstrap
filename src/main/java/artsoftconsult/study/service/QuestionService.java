package artsoftconsult.study.service;

import artsoftconsult.study.model.Category;
import artsoftconsult.study.model.Question;
import artsoftconsult.study.model.Reply;
import artsoftconsult.study.model.User;
import artsoftconsult.study.repository.CategoryRepository;
import artsoftconsult.study.repository.QuestionRepository;
import artsoftconsult.study.repository.ReplyRepository;
import artsoftconsult.study.repository.UserRepository;
import artsoftconsult.study.utils.MyAttributeProvider;
import artsoftconsult.study.utils.RandomUtils;
import com.google.common.collect.Iterables;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Service
public class QuestionService {

    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private ReplyRepository replyRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private UserRepository userRepository;

    private Question prepareForSave(Question question) {
        question.setCreated(new Date(System.currentTimeMillis()));
        question.setLastActive(new Date(System.currentTimeMillis()));
        question.setViews((long) 0);
        question.setScore((long) 0);
        question.setActive(true);
        return question;
    }

    public Long save(String title, String content, String tags, User user) {
        Question question = new Question();
        question.setContent(content);
        question.setTitle(title);
        question.setUser(user);
        Question saved = questionRepository.save(prepareForSave(question));

        String[] tagsArray = RandomUtils.split(tags);
        for (String tag : tagsArray) {
            Category cat = new Category();
            cat.setTitle(tag.toLowerCase());
            try {
                cat.setUrl(URLEncoder.encode(cat.getTitle(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            Category category = categoryRepository.save(cat);
            categoryRepository.saveAssociation(saved.getQuestionId(), category.getCategoryId());
        }
        return saved.getQuestionId();
    }

    public void update(Question question) {
        Question questionFromDb = questionRepository.findByQuestionId(question.getQuestionId());
        if (question.getUser().getUserId().equals(questionFromDb.getUser().getUserId()))
            questionRepository.updateTitleAndContent(question.getTitle(), question.getContent(), question.getQuestionId());
    }

    public Question find(Long questionId, User user) {
        if (user != null) { //not authenticated
            replyRepository.markNotNew(questionId, user.getUserId());
        }
        questionRepository.incrementView(questionId);
        Question question = questionRepository.findByQuestionId(questionId);
        Iterable<Reply> replies = question.getReplies();
        for (Reply re : question.getReplies()) {
            re.setRawContent(re.getContent());
            re.setContent(MyAttributeProvider.commonMark(re.getContent()));
            if (user != null) { //not authenticated
                Integer replyVoteType = replyRepository.findVoteType(re.getReplyId(),user.getUserId());
                if (replyVoteType == null)
                    re.setVoteType(0);
                else if (replyVoteType == -1)
                    re.setVoteType(1);
                else
                    re.setVoteType(-1);
            } else {
                re.setVoteType(0);
            }
        }
        question.setReplies(sort(Iterables.toArray(replies, Reply.class)));
        question.setRawContent(question.getContent());
        question.setContent(MyAttributeProvider.commonMark(question.getContent()));
        if (user != null) { //not authenticated
            Integer questionVoteType = questionRepository.findVoteType(questionId, user.getUserId());
            if (questionVoteType == null)
                question.setVoteType(0);
            else if (questionVoteType == -1)
                question.setVoteType(1);
            else
                question.setVoteType(-1);
        } else {
            question.setVoteType(0);
        }
        return question;
    }

    private List<Reply> sort(Reply[] replies) {
        Reply favorite = null;
        List<Reply> sortedReplies = new ArrayList<>();
        for (Reply reply : replies) {
            if (reply.getBestAnswer()) {
                favorite = reply;
            } else {
                sortedReplies.add(reply);
            }
        }
        sortedReplies.sort(Comparator.comparing(Reply::getScore));
        if (sortedReplies.size() != replies.length) {
            sortedReplies.add(favorite);
        }
        Collections.reverse(sortedReplies);
        return sortedReplies;
    }

    public void vote(Long questionId, Long userId, String type) {
        Integer newVote;
        if (type.equals("UPVOTE")) {
            newVote = 1;
        } else {
            newVote = -1;
        }
        Integer oldVote = questionRepository.findVoteType(questionId, userId);
        if (oldVote == null) {
            oldVote = 0;
        }
        if (!oldVote.equals(newVote)) {
            questionRepository.changeVote(questionId, userId, newVote);
            questionRepository.updateScore(questionId, newVote * 2);
        } else {
            questionRepository.newVote(questionId, userId, newVote);
            questionRepository.updateScore(questionId, newVote);
        }
    }

    public boolean toggleQuestionStatus(Long questionId) {
        questionRepository.toggleStatus(questionId);
        return true;
    }

}

