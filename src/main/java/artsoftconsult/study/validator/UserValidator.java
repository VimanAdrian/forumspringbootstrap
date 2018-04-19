package artsoftconsult.study.validator;

import artsoftconsult.study.dto.model.UserDTO;
import org.springframework.stereotype.Component;

@Component
public class UserValidator {

    /*
        Password must be at least 4 characters,
        no more than 32 characters, and must include at least one upper case letter,
        one lower case letter, and one numeric digit.
     */
    public boolean validateUserPassword(UserDTO user) {
        return user.getPassword().matches("^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{4,32}$");
    }

    private boolean validateUserPasswordMatching(UserDTO user) {
        return user.getConfirmationPassword().equals(user.getPassword());
    }

    /*
        http://emailregex.com
     */
    private boolean validateUserEmail(UserDTO user) {
        return user.getEmail().matches("(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)])");
    }

    /*
        Only contains alphanumeric characters, underscore and dot.
        Underscore and dot can't be at the end or start of a username (e.g _username / username_ / .username / username.).
        Underscore and dot can't be next to each other (e.g user_.name).
        Underscore or dot can't be used multiple times in a row (e.g user__name / user..name).
        Number of characters must be between 4 to 32.
     */
    private boolean validateUserUsername(UserDTO user) {
        return user.getUsername().matches("^(?=.{4,32}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$");
    }

    public boolean validate(UserDTO userFromDto) {
        return (validateUserEmail(userFromDto)) &&
                (validateUserPasswordMatching(userFromDto)) &&
                (validateUserUsername(userFromDto)) &&
                (validateUserPassword(userFromDto));
    }
}
