package artsoftconsult.study.model;

import org.hibernate.annotations.DynamicInsert;
import org.springframework.stereotype.Component;

import javax.persistence.*;
import java.sql.Timestamp;

@Component
@Entity
@DynamicInsert
@Table(name = "replies", schema = "forum")
public class Reply {
    private Integer replyId;
    private String content;
    private String rawContent;
    private Timestamp creationDate = new Timestamp(new java.util.Date().getTime());
    private Integer score = 0;
    private Byte bestAnswer = 0;
    private Byte enabled = 1;
    private User user;
    private Post post;
    private Integer replyVoteType;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "replyId", nullable = false)
    public Integer getReplyId() {
        return replyId;
    }

    public void setReplyId(Integer replyId) {
        this.replyId = replyId;
    }

    @Basic
    @Column(name = "content", nullable = true, length = 5000)
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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
    @Column(name = "score", nullable = true)
    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    @Basic
    @Column(name = "bestAnswer", nullable = true)
    public Byte getBestAnswer() {
        return bestAnswer;
    }

    public void setBestAnswer(Byte bestAnswer) {
        this.bestAnswer = bestAnswer;
    }

    @Basic
    @Column(name = "enabled", nullable = true)
    public Byte getEnabled() {
        return enabled;
    }

    public void setEnabled(Byte enabled) {
        this.enabled = enabled;
    }

    @ManyToOne
    @JoinColumn(name = "userID", referencedColumnName = "userID")
    public User getUser() {
        return user;
    }

    public void setUser(User usersByUserId) {
        this.user = usersByUserId;
    }

    @ManyToOne
    @JoinColumn(name = "postID", referencedColumnName = "postID")
    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    @Transient
    public String getRawContent() {
        return rawContent;
    }

    public void setRawContent(String rawContent) {
        this.rawContent = rawContent;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Reply that = (Reply) o;

        if (replyId != null ? !replyId.equals(that.replyId) : that.replyId != null) return false;
        if (content != null ? !content.equals(that.content) : that.content != null) return false;
        if (creationDate != null ? !creationDate.equals(that.creationDate) : that.creationDate != null) return false;
        if (score != null ? !score.equals(that.score) : that.score != null) return false;
        if (bestAnswer != null ? !bestAnswer.equals(that.bestAnswer) : that.bestAnswer != null) return false;
        if (enabled != null ? !enabled.equals(that.enabled) : that.enabled != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = replyId != null ? replyId.hashCode() : 0;
        result = 31 * result + (content != null ? content.hashCode() : 0);
        result = 31 * result + (creationDate != null ? creationDate.hashCode() : 0);
        result = 31 * result + (score != null ? score.hashCode() : 0);
        result = 31 * result + (bestAnswer != null ? bestAnswer.hashCode() : 0);
        result = 31 * result + (enabled != null ? enabled.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "Reply{" +
                "replyId=" + replyId +
                ", content='" + content + '\'' +
                ", creationDate=" + creationDate +
                ", score=" + score +
                ", bestAnswer=" + bestAnswer +
                ", enabled=" + enabled +
                ", user=" + user +
                ", post=" + post +
                ", replyVoteType=" + replyVoteType +
                '}';
    }

    //shame to the family

    @Transient
    public Integer getReplyVoteType() {
        return replyVoteType;
    }

    public void setReplyVoteType(Integer replyVoteType) {
        this.replyVoteType = replyVoteType;
    }
}
