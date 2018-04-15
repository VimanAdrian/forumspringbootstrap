package artsoftconsult.study.repository;

import artsoftconsult.study.model.Question;
import artsoftconsult.study.model.User;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.jmx.export.annotation.ManagedOperation;

public interface QuestionRepository extends PagingAndSortingRepository<Question, Long>, QuestionRepositoryCustom {

    Question findByQuestionId(@Param("questionId")Long questionId);

    @Modifying
    @Query(value = "UPDATE question SET views = views + 1 WHERE question_id = :questionId", nativeQuery = true)
    void incrementView(@Param("questionId")Long questionId);

    @Query(value = "SELECT vote_type FROM votes_users_questions WHERE question_id =:questionId AND user_id = :userId", nativeQuery = true)
    Integer findVoteType(@Param("questionId")Long questionId, @Param("userId")Long userId);

    @Modifying
    @Query(value = "UPDATE votes_users_questions SET vote_type = :newVote WHERE question_id=:questionId AND user_id=:userId", nativeQuery = true)
    void changeVote(@Param("questionId")Long questionId, @Param("userId")Long userId, @Param("newVote")Integer newVote);

    @Modifying
    @Query(value = "INSERT INTO votes_users_questions(user_id, question_id, vote_type) VALUES (:userId, :questionId, :voteType)", nativeQuery = true)
    void newVote(@Param("questionId")Long questionId, @Param("userId")Long userId, @Param("newVote")Integer newVote);

    @Modifying
    @Query(value = "UPDATE question SET score = score + :newVote WHERE question_id=:questionId", nativeQuery = true)
    void updateScore(@Param("questionId")Long questionId, @Param("newVote")Integer newVote);

    @Modifying
    @Query(value = "UPDATE question SET active = NOT active WHERE question_id=:questionId", nativeQuery = true)
    void toggleStatus(@Param("questionId")Long questionId);

    @Modifying
    @Query(value="UPDATE question SET title = :title, content=:content WHERE question_id=:questionId", nativeQuery = true)
    void updateTitleAndContent(@Param("title")String title, @Param("content")String content, @Param("questionId")Long questionId);
}
