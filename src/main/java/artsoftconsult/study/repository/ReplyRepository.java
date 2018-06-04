package artsoftconsult.study.repository;

import artsoftconsult.study.model.Reply;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

public interface ReplyRepository extends PagingAndSortingRepository<Reply, Long>, ReplyRepositoryCustom {

    Reply findByReplyIdAndDeletedFalse(@Param("replyId") Long replyId);

    @Modifying
    @Query(value = "UPDATE replies SET enabled = NOT enabled WHERE reply_id=:replyId", nativeQuery = true)
    void toggleEnabled(@Param("replyId")Long replyId);

    @Query(value="SELECT COUNT(*) FROM replies WHERE question_id=:questionId", nativeQuery = true)
    Integer findCount(@Param("questionId")Long questionId);

    @Query(value="SELECT COUNT(*) FROM replies WHERE question_id=:questionId AND enabled=TRUE", nativeQuery = true)
    Integer findCountWithoutDisabled(@Param("questionId")Long questionId);

    @Modifying
    @Query(value = "DELETE FROM user_new_replies WHERE question_id = :questionId and user_id = :userId", nativeQuery = true)
    void markNotNew(@Param("questionId") Long questionId, @Param("userId") Long userId);

    @Query(value = "SELECT vote_type FROM votes_users_replies WHERE reply_id = :replyId AND user_id = :userId", nativeQuery = true)
    Integer findVoteType(@Param("replyId")Long replyId, @Param("userId")Long userId);

    @Modifying
    @Query(value = "UPDATE votes_users_replies SET vote_type = :newVote WHERE reply_id=:replyId AND user_id=:userId", nativeQuery = true)
    void changeVote(@Param("replyId")Long replyId, @Param("userId")Long userId, @Param("newVote")Integer newVote);

    @Modifying
    @Query(value = "INSERT INTO votes_users_replies(user_id, reply_id, vote_type) VALUES (:userId, :replyId, :newVote)", nativeQuery = true)
    void newVote(@Param("replyId")Long replyId, @Param("userId")Long userId, @Param("newVote")Integer newVote);

    @Modifying
    @Query(value = "UPDATE replies SET score = score + :newVote WHERE reply_id=:replyId", nativeQuery = true)
    void updateScore(@Param("replyId")Long replyId, @Param("newVote")Integer newVote);

    @Modifying
    @Query(value = "UPDATE replies SET content = :content WHERE reply_id = :replyId", nativeQuery = true)
    void updateContent(@Param("content")String content, @Param("replyId")Long replyId);

    @Modifying
    @Query(value="UPDATE replies SET bestanswer = FALSE WHERE question_id = :questionId", nativeQuery = true)
    void removeFavorite(@Param("questionId")Long questionId);

    @Modifying
    @Query(value = "UPDATE replies SET bestanswer = TRUE WHERE reply_id = :replyId", nativeQuery = true)
    void makeFavorite(@Param("replyId")Long replyId);

    Reply findByReplyId(Long replyId);
}
