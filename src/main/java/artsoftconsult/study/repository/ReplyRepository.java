package artsoftconsult.study.repository;

import artsoftconsult.study.model.Reply;
import artsoftconsult.study.model.User;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

public interface ReplyRepository extends PagingAndSortingRepository<Reply, Long> {

    @Modifying
    @Query(value = "UPDATE reply SET bestanswer = NOT enabled WHERE user_id=:userId", nativeQuery = true)
    User toggleEnabled(@Param("userId")Long userId);

    @Query(value="SELECT COUNT(*) FROM reply WHERE question_id=:questionId", nativeQuery = true)
    Integer findCount(@Param("questionId")Long questionId);

    @Query(value="SELECT COUNT(*) FROM reply WHERE question_id=:questionId AND enabled=TRUE", nativeQuery = true)
    Integer findCountWithoutDisabled(@Param("questionId")Long questionId);

    @Modifying
    @Query(value = "DELETE FROM user_new_replies WHERE question_id = :questionId and user_id = :userId" , nativeQuery = true)
    void markNotNew(@Param("questionId")Long questionId, @Param("userId")Long userId);

    @Query(value = "SELECT vote_type FROM votes_users_replies WHERE reply_id = :replyId AND user_id = :userId", nativeQuery = true)
    Integer findVoteType(@Param("replyId")Long replyId, @Param("userId")Long userId);
}
