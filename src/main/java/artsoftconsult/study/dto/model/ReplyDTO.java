package artsoftconsult.study.dto.model;

import java.sql.Timestamp;
import java.util.Arrays;

public class ReplyDTO {
    private Integer replyId;
    private String content;
    private String rawContent;
    private Timestamp creationDate = new Timestamp(new java.util.Date().getTime());
    private Integer score = 0;
    private Byte bestAnswer = 0;
    private Byte enabled = 1;
    private UserDTO user;
    private PostDTO post;
    private Integer replyVoteType;
    private ReplyCommentDTO[] comments;

    public Integer getReplyId() {
        return replyId;
    }

    public void setReplyId(Integer replyId) {
        this.replyId = replyId;
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

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Byte getBestAnswer() {
        return bestAnswer;
    }

    public void setBestAnswer(Byte bestAnswer) {
        this.bestAnswer = bestAnswer;
    }

    public Byte getEnabled() {
        return enabled;
    }

    public void setEnabled(Byte enabled) {
        this.enabled = enabled;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO usersByUserId) {
        this.user = usersByUserId;
    }

    public PostDTO getPost() {
        return post;
    }

    public void setPost(PostDTO post) {
        this.post = post;
    }

    public ReplyCommentDTO[] getComments() {
        return comments;
    }

    public void setComments(ReplyCommentDTO[] comments) {
        this.comments = comments;
    }

    public String getRawContent() {
        return rawContent;
    }

    public void setRawContent(String rawContent) {
        this.rawContent = rawContent;
    }

    public Integer getReplyVoteType() {
        return replyVoteType;
    }

    public void setReplyVoteType(Integer replyVoteType) {
        this.replyVoteType = replyVoteType;
    }

    @Override
    public String toString() {
        return "Reply{" +
                "replyId=" + replyId +
                ", content='" + content + '\'' +
                ", rawContent='" + rawContent + '\'' +
                ", creationDate=" + creationDate +
                ", score=" + score +
                ", bestAnswer=" + bestAnswer +
                ", enabled=" + enabled +
                ", user=" + user +
                ", post=" + post +
                ", replyVoteType=" + replyVoteType +
                ", comments=" + Arrays.toString(comments) +
                '}';
    }
}
