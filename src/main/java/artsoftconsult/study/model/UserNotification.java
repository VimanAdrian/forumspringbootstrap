package artsoftconsult.study.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "user_notifications")
public class UserNotification {
    private Long userNotificationId;
    private String notificationText;
    private User userFollower;
    private User userFollowed;

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
    public User getUserFollower() {
        return userFollower;
    }

    public void setUserFollower(User userFollower) {
        this.userFollower = userFollower;
    }

    @ManyToOne
    @JoinColumn(name = "followed_user_id", referencedColumnName = "user_id", nullable = false)
    public User getUserFollowed() {
        return userFollowed;
    }

    public void setUserFollowed(User userFollowed) {
        this.userFollowed = userFollowed;
    }
}
