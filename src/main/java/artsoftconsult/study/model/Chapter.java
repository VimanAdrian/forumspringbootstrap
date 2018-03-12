package artsoftconsult.study.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Collection;
import java.util.Objects;

@Entity
@Table(name = "chapters")
public class Chapter {
    private Long chapterId;
    private String title;
    private String description;
    private Date created;
    private Date lastActive;
    private String visibility;
    private Long score;
    private Long views;
    private Boolean active;
    private Collection<Page> pagesByChapterId;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "chapter_id")
    public Long getChapterId() {
        return chapterId;
    }

    public void setChapterId(Long chapterId) {
        this.chapterId = chapterId;
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
        Chapter chapter = (Chapter) o;
        return Objects.equals(chapterId, chapter.chapterId) &&
                Objects.equals(title, chapter.title) &&
                Objects.equals(description, chapter.description) &&
                Objects.equals(created, chapter.created) &&
                Objects.equals(lastActive, chapter.lastActive) &&
                Objects.equals(visibility, chapter.visibility) &&
                Objects.equals(score, chapter.score) &&
                Objects.equals(views, chapter.views) &&
                Objects.equals(active, chapter.active);
    }

    @Override
    public int hashCode() {
        return Objects.hash(chapterId, title, description, created, lastActive, visibility, score, views, active);
    }

    @OneToMany(mappedBy = "getChapterByChapterId")
    public Collection<Page> getPagesByChapterId() {
        return pagesByChapterId;
    }

    public void setPagesByChapterId(Collection<Page> pagesByChapterId) {
        this.pagesByChapterId = pagesByChapterId;
    }
}
