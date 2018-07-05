package artsoftconsult.study.repository;

import artsoftconsult.study.model.Lecture;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

public interface LectureRepository extends PagingAndSortingRepository<Lecture, Long> {

    Lecture findByLectureIdAndDeletedFalse(Long lectureId);

    @Modifying
    @Query(value = "UPDATE lectures SET views = views + 1 WHERE lecture_id = :lectureId", nativeQuery = true)
    void incrementView(@Param("lectureId") Long lectureId);

    @Query(value = "SELECT vote_type FROM votes_users_lectures WHERE lecture_id =:lectureId AND user_id = :userId", nativeQuery = true)
    Integer findVoteType(@Param("lectureId") Long lectureId, @Param("userId") Long userId);

    @Modifying
    @Query(value = "UPDATE lectures SET title = :title, description=:description WHERE lecture_id=:lectureId", nativeQuery = true)
    void updateTitleAndDescription(@Param("title") String title, @Param("description") String description, @Param("lectureId") Long lectureId);

    @Modifying
    @Query(value = "UPDATE votes_users_lectures SET vote_type = :newVote WHERE lecture_id=:lectureId AND user_id=:userId", nativeQuery = true)
    void changeVote(@Param("lectureId") Long lectureId, @Param("userId") Long userId, @Param("newVote") Integer newVote);

    @Modifying
    @Query(value = "UPDATE lectures SET score = score + :newVote WHERE lecture_id=:lectureId", nativeQuery = true)
    void updateScore(@Param("lectureId") Long lectureId, @Param("newVote") int i);

    @Modifying
    @Query(value = "INSERT INTO votes_users_lectures(user_id, lecture_id, vote_type) VALUES (:userId, :lectureId, :newVote)", nativeQuery = true)
    void newVote(@Param("lectureId") Long lectureId, @Param("userId") Long userId, @Param("newVote") Integer newVote);

    @Modifying
    @Query(value = "UPDATE lectures SET deleted = TRUE where lecture_id=:lectureId", nativeQuery = true)
    void logicalDelete(@Param("lectureId") Long lectureId);

    Lecture findByLectureId(Long lectureId);

    Page<Lecture> findByTitleContainingOrDescriptionContainingAndDeletedFalse(Pageable pageable, String title, String description);

}
