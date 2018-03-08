package artsoftconsult.study.dto.model;

import java.sql.Timestamp;

public class ReplyCommentDTO {

    private Integer commentId;
    private ReplyDTO reply;
    private UserDTO user;
    private Timestamp creationDate = new Timestamp(new java.util.Date().getTime());
    private String content;

    public Integer getCommentId() {
        return commentId;
    }

    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
    }

    public ReplyDTO getReply() {
        return reply;
    }

    public void setReply(ReplyDTO reply) {
        this.reply = reply;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public Timestamp getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Timestamp creationDate) {
        this.creationDate = creationDate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "ReplyCommentDTO{" +
                "commentId=" + commentId +
                ", reply=" + reply +
                ", user=" + user +
                ", creationDate=" + creationDate +
                ", content='" + content + '\'' +
                '}';
    }
}
