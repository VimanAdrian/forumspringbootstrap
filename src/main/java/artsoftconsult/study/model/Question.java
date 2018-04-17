package artsoftconsult.study.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Collection;
import java.util.Objects;

@Entity
@Table(name="questions")
public class Question {
    private Long questionId;
    private String title;
    private String content;
    private String rawContent;
    private Date created;
    private Date lastActive;
    private Long views;
    private Long score;
    private Boolean active;
    private User user;
    private Lecture lecture;
    private Collection<Category> questionCategories;
    private Collection<Reply> replies;
    private Collection<QuestionComment> questionComments;
    private Integer voteType;

    public Question(){

    }

    public Question(Long id, String title, Long views, Long score){
        this.questionId = id;
        this.title = title;
        this.views = views;
        this.score = score;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "question_id")
    public Long getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Long questionId) {
        this.questionId = questionId;
    }

    @Basic
    @Column(name = "title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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
    @Column(name = "created")
    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    @Basic
    @Column(name = "last_active")
    public Date getLastActive() {
        return lastActive;
    }

    public void setLastActive(Date lastActive) {
        this.lastActive = lastActive;
    }

    @Basic
    @Column(name = "views")
    public Long getViews() {
        return views;
    }

    public void setViews(Long views) {
        this.views = views;
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
    @Column(name = "active")
    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Question question = (Question) o;
        return Objects.equals(questionId, question.questionId) &&
                Objects.equals(title, question.title) &&
                Objects.equals(content, question.content) &&
                Objects.equals(created, question.created) &&
                Objects.equals(lastActive, question.lastActive) &&
                Objects.equals(views, question.views) &&
                Objects.equals(score, question.score) &&
                Objects.equals(active, question.active);
    }

    @Override
    public int hashCode() {
        return Objects.hash(questionId, title, content, created, lastActive, views, score, active);
    }

    @OneToMany(mappedBy = "question")
    public Collection<Reply> getReplies() {
        return replies;
    }

    public void setReplies(Collection<Reply> replies) {
        this.replies = replies;
    }

    @OneToMany(mappedBy = "question")
    public Collection<QuestionComment> getQuestionComments() {
        return questionComments;
    }

    public void setQuestionComments(Collection<QuestionComment> questionComments) {
        this.questionComments = questionComments;
    }

    @ManyToMany
    @JoinTable(name="question_categories", joinColumns = @JoinColumn(name="question_id", referencedColumnName = "question_id"), inverseJoinColumns = @JoinColumn(name="category_id", referencedColumnName = "category_id"))
    public Collection<Category> getQuestionCategories() {
        return questionCategories;
    }

    public void setQuestionCategories(Collection<Category> questionCategories) {
        this.questionCategories = questionCategories;
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
    @JoinColumn(name = "lecture_id", referencedColumnName = "lecture_id", nullable = true)
    public Lecture getLecture() {
        return lecture;
    }

    public void setLecture(Lecture lecture) {
        this.lecture = lecture;
    }

    @Transient
    public Integer getVoteType() {
        return voteType;
    }

    public void setVoteType(Integer voteType) {
        this.voteType = voteType;
    }

    @Override
    public String toString() {
        return "toStringQuestion{" +
                "questionId=" + questionId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", rawContent='" + rawContent + '\'' +
                ", created=" + created +
                ", lastActive=" + lastActive +
                ", views=" + views +
                ", score=" + score +
                ", active=" + active +
                ", user=" + user +
                ", lecture=" + lecture +
                ", questionCategories=" + questionCategories +
                ", replies=" + replies +
                ", questionComments=" + questionComments +
                ", voteType=" + voteType +
                '}';
    }
}
