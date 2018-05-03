package artsoftconsult.study.repository;

import artsoftconsult.study.model.VirtualClass;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

public interface VirtualClassRepository extends PagingAndSortingRepository<VirtualClass, Long> {

    VirtualClass findByVirtualClassId(Long id);

    @Modifying
    @Query(value = "UPDATE virtual_classes SET views = views + 1 WHERE virtual_class_id = :classId", nativeQuery = true)
    void incrementView(@Param("classId") Long classId);

    @Query(value = "SELECT vote_type FROM votes_users_virtual_classes WHERE virtual_class_id =:classId AND user_id = :userId", nativeQuery = true)
    Integer findVoteType(@Param("classId") Long classId, @Param("userId") Long userId);
}
