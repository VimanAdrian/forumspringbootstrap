package artsoftconsult.study.dto.model;

public class ClassNotificationDTO {
    private Long classNotificationId;
    private String notificationText;
    private UserDTO userByUserId;
    private ClassDTO classByClassId;

    public Long getClassNotificationId() {
        return classNotificationId;
    }

    public void setClassNotificationId(Long classNotificationId) {
        this.classNotificationId = classNotificationId;
    }

    public String getNotificationText() {
        return notificationText;
    }

    public void setNotificationText(String notificationText) {
        this.notificationText = notificationText;
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
