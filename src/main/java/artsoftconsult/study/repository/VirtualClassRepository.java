package artsoftconsult.study.repository;

import artsoftconsult.study.model.Category;
import artsoftconsult.study.model.User;
import artsoftconsult.study.model.VirtualClass;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface VirtualClassRepository extends PagingAndSortingRepository<VirtualClass, Long>, VirtualClassRepositoryCustom {

    VirtualClass findByVirtualClassIdAndDeletedFalse(Long id);

    @Modifying
    @Query(value = "UPDATE virtual_classes SET views = views + 1 WHERE virtual_class_id = :classId", nativeQuery = true)
    void incrementView(@Param("classId") Long classId);

    @Query(value = "SELECT vote_type FROM votes_users_virtual_classes WHERE virtual_class_id =:classId AND user_id = :userId", nativeQuery = true)
    Integer findVoteType(@Param("classId") Long classId, @Param("userId") Long userId);

    Page<VirtualClass> findByVirtualClassCategoriesAndDeletedFalse(Pageable pageable, Category category);

    Page<VirtualClass> findByTitleContainingOrDescriptionContainingAndDeletedFalse(Pageable pageable, String title, String description);

    Page<VirtualClass> findByUserAndDeletedFalse(Pageable pageable, User searchedBy);

    Page<VirtualClass> findByDeletedFalse(Pageable pageable);

    @Modifying
    @Query(value = "UPDATE virtual_classes SET deleted = TRUE where virtual_class_id = :classId", nativeQuery = true)
    void logicalDelete(@Param("classId") Long classId);

    @Modifying
    @Query(value = "INSERT INTO virtual_class_followers(user_id, virtual_class_id) VALUES(:user_id,:virtual_class_id)", nativeQuery = true)
    void followClass(@Param("virtual_class_id") Long classId, @Param("user_id") Long userId);

    @Query(value = "SELECT virtual_class_follow_id FROM virtual_class_followers WHERE virtual_class_id=:virtual_class_id AND user_id=:user_id", nativeQuery = true)
    Long followsClass(@Param("virtual_class_id") Long classId, @Param("user_id") Long userId);

    @Modifying
    @Query(value = "DELETE FROM virtual_class_followers WHERE virtual_class_id=:virtual_class_id AND user_id=:user_id", nativeQuery = true)
    void unfollowClass(@Param("virtual_class_id") Long classId, @Param("user_id") Long userId);

    @Modifying
    @Query(value = "DELETE FROM virtual_class_notifications WHERE virtual_class_id = :virtual_class_id and user_id = :user_id", nativeQuery = true)
    void markNotNew(@Param("virtual_class_id") Long classId, @Param("user_id") Long userId);

    @Modifying
    @Query(value = "INSERT INTO virtual_class_notifications(user_id, virtual_class_id, notification_text)  VALUES (:user_id, :virtual_class_id, :text)", nativeQuery = true)
    void saveNewActivity(@Param("virtual_class_id") Long classId, @Param("user_id") Long userId, @Param("text") String text);

    @Query(value = "SELECT user_id FROM virtual_class_followers WHERE virtual_class_id=:classId", nativeQuery = true)
    List<Long> findClassFollowers(@Param("classId") Long classId);
}
