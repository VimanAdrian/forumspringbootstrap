package artsoftconsult.study.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "virtual_class_notifications")
public class VirtualClassNotification {
    private Long virtualClassNotificationId;
    private String notificationText;
    private User user;
    private VirtualClass virtualClass;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "virtual_class_notification_id")
    public Long getVirtualClassNotificationId() {
        return virtualClassNotificationId;
    }

    public void setVirtualClassNotificationId(Long virtualClassNotificationId) {
        this.virtualClassNotificationId = virtualClassNotificationId;
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
        VirtualClassNotification that = (VirtualClassNotification) o;
        return Objects.equals(virtualClassNotificationId, that.virtualClassNotificationId) &&
                Objects.equals(notificationText, that.notificationText) &&
                Objects.equals(user, that.user) &&
                Objects.equals(virtualClass, that.virtualClass);
    }

    @Override
    public int hashCode() {
        return Objects.hash(virtualClassNotificationId, notificationText);
    }

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @ManyToOne
    @JoinColumn(name = "virtual_class_id", referencedColumnName = "virtual_class_id", nullable = false)
    public VirtualClass getVirtualClass() {
        return virtualClass;
    }

    public void setVirtualClass(VirtualClass virtualClass) {
        this.virtualClass = virtualClass;
    }
}
