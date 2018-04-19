package artsoftconsult.study.dto.model;

import java.sql.Date;


public class ReplyCommentDTO {
    private Long replyCommentId;
    private Date creationDate;
    private String content;
    private UserDTO user;
    private ReplyDTO reply;

    public Long getReplyCommentId() {
        return replyCommentId;
    }

    public void setReplyCommentId(Long replyCommentId) {
        this.replyCommentId = replyCommentId;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public ReplyDTO getReply() {
        return reply;
    }

    public void setReply(ReplyDTO reply) {
        this.reply = reply;
    }
}
