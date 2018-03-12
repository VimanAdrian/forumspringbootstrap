package artsoftconsult.study.dto.model;

import java.sql.Date;
import java.util.Collection;

public class LectureDTO {
    private Long lectureId;
    private String title;
    private String description;
    private Date created;
    private Date lastActive;
    private String visibility;
    private Long score;
    private Long views;
    private Boolean active;
    private Collection<ChapterDTO> chaptersByLectureId;
    private Collection<QuestionDTO> questionsByLectureId;

}
