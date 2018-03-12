package artsoftconsult.study.dto.model;

import java.sql.Date;


public class RepliesCommentsDTO {
    private Long replyCommentId;
    private Date creationDate;
    private String content;
    private UserDTO userByUserId;
    private ReplyDTO replyByReplyId;

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

    public UserDTO getUserByUserId() {
        return userByUserId;
    }

    public void setUserByUserId(UserDTO userByUserId) {
        this.userByUserId = userByUserId;
    }

    public ReplyDTO getReplyByReplyId() {
        return replyByReplyId;
    }

    public void setReplyByReplyId(ReplyDTO replyByReplyId) {
        this.replyByReplyId = replyByReplyId;
    }
}
