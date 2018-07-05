package artsoftconsult.study.dto.model;

import java.sql.Date;

public class PageCommentDTO {
    private Long pageCommentId;
    private Date creationDate;
    private String content;
    private UserDTO user;
    private PageDTO page;

    public Long getPageCommentId() {
        return pageCommentId;
    }

    public void setPageCommentId(Long replyCommentId) {
        this.pageCommentId = replyCommentId;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public PageDTO getPage() {
        return page;
    }

    public void setPage(PageDTO page) {
        this.page = page;
    }


}

