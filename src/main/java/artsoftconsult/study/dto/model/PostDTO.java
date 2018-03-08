package artsoftconsult.study.dto.model;

import java.sql.Timestamp;
import java.util.Arrays;

public class PostDTO {
    private Integer postId;
    private String title;
    private String content;
    private String rawContent;
    private Timestamp creationDate = new Timestamp(new java.util.Date().getTime());
    private Integer views = 0;
    private Integer score = 0;
    private Byte active = 1;
    private UserDTO user;
    private ReplyDTO[] replies;
    private CategoryDTO[] categories;
    private PostCommentDTO[] comments;

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Timestamp creationDate) {
        this.creationDate = creationDate;
    }

    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Byte getActive() {
        return active;
    }

    public void setActive(Byte active) {
        this.active = active;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO usersByUserId) {
        this.user = usersByUserId;
    }

    public ReplyDTO[] getReplies() {
        return replies;
    }

    public void setReplies(ReplyDTO[] replies) {
        this.replies = replies;
    }

    public CategoryDTO[] getCategories() {
        return categories;
    }

    public void setCategories(CategoryDTO[] categories) {
        this.categories = categories;
    }

    public PostCommentDTO[] getComments() {
        return comments;
    }

    public void setComments(PostCommentDTO[] comments) {
        this.comments = comments;
    }


    public String getRawContent() {
        return rawContent;
    }

    public void setRawContent(String rawContent) {
        this.rawContent = rawContent;
    }

    @Override
    public String toString() {
        return "Post{" +
                "postId=" + postId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", rawContent='" + rawContent + '\'' +
                ", creationDate=" + creationDate +
                ", views=" + views +
                ", score=" + score +
                ", active=" + active +
                ", user=" + user +
                ", replies=" + Arrays.toString(replies) +
                ", categories=" + Arrays.toString(categories) +
                ", comments=" + Arrays.toString(comments) +
                '}';
    }
}
