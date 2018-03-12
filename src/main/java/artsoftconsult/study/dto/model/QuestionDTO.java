package artsoftconsult.study.dto.model;

import java.sql.Date;
import java.util.Collection;

public class QuestionDTO {
    private Long questionId;
    private String title;
    private String content;
    private Date created;
    private Date lastActive;
    private Long views;
    private Long score;
    private Boolean active;
    private UserDTO userByUserId;
    private Collection<CategoryDTO> questionCategoriesByQuestionId;
    private Collection<QuestionCommentDTO> questionCommentsByQuestionId;
    private Collection<ReplyDTO> repliesByQuestionId;

    public Long getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Long questionId) {
        this.questionId = questionId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public Date getLastActive() {
        return lastActive;
    }

    public void setLastActive(Date lastActive) {
        this.lastActive = lastActive;
    }

    public Long getViews() {
        return views;
    }

    public void setViews(Long views) {
        this.views = views;
    }

    public Long getScore() {
        return score;
    }

    public void setScore(Long score) {
        this.score = score;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public UserDTO getUserByUserId() {
        return userByUserId;
    }

    public void setUserByUserId(UserDTO userByUserId) {
        this.userByUserId = userByUserId;
    }

    public Collection<CategoryDTO> getQuestionCategoriesByQuestionId() {
        return questionCategoriesByQuestionId;
    }

    public void setQuestionCategoriesByQuestionId(Collection<CategoryDTO> questionCategoriesByQuestionId) {
        this.questionCategoriesByQuestionId = questionCategoriesByQuestionId;
    }

    public Collection<QuestionCommentDTO> getQuestionCommentsByQuestionId() {
        return questionCommentsByQuestionId;
    }

    public void setQuestionCommentsByQuestionId(Collection<QuestionCommentDTO> questionCommentsByQuestionId) {
        this.questionCommentsByQuestionId = questionCommentsByQuestionId;
    }

    public Collection<ReplyDTO> getRepliesByQuestionId() {
        return repliesByQuestionId;
    }

    public void setRepliesByQuestionId(Collection<ReplyDTO> repliesByQuestionId) {
        this.repliesByQuestionId = repliesByQuestionId;
    }
}
