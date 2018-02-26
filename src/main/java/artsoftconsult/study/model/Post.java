package artsoftconsult.study.model;

import org.hibernate.annotations.DynamicInsert;
import org.springframework.stereotype.Component;

import javax.persistence.*;
import java.sql.Timestamp;

@Component
@Entity
@DynamicInsert
@Table(name = "posts", schema = "forum")
public class Post {
    private Integer postId;
    private String title;
    private String content;
    private String rawContent;
    private Timestamp creationDate = new Timestamp(new java.util.Date().getTime());
    private Integer views = 0;
    private Integer score = 0;
    private Byte active = 1;
    private User user;
    private Reply[] replies;
    private Category[] categories;
    private PostComment[] comments;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "postID", nullable = false)
    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    @Basic
    @Column(name = "title", nullable = false, length = 500)
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Basic
    @Column(name = "content", nullable = false, length = 5000)
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Basic
    @Column(name = "creationDate", nullable = false)
    public Timestamp getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Timestamp creationDate) {
        this.creationDate = creationDate;
    }

    @Basic
    @Column(name = "views", nullable = true)
    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }

    @Basic
    @Column(name = "score", nullable = true)
    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    @Basic
    @Column(name = "active", nullable = true)
    public Byte getActive() {
        return active;
    }

    public void setActive(Byte active) {
        this.active = active;
    }

    @ManyToOne
    @JoinColumn(name = "userID", referencedColumnName = "userID", nullable = false)
    public User getUser() {
        return user;
    }

    public void setUser(User usersByUserId) {
        this.user = usersByUserId;
    }

    @Transient
    public Reply[] getReplies() {
        return replies;
    }

    public void setReplies(Reply[] replies) {
        this.replies = replies;
    }

    @Transient
    public Category[] getCategories() {
        return categories;
    }

    public void setCategories(Category[] categories) {
        this.categories = categories;
    }

    @Transient
    public PostComment[] getComments() {
        return comments;
    }

    public void setComments(PostComment[] comments) {
        this.comments = comments;
    }


    public String getRawContent() {
        return rawContent;
    }

    public void setRawContent(String rawContent) {
        this.rawContent = rawContent;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Post that = (Post) o;

        if (postId != null ? !postId.equals(that.postId) : that.postId != null) return false;
        if (title != null ? !title.equals(that.title) : that.title != null) return false;
        if (content != null ? !content.equals(that.content) : that.content != null) return false;
        if (creationDate != null ? !creationDate.equals(that.creationDate) : that.creationDate != null) return false;
        if (views != null ? !views.equals(that.views) : that.views != null) return false;
        if (score != null ? !score.equals(that.score) : that.score != null) return false;
        if (active != null ? !active.equals(that.active) : that.active != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = postId != null ? postId.hashCode() : 0;
        result = 31 * result + (title != null ? title.hashCode() : 0);
        result = 31 * result + (content != null ? content.hashCode() : 0);
        result = 31 * result + (creationDate != null ? creationDate.hashCode() : 0);
        result = 31 * result + (views != null ? views.hashCode() : 0);
        result = 31 * result + (score != null ? score.hashCode() : 0);
        result = 31 * result + (active != null ? active.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "Post{" +
                "postId=" + postId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", creationDate=" + creationDate +
                ", views=" + views +
                ", score=" + score +
                ", active=" + active +
                ", user=" + user +
                ", replies=" + replies +
                ", categories=" + categories +
                '}';
    }

    //shame to the family

    @Transient
    public String getTitleForUpdate() {
        if (title.equals(""))
            return null;
        return title;
    }

    @Transient
    public String getContentForUpdate() {
        if (content.equals(""))
            return null;
        return content;
    }

}
