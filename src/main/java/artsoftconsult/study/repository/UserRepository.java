package artsoftconsult.study.repository;

import artsoftconsult.study.model.generated2.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
}
