package artsoftconsult.study.service;

import artsoftconsult.study.model.User;
import artsoftconsult.study.repository.implementation.UserRepository;
import artsoftconsult.study.utils.Email;
import artsoftconsult.study.utils.RandomUtils;
import artsoftconsult.study.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.Serializable;

@Service
public class UserService implements Serializable {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserValidator userValidator;
    @Autowired
    private Email email;

    public UserService() {
    }

    public boolean save(User user) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        Integer userID = -1;
        if (userValidator.validateUserPassword(user))
            userID = userRepository.saveHibernate(user);
        if (userID != -1) {
            user.setUserId(userID);
            sendToken(user);
            return true;
        }
        return false;
    }

    public boolean sendToken(User user) {
        String token = RandomUtils.randomString(30);
        userRepository.deleteToken(user);
        if (userRepository.saveToken(user, token)) {
            email.sendActivationEmail(user.getEmail(), user.getUsername(), "http://localhost:8080/activate?token=" + token + "&userId=" + user.getUserId());
            return true;
        }
        return false;
    }

    public boolean useToken(String token, Integer userID) {
        User user = new User();
        user.setUserId(userID);
        boolean used = userRepository.useToken(token, user);
        userRepository.deleteToken(user);
        return used;
    }

    public boolean sendPasswordReset(User user) {
        String token = RandomUtils.randomString(30);
        userRepository.deletePasswordReset(user);
        if (userRepository.savePasswordReset(user, token)) {
            email.sendPasswordResetEmail(user.getEmail(), user.getUsername(), "http://localhost:8080/reset?token=" + token + "&userId=" + user.getUserId());
            return true;
        }
        return false;
    }

    public boolean usePasswordReset(String token, Integer userID) {
        User user = new User();
        user.setUserId(userID);
        boolean used = userRepository.usePasswordReset(token, user);
        userRepository.deletePasswordReset(user);
        return used;
    }

    public boolean resetPassword(User user) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        if (userValidator.validateUserPassword(user)) {
            user.setPassword2("");
            userRepository.resetPassword(user);
            return true;
        } else
            return false;
    }

    public boolean updateUser(User user) {
        return userRepository.update(user);
    }

    public User[] getAll() {
        return userRepository.getAll();
    }

    public boolean makeAdmin(User user) {
        return userRepository.makeAdmin(user);
    }

    public User find(String username) {
        return userRepository.findByUsername(username);
    }

    public User find(Integer id) {
        return userRepository.findById(id);
    }

    public Integer toggleEnabled(User user) {
        return userRepository.toggleEnabled(user);
    }

    public User[] getUserList(String page) {
        return userRepository.getAll(Integer.valueOf(page));
    }

    public Integer getUserListNext() {
        double nrPag = userRepository.getAllNext() / 20;
        return (int) Math.round(nrPag);
    }

    public void updateProfileImage(String filename, String username) {
        userRepository.updateProfileImage("/profileImage/" + filename, username);
    }
/*
    public void joinulLuiStefii() {
        userRepository.joinulLuiStefii();
    }
*/
}
