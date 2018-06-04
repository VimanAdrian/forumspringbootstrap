package artsoftconsult.study.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name="pages")
public class Page {
    private Long pageId;
    private String title;
    private String content;
    private Date created;
    private Date lastActive;
    private String visibility;
    private Long score;
    private Long views;
    private Boolean active;
    private Lecture lecture;
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
    @Column(name = "page_id")
    public Long getPageId() {
        return pageId;
    }

    public void setPageId(Long pageId) {
        this.pageId = pageId;
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
        Page page = (Page) o;
        return Objects.equals(pageId, page.pageId) &&
                Objects.equals(title, page.title) &&
                Objects.equals(content, page.content) &&
                Objects.equals(created, page.created) &&
                Objects.equals(lastActive, page.lastActive) &&
                Objects.equals(visibility, page.visibility) &&
                Objects.equals(score, page.score) &&
                Objects.equals(views, page.views) &&
                Objects.equals(active, page.active);
    }

    @Override
    public int hashCode() {
        return Objects.hash(pageId, title, content, created, lastActive, visibility, score, views, active);
    }

    @ManyToOne
    @JoinColumn(name = "lecture_id", referencedColumnName = "lecture_id", nullable = false)
    public Lecture getLecture() {
        return lecture;
    }

    public void setLecture(Lecture lecture) {
        this.lecture = lecture;
    }
}
