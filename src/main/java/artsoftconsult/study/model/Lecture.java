package artsoftconsult.study.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Collection;
import java.util.Objects;

@Entity
@Table(name = "lectures")
public class Lecture {
    private Long lectureId;
    private String title;
    private String description;
    private Date created;
    private Date lastActive;
    private String visibility;
    private Long score;
    private Long views;
    private Boolean active;
    private Chapter chapter;
    private Collection<Question> questions;
    private VirtualClass virtualClass;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "lecture_id")
    public Long getLectureId() {
        return lectureId;
    }

    public void setLectureId(Long lectureId) {
        this.lectureId = lectureId;
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
    @Column(name = "description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
    @Column(name = "visibility")
    public String getVisibility() {
        return visibility;
    }

    public void setVisibility(String visibility) {
        this.visibility = visibility;
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
    @Column(name = "views")
    public Long getViews() {
        return views;
    }

    public void setViews(Long views) {
        this.views = views;
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
        Lecture lecture = (Lecture) o;
        return Objects.equals(lectureId, lecture.lectureId) &&
                Objects.equals(title, lecture.title) &&
                Objects.equals(description, lecture.description) &&
                Objects.equals(created, lecture.created) &&
                Objects.equals(lastActive, lecture.lastActive) &&
                Objects.equals(visibility, lecture.visibility) &&
                Objects.equals(score, lecture.score) &&
                Objects.equals(views, lecture.views) &&
                Objects.equals(active, lecture.active);
    }

    @Override
    public int hashCode() {
        return Objects.hash(lectureId, title, description, created, lastActive, visibility, score, views, active);
    }

    @ManyToOne
    @JoinColumn(name = "chapter_id", referencedColumnName = "chapter_id", nullable = false)
    public Chapter getChapter() {
        return chapter;
    }

    public void setChapter(Chapter chapter) {
        this.chapter = chapter;
    }

    @OneToMany(mappedBy = "lecture")
    public Collection<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(Collection<Question> questions) {
        this.questions = questions;
    }

    @ManyToOne
    @JoinColumn(name = "class_id", referencedColumnName = "class_id", nullable = false)
    public VirtualClass getVirtualClass() {
        return virtualClass;
    }

    public void setVirtualClass(VirtualClass virtualClass) {
        this.virtualClass = virtualClass;
    }

    public void setReply(VirtualClass virtualClass) {
        this.virtualClass = virtualClass;
    }
}
