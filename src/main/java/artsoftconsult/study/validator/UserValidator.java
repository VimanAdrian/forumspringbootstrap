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
        if (user.getPassword().equals(user.getConfirmationPassword()))
            return user.getPassword().matches("^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{4,32}$");
        return false;
    }

    private boolean validateUserPasswordMatching(UserDTO user) {
        return user.getConfirmationPassword().equals(user.getPassword());
    }

    /*
        http://emailregex.com
     */
    private boolean validateUserEmail(UserDTO user) {
        return user.getEmail().matches("^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$");
    }

    /*
        Only contains alphanumeric characters, underscore.
        Number of characters must be between 4 to 32.
     */
    private boolean validateUserUsername(UserDTO user) {
        return user.getUsername().matches("^[A-Za-z0-9_]{4,32}$");
    }

    private boolean validateProfileImage(UserDTO user) {
        return (user.getProfileImage().equals("/profileImage/generic.png") || user.getProfileImage().matches("(https?:\\/\\/.*\\.(?:png|jpg|jpeg|gif))") || user.getProfileImage().equals("") || user.getProfileImage() == null);
    }

    private boolean validateName(UserDTO user) {
        return (user.getFirstName().length() > 0 && user.getLastName().length() > 0);
    }

    public boolean validate(UserDTO userFromDto) {
        return (validateUserEmail(userFromDto)) &&
                (validateUserPasswordMatching(userFromDto)) &&
                (validateUserUsername(userFromDto)) &&
                (validateProfileImage(userFromDto)) &&
                (validateName(userFromDto)) &&
                (validateUserPassword(userFromDto));
    }

    public boolean validateUpdate(UserDTO userDTO) {
        return (validateProfileImage(userDTO)) && validateName(userDTO);
    }
}
