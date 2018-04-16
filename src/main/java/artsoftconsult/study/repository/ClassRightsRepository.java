package artsoftconsult.study.repository;

import artsoftconsult.study.model.ClassRights;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

public interface ClassRightsRepository extends PagingAndSortingRepository<ClassRights, Long> {
}
