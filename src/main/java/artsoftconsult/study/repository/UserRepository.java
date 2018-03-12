package artsoftconsult.study.repository;

import  artsoftconsult.study.model.generated2.User;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface UserRepository extends PagingAndSortingRepository<User, Long> {
}
