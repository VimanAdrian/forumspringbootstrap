package artsoftconsult.study.dto.model;

import java.sql.Date;
import java.util.Collection;

public class ReplyDTO {
    private Long replyId;
    private String content;
    private String rawContent;
    private Date creationDate;
    private Long score;
    private Boolean bestAnswer;
    private Boolean enabled;
    private UserDTO user;
    private QuestionDTO question;
    private Collection<ReplyCommentDTO> replyComment;
    private Integer voteType;
    private Boolean deleted;

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public Long getReplyId() {
        return replyId;
    }

    public void setReplyId(Long replyId) {
        this.replyId = replyId;
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

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public Long getScore() {
        return score;
    }

    public void setScore(Long score) {
        this.score = score;
    }

    public Boolean getBestAnswer() {
        return bestAnswer;
    }

    public void setBestAnswer(Boolean bestAnswer) {
        this.bestAnswer = bestAnswer;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public QuestionDTO getQuestion() {
        return question;
    }

    public void setQuestion(QuestionDTO question) {
        this.question = question;
    }

    public Collection<ReplyCommentDTO> getReplyComment() {
        return replyComment;
    }

    public void setReplyComment(Collection<ReplyCommentDTO> replyComment) {
        this.replyComment = replyComment;
    }

    public Integer getVoteType() {
        return voteType;
    }

    public void setVoteType(Integer voteType) {
        this.voteType = voteType;
    }
}
