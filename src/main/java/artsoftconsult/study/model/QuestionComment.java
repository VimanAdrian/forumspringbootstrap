package artsoftconsult.study.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "question_comments")
public class QuestionComment {
    private Long questionCommentId;
    private Date creationDate;
    private String content;
    private Question question;
    private User user;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "question_comment_id")
    public Long getQuestionCommentId() {
        return questionCommentId;
    }

    public void setQuestionCommentId(Long questionCommentId) {
        this.questionCommentId = questionCommentId;
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
        QuestionComment that = (QuestionComment) o;
        return Objects.equals(questionCommentId, that.questionCommentId) &&
                Objects.equals(creationDate, that.creationDate) &&
                Objects.equals(content, that.content);
    }

    @Override
    public int hashCode() {
        return Objects.hash(questionCommentId, creationDate, content);
    }

    @ManyToOne
    @JoinColumn(name = "question_id", referencedColumnName = "question_id", nullable = false)
    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question questionByQuestionId2) {
        this.question = questionByQuestionId2;
    }

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
