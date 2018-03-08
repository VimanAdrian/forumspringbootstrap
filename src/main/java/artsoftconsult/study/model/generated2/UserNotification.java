package artsoftconsult.study.model.generated2;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "user_notifications")
public class UserNotification {
    private Long userNotificationId;
    private String notificationText;
    private User userByFollowerUserId;
    private User userByFollowedUserId;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_notification_id")
    public Long getUserNotificationId() {
        return userNotificationId;
    }

    public void setUserNotificationId(Long userNotificationId) {
        this.userNotificationId = userNotificationId;
    }

    @Basic
    @Column(name = "notification_text")
    public String getNotificationText() {
        return notificationText;
    }

    public void setNotificationText(String notificationText) {
        this.notificationText = notificationText;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserNotification that = (UserNotification) o;
        return Objects.equals(userNotificationId, that.userNotificationId) &&
                Objects.equals(notificationText, that.notificationText);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userNotificationId, notificationText);
    }

    @ManyToOne
    @JoinColumn(name = "follower_user_id", referencedColumnName = "user_id", nullable = false)
    public User getUserByFollowerUserId() {
        return userByFollowerUserId;
    }

    public void setUserByFollowerUserId(User userByFollowerUserId) {
        this.userByFollowerUserId = userByFollowerUserId;
    }

    @ManyToOne
    @JoinColumn(name = "followed_user_id", referencedColumnName = "user_id", nullable = false)
    public User getUserByFollowedUserId() {
        return userByFollowedUserId;
    }

    public void setUserByFollowedUserId(User userByFollowedUserId) {
        this.userByFollowedUserId = userByFollowedUserId;
    }
}
