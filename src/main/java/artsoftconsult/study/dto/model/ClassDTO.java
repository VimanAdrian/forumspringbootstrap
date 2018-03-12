package artsoftconsult.study.dto.model;

import java.sql.Date;
import java.util.Collection;

public class ClassDTO {
    private Long classId;
    private String title;
    private String description;
    private Date created;
    private Date lastActive;
    private String visibility;
    private Long score;
    private Long views;
    private Boolean active;
    private UserDTO userByOwner;
    private Collection<LectureDTO> lecturesByClassId;

    public Long getClassId() {
        return classId;
    }

    public void setClassId(Long classId) {
        this.classId = classId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public Date getLastActive() {
        return lastActive;
    }

    public void setLastActive(Date lastActive) {
        this.lastActive = lastActive;
    }

    public String getVisibility() {
        return visibility;
    }

    public void setVisibility(String visibility) {
        this.visibility = visibility;
    }

    public Long getScore() {
        return score;
    }

    public void setScore(Long score) {
        this.score = score;
    }

    public Long getViews() {
        return views;
    }

    public void setViews(Long views) {
        this.views = views;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public UserDTO getUserByOwner() {
        return userByOwner;
    }

    public void setUserByOwner(UserDTO userByOwner) {
        this.userByOwner = userByOwner;
    }

    public Collection<LectureDTO> getLecturesByClassId() {
        return lecturesByClassId;
    }

    public void setLecturesByClassId(Collection<LectureDTO> lecturesByClassId) {
        this.lecturesByClassId = lecturesByClassId;
    }
}
