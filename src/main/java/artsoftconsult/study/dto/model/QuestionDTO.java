package artsoftconsult.study.dto.model;

import java.sql.Date;
import java.util.Collection;

public class QuestionDTO {
    private Long questionId;
    private String title;
    private String content;
    private String rawContent;
    private Date created;
    private Date lastActive;
    private Long views;
    private Long score;
    private Boolean active;
    private UserDTO user;
    private LectureDTO lecture;
    private Collection<CategoryDTO> questionCategories;
    private Collection<ReplyDTO> replies;
    private Collection<QuestionCommentDTO> questionComments;
    private Integer voteType;
    private Boolean deleted;

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }
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

    public String getRawContent() {
        return rawContent;
    }

    public void setRawContent(String rawContent) {
        this.rawContent = rawContent;
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

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public LectureDTO getLecture() {
        return lecture;
    }

    public void setLecture(LectureDTO lecture) {
        this.lecture = lecture;
    }

    public Collection<CategoryDTO> getQuestionCategories() {
        return questionCategories;
    }

    public void setQuestionCategories(Collection<CategoryDTO> questionCategories) {
        this.questionCategories = questionCategories;
    }

    public Collection<ReplyDTO> getReplies() {
        return replies;
    }

    public void setReplies(Collection<ReplyDTO> replies) {
        this.replies = replies;
    }

    public Collection<QuestionCommentDTO> getQuestionComments() {
        return questionComments;
    }

    public void setQuestionComments(Collection<QuestionCommentDTO> questionComments) {
        this.questionComments = questionComments;
    }

    public Integer getVoteType() {
        return voteType;
    }

    public void setVoteType(Integer voteType) {
        this.voteType = voteType;
    }
}
