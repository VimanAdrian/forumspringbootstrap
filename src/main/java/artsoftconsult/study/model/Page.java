package artsoftconsult.study.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Collection;
import java.util.Objects;

@Entity
@Table(name="pages")
public class Page {
    private Long pageId;
    private String content;
    private Date created;
    private Date lastActive;
    private Boolean active;
    private Lecture lecture;
    private Boolean deleted;
    private Collection<PageComment> pageComment;

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
    @Column(name = "active")
    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    @OneToMany(mappedBy = "page")
    public Collection<PageComment> getPageComment() {
        return pageComment;
    }

    public void setPageComment(Collection<PageComment> pageComment) {
        this.pageComment = pageComment;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Page page = (Page) o;
        return Objects.equals(pageId, page.pageId) &&
                Objects.equals(content, page.content) &&
                Objects.equals(created, page.created) &&
                Objects.equals(lastActive, page.lastActive) &&
                Objects.equals(active, page.active);
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
