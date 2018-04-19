package artsoftconsult.study.dto.model;

public class UserNotificationDTO {
    private Long userNotificationId;
    private String notificationText;
    private UserDTO userFollower;
    private UserDTO userFollowed;

    public Long getUserNotificationId() {
        return userNotificationId;
    }

    public void setUserNotificationId(Long userNotificationId) {
        this.userNotificationId = userNotificationId;
    }

    public String getNotificationText() {
        return notificationText;
    }

    public void setNotificationText(String notificationText) {
        this.notificationText = notificationText;
    }

    public UserDTO getUserFollower() {
        return userFollower;
    }

    public void setUserFollower(UserDTO userFollower) {
        this.userFollower = userFollower;
    }

    public UserDTO getUserFollowed() {
        return userFollowed;
    }

    public void setUserFollowed(UserDTO userFollowed) {
        this.userFollowed = userFollowed;
    }
}
