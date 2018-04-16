package artsoftconsult.study.dto.model;

import java.sql.Date;
import java.util.Collection;

public class ReplyDTO {
    private Long replyId;
    private String content;
    private Date creationDate;
    private Long score;
    private Boolean bestAnswer;
    private Boolean enabled;
    private UserDTO userByUserId;
    private Collection<RepliesCommentsDTO> repliesCommentsByReplyId;

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

    public UserDTO getUserByUserId() {
        return userByUserId;
    }

    public void setUserByUserId(UserDTO userByUserId) {
        this.userByUserId = userByUserId;
    }

    public Collection<RepliesCommentsDTO> getRepliesCommentsByReplyId() {
        return repliesCommentsByReplyId;
    }

    public void setRepliesCommentsByReplyId(Collection<RepliesCommentsDTO> repliesCommentsByReplyId) {
        this.repliesCommentsByReplyId = repliesCommentsByReplyId;
    }
}
