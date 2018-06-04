package artsoftconsult.study.dto.model;

import java.sql.Date;
import java.util.Collection;

public class VirtualClassDTO {
    private Long virtualClassId;
    private String title;
    private String description;
    private String rawDescription;
    private Date created;
    private Date lastActive;
    private String visibility;
    private Long score;
    private Long views;
    private Boolean active;
    private UserDTO user;
    private Collection<LectureDTO> lectures;
    private Collection<CategoryDTO> virtualClassCategories;
    private Integer voteType;
    private Boolean deleted;

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }
    public Long getVirtualClassId() {
        return virtualClassId;
    }

    public void setVirtualClassId(Long virtualClassId) {
        this.virtualClassId = virtualClassId;
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

    public String getRawDescription() {
        return rawDescription;
    }

    public void setRawDescription(String rawDescription) {
        this.rawDescription = rawDescription;
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

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public Collection<LectureDTO> getLectures() {
        return lectures;
    }

    public void setLectures(Collection<LectureDTO> lectures) {
        this.lectures = lectures;
    }

    public Collection<CategoryDTO> getVirtualClassCategories() {
        return virtualClassCategories;
    }

    public void setVirtualClassCategories(Collection<CategoryDTO> virtualClassCategories) {
        this.virtualClassCategories = virtualClassCategories;
    }

    public Integer getVoteType() {
        return voteType;
    }

    public void setVoteType(Integer voteType) {
        this.voteType = voteType;
    }
}
