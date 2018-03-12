package artsoftconsult.study.dto.model;

import java.sql.Date;
import java.util.Collection;

public class ChapterDTO {
    private Long chapterId;
    private String title;
    private String description;
    private Date created;
    private Date lastActive;
    private String visibility;
    private Long score;
    private Long views;
    private Boolean active;
    private Collection<PageDTO> pagesByChapterId;

    public Long getChapterId() {
        return chapterId;
    }

    public void setChapterId(Long chapterId) {
        this.chapterId = chapterId;
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

    public Collection<PageDTO> getPagesByChapterId() {
        return pagesByChapterId;
    }

    public void setPagesByChapterId(Collection<PageDTO> pagesByChapterId) {
        this.pagesByChapterId = pagesByChapterId;
    }
}
