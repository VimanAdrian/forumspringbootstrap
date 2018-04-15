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
    private User userByUserId;
    private Collection<Category> questionCategoriesByQuestionId;
    private Collection<QuestionComment> questionCommentsByQuestionId;
    private Collection<Reply> repliesByQuestionId;
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

    @Transient
    public void setContent(String content) {
        this.content = content;
    }

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

    @ManyToMany
    @JoinTable(name="question_categories", joinColumns = @JoinColumn(name="question_id", referencedColumnName = "question_id"), inverseJoinColumns = @JoinColumn(name="category_id", referencedColumnName = "category_id"))
    public Collection<Category> getQuestionCategoriesByQuestionId() {
        return questionCategoriesByQuestionId;
    }

    public void setQuestionCategoriesByQuestionId(Collection<Category> questionCategoriesByQuestionId) {
        this.questionCategoriesByQuestionId = questionCategoriesByQuestionId;
    }

    @OneToMany(mappedBy = "getQuestionByQuestionId")
    public Collection<QuestionComment> getQuestionCommentsByQuestionId() {
        return questionCommentsByQuestionId;
    }

    public void setQuestionCommentsByQuestionId(Collection<QuestionComment> questionCommentsByQuestionId) {
        this.questionCommentsByQuestionId = questionCommentsByQuestionId;
    }

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    public User getUserByUserId() {
        return userByUserId;
    }

    public void setUserByUserId(User userByUserId) {
        this.userByUserId = userByUserId;
    }

    @OneToMany(mappedBy = "getQuestionByQuestionId")
    public Collection<Reply> getRepliesByQuestionId() {
        return repliesByQuestionId;
    }

    public void setRepliesByQuestionId(Collection<Reply> repliesByQuestionId) {
        this.repliesByQuestionId = repliesByQuestionId;
    }

    @Transient
    public Integer getVoteType() {
        return voteType;
    }

    public void setVoteType(Integer voteType) {
        this.voteType = voteType;
    }
}
