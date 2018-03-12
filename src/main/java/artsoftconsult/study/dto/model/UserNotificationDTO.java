package artsoftconsult.study.dto.model;

public class UserNotificationDTO {
    private Long userNotificationId;
    private String notificationText;
    private UserDTO userByFollowerUserId;
    private UserDTO userByFollowedUserId;

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

    public UserDTO getUserByFollowerUserId() {
        return userByFollowerUserId;
    }

    public void setUserByFollowerUserId(UserDTO userByFollowerUserId) {
        this.userByFollowerUserId = userByFollowerUserId;
    }

    public UserDTO getUserByFollowedUserId() {
        return userByFollowedUserId;
    }

    public void setUserByFollowedUserId(UserDTO userByFollowedUserId) {
        this.userByFollowedUserId = userByFollowedUserId;
    }
}
