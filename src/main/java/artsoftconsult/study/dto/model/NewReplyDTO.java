package artsoftconsult.study.dto.model;

public class NewReplyDTO {
    private Long userNewReplyId;
    private UserDTO userByUserId;
    private QuestionDTO questionByQuestionId;

    public Long getUserNewReplyId() {
        return userNewReplyId;
    }

    public void setUserNewReplyId(Long userNewReplyId) {
        this.userNewReplyId = userNewReplyId;
    }

    public UserDTO getUserByUserId() {
        return userByUserId;
    }

    public void setUserByUserId(UserDTO userByUserId) {
        this.userByUserId = userByUserId;
    }

    public QuestionDTO getQuestionByQuestionId() {
        return questionByQuestionId;
    }

    public void setQuestionByQuestionId(QuestionDTO questionByQuestionId) {
        this.questionByQuestionId = questionByQuestionId;
    }
}
