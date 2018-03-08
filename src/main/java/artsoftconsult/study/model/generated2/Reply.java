package artsoftconsult.study.model.generated2;

import javax.persistence.*;
import java.sql.Date;
import java.util.Collection;
import java.util.Objects;

@Entity
@Table(name="replies")
public class Reply {
    private Long replyId;
    private String content;
    private Date creationDate;
    private Long score;
    private Boolean bestAnswer;
    private Long enabled;
    private User userByUserId;
    private Collection<RepliesComments> repliesCommentsByReplyId;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "reply_id")
    public Long getReplyId() {
        return replyId;
    }

    public void setReplyId(Long replyId) {
        this.replyId = replyId;
    }

    @Basic
    @Column(name = "content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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
    @Column(name = "score")
    public Long getScore() {
        return score;
    }

    public void setScore(Long score) {
        this.score = score;
    }

    @Basic
    @Column(name = "bestanswer")
    public Boolean getBestAnswer() {
        return bestAnswer;
    }

    public void setBestAnswer(Boolean bestanswer) {
        this.bestAnswer = bestanswer;
    }

    @Basic
    @Column(name = "enabled")
    public Long getEnabled() {
        return enabled;
    }

    public void setEnabled(Long enabled) {
        this.enabled = enabled;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Reply reply = (Reply) o;
        return Objects.equals(replyId, reply.replyId) &&
                Objects.equals(content, reply.content) &&
                Objects.equals(creationDate, reply.creationDate) &&
                Objects.equals(score, reply.score) &&
                Objects.equals(bestAnswer, reply.bestAnswer) &&
                Objects.equals(enabled, reply.enabled);
    }

    @Override
    public int hashCode() {
        return Objects.hash(replyId, content, creationDate, score, bestAnswer, enabled);
    }

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    public User getUserByUserId() {
        return userByUserId;
    }

    public void setUserByUserId(User userByUserId) {
        this.userByUserId = userByUserId;
    }

    @OneToMany(mappedBy = "getReplyByReplyId")
    public Collection<RepliesComments> getRepliesCommentsByReplyId() {
        return repliesCommentsByReplyId;
    }

    public void setRepliesCommentsByReplyId(Collection<RepliesComments> repliesCommentsByReplyId) {
        this.repliesCommentsByReplyId = repliesCommentsByReplyId;
    }

}