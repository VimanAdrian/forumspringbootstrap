package artsoftconsult.study.dto.model;


public class CategoryDTO {
    private Integer categoryId;
    private String title;
    private String url;

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "CategoryDTO{" +
                "categoryId=" + categoryId +
                ", title='" + title + '\'' +
                ", url='" + url + '\'' +
                '}';
    }
}
