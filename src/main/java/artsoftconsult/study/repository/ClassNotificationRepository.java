package artsoftconsult.study.repository;

import artsoftconsult.study.model.ClassNotification;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

public interface ClassNotificationRepository extends PagingAndSortingRepository<ClassNotification, Long> {
}
