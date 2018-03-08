package artsoftconsult.study.model.generated2;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "user_new_replies")
public class NewReply {
    private Long userNewReplyId;
    private User userByUserId;
    private Question questionByQuestionId;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_new_reply_id")
    public Long getUserNewReplyId() {
        return userNewReplyId;
    }

    public void setUserNewReplyId(Long userNewReplyId) {
        this.userNewReplyId = userNewReplyId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        NewReply that = (NewReply) o;
        return Objects.equals(userNewReplyId, that.userNewReplyId);
    }

    @Override
    public int hashCode() {

        return Objects.hash(userNewReplyId);
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
    @JoinColumn(name = "question_id", referencedColumnName = "question_id", nullable = false)
    public Question getQuestionByQuestionId() {
        return questionByQuestionId;
    }

    public void setQuestionByQuestionId(Question questionByQuestionId) {
        this.questionByQuestionId = questionByQuestionId;
    }
}
