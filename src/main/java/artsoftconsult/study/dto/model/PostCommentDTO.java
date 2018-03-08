package artsoftconsult.study.dto.model;

import java.sql.Timestamp;

public class PostCommentDTO {

    private Integer commentId;
    private PostDTO post;
    private UserDTO user;
    private Timestamp creationDate = new Timestamp(new java.util.Date().getTime());
    private String content;

    public Integer getCommentId() {
        return commentId;
    }

    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
    }

    public PostDTO getPost() {
        return post;
    }

    public void setPost(PostDTO post) {
        this.post = post;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public Timestamp getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Timestamp creationDate) {
        this.creationDate = creationDate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "PostComment{" +
                "commentId=" + commentId +
                ", post=" + post +
                ", user=" + user +
                ", content='" + content + '\'' +
                '}';
    }

}
