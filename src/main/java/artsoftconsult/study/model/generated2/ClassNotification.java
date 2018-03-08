package artsoftconsult.study.model.generated2;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "class_notifications")
public class ClassNotification {
    private Long classNotificationId;
    private String notificationText;
    private User userByUserId;
    private Class classByClassId;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "class_notification_id")
    public Long getClassNotificationId() {
        return classNotificationId;
    }

    public void setClassNotificationId(Long classNotificationId) {
        this.classNotificationId = classNotificationId;
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
        ClassNotification that = (ClassNotification) o;
        return Objects.equals(classNotificationId, that.classNotificationId) &&
                Objects.equals(notificationText, that.notificationText);
    }

    @Override
    public int hashCode() {
        return Objects.hash(classNotificationId, notificationText);
    }

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    public User getUserByUserId() {
        return userByUserId;
    }

    public void setUserByUserId(User userByUserId) {
        this.userByUserId = userByUserId;
    }

    @ManyToOne
    @JoinColumn(name = "class_id", referencedColumnName = "class_id", nullable = false)
    public Class getClassByClassId() {
        return classByClassId;
    }

    public void setClassByClassId(Class classByClassId) {
        this.classByClassId = classByClassId;
    }
}
