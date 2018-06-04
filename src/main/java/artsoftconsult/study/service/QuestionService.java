package artsoftconsult.study.service;

import artsoftconsult.study.dto.model.QuestionDTO;
import artsoftconsult.study.dto.model.ReplyDTO;
import artsoftconsult.study.model.Category;
import artsoftconsult.study.model.Lecture;
import artsoftconsult.study.model.Question;
import artsoftconsult.study.model.User;
import artsoftconsult.study.repository.*;
import artsoftconsult.study.utils.MyAttributeProvider;
import com.google.common.collect.Iterables;
import org.hibernate.Hibernate;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.*;

@Service
public class QuestionService {

    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private ReplyRepository replyRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private LectureRepository lectureRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private QuestionCommentRepository questionCommentRepository;
    @Autowired
    private ModelMapper modelMapper;

    private Question prepareForSave(Question question) {
        question.setCreated(new Date(System.currentTimeMillis()));
        question.setLastActive(new Date(System.currentTimeMillis()));
        question.setViews((long) 0);
        question.setScore((long) 0);
        question.setActive(true);
        question.setDeleted(false);
        return question;
    }

    public Long save(String title, String content, String tags, User user, Long lectureId) {
        Question question = new Question();
        question.setContent(content);
        question.setTitle(title);
        question.setUser(user);
        List<Category> categories = new ArrayList<>();
        String[] tagsArray = tags.split(",");
        for (String tag : tagsArray) {
            Category oldCategory = categoryRepository.findByTitle(tag.toLowerCase());
            if (oldCategory != null) {
                categories.add(oldCategory);
            } else {
                Category newCategory = new Category();
                newCategory.setTitle(tag.toLowerCase());
                try {
                    newCategory.setUrl(URLEncoder.encode(tag.toLowerCase(), "UTF-8"));
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
                categories.add(newCategory);
            }
        }
        Iterable<Category> categoryIterable = categoryRepository.save(categories);
        Collection<Category> categoryCollection = new ArrayList<>();
        for (Category category : categoryIterable) {
            categoryCollection.add(category);
        }
        question.setQuestionCategories(categoryCollection);

        if (lectureId != null) {
            Lecture lecture = lectureRepository.findByLectureId(lectureId);
            if (lecture != null) {
                question.setLecture(lecture);
            }
        }

        Question savedQuestion = questionRepository.saveAndFlush(prepareForSave(question));
        return savedQuestion.getQuestionId();
    }

    private Question prepareForUpdate(Question questionFromDB, Question questionFromFE) {
        questionFromDB.setTitle(questionFromFE.getTitle());
        questionFromDB.setContent(questionFromFE.getContent());
        return questionFromDB;
    }

    @Transactional
    public void update(Question question, String tags) {
        Question questionFromDb = questionRepository.findByQuestionIdAndDeletedFalse(question.getQuestionId());
        if (question.getUser().getUserId().equals(questionFromDb.getUser().getUserId())) {
            List<Category> categories = new ArrayList<>();
            List<Category> newCategories = new ArrayList<>();
            for (String tag : tags.split(",")) {
                Category oldCategory = categoryRepository.findByTitle(tag.toLowerCase());
                if (oldCategory != null) {
                    if (!categories.contains(oldCategory))
                        categories.add(oldCategory);
                } else {
                    Category newCategory = new Category();
                    newCategory.setTitle(tag.toLowerCase());
                    try {
                        newCategory.setUrl(URLEncoder.encode(tag.toLowerCase(), "UTF-8"));
                    } catch (UnsupportedEncodingException e) {
                        e.printStackTrace();
                    }
                    if (!categories.contains(newCategory)) {
                        categories.add(newCategory);
                        newCategories.add(newCategory);
                    }
                }
            }
            categoryRepository.save(newCategories);
            questionFromDb.getQuestionCategories().clear();
            questionFromDb.getQuestionCategories().addAll(categories);
            questionRepository.save(prepareForUpdate(questionFromDb, question));
        }
    }

    @Transactional
    public QuestionDTO find(Long questionId, User user) {
        if (user != null) { //not authenticated
            replyRepository.markNotNew(questionId, user.getUserId());
        }
        questionRepository.incrementView(questionId);
        Question question = questionRepository.findByQuestionIdAndDeletedFalse(questionId);
        Hibernate.initialize(question.getQuestionCategories());
        Hibernate.initialize(question.getQuestionComments());
        Hibernate.initialize(question.getReplies());
        Hibernate.initialize(question.getUser());

        QuestionDTO questionDTO = new QuestionDTO();
        modelMapper.map(question, questionDTO);

        Iterable<ReplyDTO> replies = questionDTO.getReplies();
        Iterable<ReplyDTO> notDeletedReplies = new ArrayList<>();
        for (ReplyDTO re : questionDTO.getReplies()) {
            re.setRawContent(re.getContent());
            re.setContent(MyAttributeProvider.commonMark(re.getContent()));
            if (user != null) { //not authenticated
                Integer replyVoteType = replyRepository.findVoteType(re.getReplyId(), user.getUserId());
                if (replyVoteType == null)
                    re.setVoteType(0);
                else if (replyVoteType == -1)
                    re.setVoteType(-1);
                else
                    re.setVoteType(1);
            } else {
                re.setVoteType(0);
            }
            if (!re.getDeleted()) {
                ((ArrayList<ReplyDTO>) notDeletedReplies).add(re);
            }
        }
        questionDTO.setReplies(sort(Iterables.toArray(notDeletedReplies, ReplyDTO.class)));
        questionDTO.setRawContent(questionDTO.getContent());
        questionDTO.setContent(MyAttributeProvider.commonMark(questionDTO.getContent()));
        if (user != null) { //authenticated
            Integer questionVoteType = questionRepository.findVoteType(questionId, user.getUserId());
            if (questionVoteType == null)
                questionDTO.setVoteType(0);
            else if (questionVoteType.equals(-1))
                questionDTO.setVoteType(-1);
            else
                questionDTO.setVoteType(1);
        } else {
            questionDTO.setVoteType(0);
        }
        return questionDTO;
    }

    public Question find(Long questionId) {
        return questionRepository.findByQuestionIdAndDeletedFalse(questionId);
    }

    private List<ReplyDTO> sort(ReplyDTO[] replies) {
        ReplyDTO favorite = null;
        List<ReplyDTO> sortedReplies = new ArrayList<>();
        for (ReplyDTO reply : replies) {
            if (reply.getBestAnswer()) {
                favorite = reply;
            } else {
                sortedReplies.add(reply);
            }
        }
        sortedReplies.sort(Comparator.comparing(ReplyDTO::getScore));
        if (sortedReplies.size() != replies.length) {
            sortedReplies.add(favorite);
        }
        Collections.reverse(sortedReplies);
        return sortedReplies;
    }

    @Transactional
    public void vote(Long questionId, Long userId, String type) {
        Integer newVote;
        if (type.equals("Upvote")) {
            newVote = 1;
        } else {
            newVote = -1;
        }
        Integer oldVote = questionRepository.findVoteType(questionId, userId);
        if (oldVote == null) {
            oldVote = 0;
        }
        if (oldVote.equals(newVote)) {
        } else if (!oldVote.equals(0)) {
            questionRepository.changeVote(questionId, userId, newVote);
            questionRepository.updateScore(questionId, newVote * 2);
        } else {
            questionRepository.newVote(questionId, userId, newVote);
            questionRepository.updateScore(questionId, newVote);
        }
    }

    @Transactional
    public boolean toggleQuestionStatus(Long questionId) {
        questionRepository.toggleStatus(questionId);
        return true;
    }

    @Transactional
    public boolean delete(Long questionId, Long userId) {
        Question question = questionRepository.findByQuestionId(questionId);
        if (question.getUser().getUserId().equals(userId)) {
            questionRepository.logicalDelete(questionId);
        }
        return true;
    }
}

