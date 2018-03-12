package artsoftconsult.study.dto.model;

import java.sql.Date;


public class QuestionCommentDTO {
    private Long questionCommentId;
    private Date creationDate;
    private String content;
    private UserDTO userByUserId;

    public Long getQuestionCommentId() {
        return questionCommentId;
    }

    public void setQuestionCommentId(Long questionCommentId) {
        this.questionCommentId = questionCommentId;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public UserDTO getUserByUserId() {
        return userByUserId;
    }

    public void setUserByUserId(UserDTO userByUserId) {
        this.userByUserId = userByUserId;
    }
}
