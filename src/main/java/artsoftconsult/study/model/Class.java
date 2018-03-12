package artsoftconsult.study.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Collection;
import java.util.Objects;

@Entity
@Table(name="classes")
public class Class {
    private Long classId;
    private String title;
    private String description;
    private Date created;
    private Date lastActive;
    private String visibility;
    private Long score;
    private Long views;
    private Boolean active;
    private User userByOwner;
    private Collection<Lecture> lecturesByClassId;

    @Id
    @Column(name = "class_id")
    public Long getClassId() {
        return classId;
    }

    public void setClassId(Long classId) {
        this.classId = classId;
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
        Class aClass = (Class) o;
        return Objects.equals(classId, aClass.classId) &&
                Objects.equals(title, aClass.title) &&
                Objects.equals(description, aClass.description) &&
                Objects.equals(created, aClass.created) &&
                Objects.equals(lastActive, aClass.lastActive) &&
                Objects.equals(visibility, aClass.visibility) &&
                Objects.equals(score, aClass.score) &&
                Objects.equals(views, aClass.views) &&
                Objects.equals(active, aClass.active);
    }

    @Override
    public int hashCode() {
        return Objects.hash(classId, title, description, created, lastActive, visibility, score, views, active);
    }

    @ManyToOne
    @JoinColumn(name = "owner", referencedColumnName = "user_id", nullable = false)
    public User getUserByOwner() {
        return userByOwner;
    }

    public void setUserByOwner(User userByOwner) {
        this.userByOwner = userByOwner;
    }

    @OneToMany(mappedBy = "getClassByClassId")
    public Collection<Lecture> getLecturesByClassId() {
        return lecturesByClassId;
    }

    public void setLecturesByClassId(Collection<Lecture> lecturesByClassId) {
        this.lecturesByClassId = lecturesByClassId;
    }
}
