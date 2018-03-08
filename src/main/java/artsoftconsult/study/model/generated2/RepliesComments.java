package artsoftconsult.study.model.generated2;

import javax.persistence.*;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "replies_comments", schema = "public", catalog = "memoryleak")
public class RepliesComments {
    private Long replyCommentId;
    private Date creationDate;
    private String content;
    private User userByUserId;
    private Reply replyByReplyId;

    @Id
    @Column(name = "reply_comment_id")
    public Long getReplyCommentId() {
        return replyCommentId;
    }

    public void setReplyCommentId(Long replyCommentId) {
        this.replyCommentId = replyCommentId;
    }

    @Basic
    @Column(name = "creation_date")
    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    @Basic
    @Column(name = "content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RepliesComments that = (RepliesComments) o;
        return Objects.equals(replyCommentId, that.replyCommentId) &&
                Objects.equals(creationDate, that.creationDate) &&
                Objects.equals(content, that.content);
    }

    @Override
    public int hashCode() {
        return Objects.hash(replyCommentId, creationDate, content);
    }

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    public User getUserByUserId() {
        return userByUserId;
    }

    public void setUserByUserId(User userByUserId) {
        this.userByUserId = userByUserId;
    }

    @ManyToOne
    @JoinColumn(name = "reply_id", referencedColumnName = "reply_id", nullable = false)
    public Reply getReplyByReplyId() {
        return replyByReplyId;
    }

    public void setReplyByReplyId(Reply replyByReplyId) {
        this.replyByReplyId = replyByReplyId;
    }
}