package artsoftconsult.study.repository;

import artsoftconsult.study.model.User;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public interface UserRepository extends PagingAndSortingRepository<User, Long> {

    List<User> findAll();

    User findByEmail(String email);

    User findByUsername(String username);

    User findByUserId(Long userId);

    @Modifying
    @Query(value = "UPDATE users SET password=:password WHERE user_id=:userId", nativeQuery = true)
    User updatePasswordById(@Param("password") String password, @Param("userId") Long userId);

    @Modifying
    @Query(value = "UPDATE users SET role=:role WHERE user_id=:userId", nativeQuery = true)
    User updateRoleById(@Param("role")String role,@Param("userId")Long userId);

    @Modifying
    @Query(value = "UPDATE users SET enabled = NOT enabled WHERE user_id=:userId", nativeQuery = true)
    User toggleEnabled(@Param("userId")Long userId);

    @Modifying
    @Query(value = "UPDATE users SET profile_image = :profileImage WHERE username=:username", nativeQuery = true)
    User updateProfileImage(@Param("profileImage")String profileImage,@Param("username")String username);

    @Modifying
    @Query(value = "UPDATE users SET account_non_locked = FALSE WHERE user_id=:userId", nativeQuery = true)
    User block(@Param("userId")Long userId);


}
