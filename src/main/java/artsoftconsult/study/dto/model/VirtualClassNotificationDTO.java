package artsoftconsult.study.dto.model;

public class VirtualClassNotificationDTO {
    private Long virtualClassNotificationId;
    private String notificationText;
    private UserDTO user;
    private VirtualClassDTO virtualClass;

    public Long getVirtualClassNotificationId() {
        return virtualClassNotificationId;
    }

    public void setVirtualClassNotificationId(Long virtualClassNotificationId) {
        this.virtualClassNotificationId = virtualClassNotificationId;
    }

    public String getNotificationText() {
        return notificationText;
    }

    public void setNotificationText(String notificationText) {
        this.notificationText = notificationText;
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
