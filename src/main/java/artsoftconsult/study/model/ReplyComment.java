package artsoftconsult.study.model;

import org.hibernate.annotations.DynamicInsert;
import org.springframework.stereotype.Component;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

@Component
@Entity
@DynamicInsert
@Table(name ="replies_comments", schema = "forum")
public class ReplyComment {

    private Integer commentId;
    private Reply reply;
    private User user;
    private Timestamp creationDate = new Timestamp(new java.util.Date().getTime());
    private String content;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="commmentID", nullable = false)
    public Integer getCommentId() {
        return commentId;
    }

    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
    }

    @ManyToOne
    @JoinColumn(name = "replyID", referencedColumnName = "replyId", nullable = false)
    public Reply getReply() {
        return reply;
    }

    public void setReply(Reply reply) {
        this.reply = reply;
    }

    @ManyToOne
    @JoinColumn(name = "userID", referencedColumnName = "userID", nullable = false)
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Basic
    @Column(name = "creationDate", nullable = false)
    public Timestamp getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Timestamp creationDate) {
        this.creationDate = creationDate;
    }

    @Basic
    @Column(name = "content", nullable = false, length = 5000)
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "PostComment{" +
                "commentId=" + commentId +
                ", reply=" + reply +
                ", user=" + user +
                ", content='" + content + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ReplyComment that = (ReplyComment) o;
        return Objects.equals(commentId, that.commentId) &&
                Objects.equals(reply, that.reply) &&
                Objects.equals(user, that.user) &&
                Objects.equals(content, that.content);
    }

    @Override
    public int hashCode() {

        return Objects.hash(commentId, reply, user, content);
    }
}
