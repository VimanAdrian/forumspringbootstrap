package artsoftconsult.study.model.generated2;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "class_rights")
public class ClassRights {
    private Long classEditId;
    private Boolean canView;
    private Boolean canEdit;
    private Boolean canPost;
    private User userByUserId;
    private Class classByClassId;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "class_edit_id")
    public Long getClassEditId() {
        return classEditId;
    }

    public void setClassEditId(Long classEditId) {
        this.classEditId = classEditId;
    }

    @Basic
    @Column(name = "can_view")
    public Boolean getCanView() {
        return canView;
    }

    public void setCanView(Boolean canView) {
        this.canView = canView;
    }

    @Basic
    @Column(name = "can_edit")
    public Boolean getCanEdit() {
        return canEdit;
    }

    public void setCanEdit(Boolean canEdit) {
        this.canEdit = canEdit;
    }

    @Basic
    @Column(name = "can_post")
    public Boolean getCanPost() {
        return canPost;
    }

    public void setCanPost(Boolean canPost) {
        this.canPost = canPost;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ClassRights that = (ClassRights) o;
        return Objects.equals(classEditId, that.classEditId) &&
                Objects.equals(canView, that.canView) &&
                Objects.equals(canEdit, that.canEdit) &&
                Objects.equals(canPost, that.canPost);
    }

    @Override
    public int hashCode() {
        return Objects.hash(classEditId, canView, canEdit, canPost);
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
