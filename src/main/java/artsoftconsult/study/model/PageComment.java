package artsoftconsult.study.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "pages_comments", schema = "public", catalog = "memoryleak")
public class PageComment {
    private Long pageCommentId;
    private Date creationDate;
    private String content;
    private User user;
    private Page page;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "page_comment_id")
    public Long getPageCommentId() {
        return pageCommentId;
    }

    public void setPageCommentId(Long replyCommentId) {
        this.pageCommentId = replyCommentId;
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
        PageComment that = (PageComment) o;
        return Objects.equals(pageCommentId, that.pageCommentId) &&
                Objects.equals(creationDate, that.creationDate) &&
                Objects.equals(content, that.content);
    }

    @Override
    public int hashCode() {
        return Objects.hash(pageCommentId, creationDate, content);
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
    @JoinColumn(name = "page_id", referencedColumnName = "page_id", nullable = false)
    public Page getPage() {
        return page;
    }

    public void setPage(Page page) {
        this.page = page;
    }


}
