package artsoftconsult.study.dto.model;

public class ClassRightsDTO {
    private Long classEditId;
    private Boolean canView;
    private Boolean canEdit;
    private Boolean canPost;
    private UserDTO userByUserId;
    private ClassDTO classByClassId;

    public Long getClassEditId() {
        return classEditId;
    }

    public void setClassEditId(Long classEditId) {
        this.classEditId = classEditId;
    }

    public Boolean getCanView() {
        return canView;
    }

    public void setCanView(Boolean canView) {
        this.canView = canView;
    }

    public Boolean getCanEdit() {
        return canEdit;
    }

    public void setCanEdit(Boolean canEdit) {
        this.canEdit = canEdit;
    }

    public Boolean getCanPost() {
        return canPost;
    }

    public void setCanPost(Boolean canPost) {
        this.canPost = canPost;
    }

    public UserDTO getUserByUserId() {
        return userByUserId;
    }

    public void setUserByUserId(UserDTO userByUserId) {
        this.userByUserId = userByUserId;
    }

    public ClassDTO getClassByClassId() {
        return classByClassId;
    }

    public void setClassByClassId(ClassDTO classByClassId) {
        this.classByClassId = classByClassId;
    }
}
