package artsoftconsult.study.repository;

import artsoftconsult.study.model.VirtualClassRights;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

public interface VirtualClassRightsRepository extends PagingAndSortingRepository<VirtualClassRights, Long> {

    @Query(value = "SELECT * FROM virtual_class_rights WHERE virtual_class_id = :virtualClassId AND user_id = :userId", nativeQuery = true)
    VirtualClassRights findByUserIdAndClassId(@Param("virtualClassId") Long virtualClassId, @Param("userId") Long userId);

}
