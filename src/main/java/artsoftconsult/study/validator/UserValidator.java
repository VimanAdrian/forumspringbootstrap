package artsoftconsult.study.validator;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class UserValidator {

    public UserValidator() {
    }

    public boolean validateUserPassword(User user) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        return passwordEncoder.matches(user.getPassword2(), user.getPassword());
    }

}
