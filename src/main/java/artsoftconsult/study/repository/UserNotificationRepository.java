package artsoftconsult.study.repository;

import artsoftconsult.study.model.UserNotification;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface UserNotificationRepository extends PagingAndSortingRepository<UserNotification, Long> {
}
