package artsoftconsult.study.dto.model;

import artsoftconsult.study.model.PageComment;

import java.sql.Date;
import java.util.Collection;

public class PageDTO {
    private Long pageId;
    private String content;
    private String rawContent;
    private Date created;
    private Date lastActive;
    private Boolean active;
    private LectureDTO chapter;
    private Boolean deleted;
    private Collection<PageComment> pageComment;

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }
    public Long getPageId() {
        return pageId;
    }

    public void setPageId(Long pageId) {
        this.pageId = pageId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getRawContent() {
        return rawContent;
    }

    public void setRawContent(String rawContent) {
        this.rawContent = rawContent;
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

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public LectureDTO getChapter() {
        return chapter;
    }

    public void setChapter(LectureDTO chapter) {
        this.chapter = chapter;
    }

    public Collection<PageComment> getPageComment() {
        return pageComment;
    }

    public void setPageComment(Collection<PageComment> pageComment) {
        this.pageComment = pageComment;
    }
}
