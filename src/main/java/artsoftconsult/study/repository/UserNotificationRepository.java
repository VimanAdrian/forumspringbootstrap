package artsoftconsult.study.repository;

import artsoftconsult.study.model.UserNotification;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

public interface UserNotificationRepository extends PagingAndSortingRepository<UserNotification, Long> {
}
