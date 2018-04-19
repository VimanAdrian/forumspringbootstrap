package artsoftconsult.study.dto.model;

public class VirtualClassRightsDTO {
    private Long virtualClassRightsId;
    private Boolean canView;
    private Boolean canEdit;
    private Boolean canPost;
    private UserDTO user;
    private VirtualClassDTO virtualClass;

    public Long getVirtualClassRightsId() {
        return virtualClassRightsId;
    }

    public void setVirtualClassRightsId(Long virtualClassRightsId) {
        this.virtualClassRightsId = virtualClassRightsId;
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

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public VirtualClassDTO getVirtualClass() {
        return virtualClass;
    }

    public void setVirtualClass(VirtualClassDTO virtualClass) {
        this.virtualClass = virtualClass;
    }
}
