package artsoftconsult.study.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Collection;
import java.util.Objects;

@Entity
@Table(name="replies")
public class Reply {
    private Long replyId;
    private String content;
    private String rawContent;
    private Date creationDate;
    private Long score;
    private Boolean bestAnswer;
    private Boolean enabled;
    private User user;
    private Question question;
    private Collection<ReplyComment> replyComment;
    private Integer voteType;
    private Boolean deleted;

    @Basic
    @Column(name = "deleted")
    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

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

    @Transient
    public String getRawContent() {
        return rawContent;
    }

    public void setRawContent(String rawContent) {
        this.rawContent = rawContent;
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
    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
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
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @ManyToOne
    @JoinColumn(name = "question_id", referencedColumnName = "question_id", nullable = false)
    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    @OneToMany(mappedBy = "reply")
    public Collection<ReplyComment> getReplyComment() {
        return replyComment;
    }

    public void setReplyComment(Collection<ReplyComment> replyComment) {
        this.replyComment = replyComment;
    }

    @Transient
    public Integer getVoteType() {
        return voteType;
    }

    public void setVoteType(Integer voteType) {
        this.voteType = voteType;
    }
}
