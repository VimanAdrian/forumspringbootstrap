package artsoftconsult.study.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Collection;
import java.util.Objects;

@Entity
@Table(name="virtual_classes")
public class VirtualClass {
    private Long virtualClassId;
    private String title;
    private String description;
    private Date created;
    private Date lastActive;
    private String visibility;
    private Long score;
    private Long views;
    private Boolean active;
    private User user;
    private Collection<Lecture> lectures;
    private Collection<Category> virtualClassCategories;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "virtual_class_id")
    public Long getVirtualClassId() {
        return virtualClassId;
    }

    public void setVirtualClassId(Long virtualClassId) {
        this.virtualClassId = virtualClassId;
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
        VirtualClass aVirtualClass = (VirtualClass) o;
        return Objects.equals(virtualClassId, aVirtualClass.virtualClassId) &&
                Objects.equals(title, aVirtualClass.title) &&
                Objects.equals(description, aVirtualClass.description) &&
                Objects.equals(created, aVirtualClass.created) &&
                Objects.equals(lastActive, aVirtualClass.lastActive) &&
                Objects.equals(visibility, aVirtualClass.visibility) &&
                Objects.equals(score, aVirtualClass.score) &&
                Objects.equals(views, aVirtualClass.views) &&
                Objects.equals(active, aVirtualClass.active);
    }

    @Override
    public int hashCode() {
        return Objects.hash(virtualClassId, title, description, created, lastActive, visibility, score, views, active);
    }

    @ManyToOne
    @JoinColumn(name = "owner", referencedColumnName = "user_id", nullable = false)
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @OneToMany(mappedBy = "virtualClass")
    public Collection<Lecture> getLectures() {
        return lectures;
    }

    public void setLectures(Collection<Lecture> lectures) {
        this.lectures = lectures;
    }

    @ManyToMany
    @JoinTable(name = "virtual_class_categories", joinColumns = @JoinColumn(name = "virtual_class_id", referencedColumnName = "virtual_class_id"), inverseJoinColumns = @JoinColumn(name = "category_id", referencedColumnName = "category_id"))
    public Collection<Category> getQuestionCategories() {
        return virtualClassCategories;
    }

    public void setQuestionCategories(Collection<Category> questionCategories) {
        this.virtualClassCategories = questionCategories;
    }

}
