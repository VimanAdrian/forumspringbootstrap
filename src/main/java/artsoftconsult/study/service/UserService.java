package artsoftconsult.study.service;

import artsoftconsult.study.dto.model.UserDTO;
import artsoftconsult.study.model.Question;
import artsoftconsult.study.model.User;
import artsoftconsult.study.repository.QuestionRepository;
import artsoftconsult.study.repository.TokenRepositoryImpl;
import artsoftconsult.study.repository.UserRepository;
import artsoftconsult.study.utils.Email;
import artsoftconsult.study.utils.RandomUtils;
import artsoftconsult.study.validator.UserValidator;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

@Service
public class UserService implements Serializable {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserValidator userValidator;
    @Autowired
    private Email email;
    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private ModelMapper modelMapper;
    @Autowired
    private PasswordEncoder bCryptPasswordEncoder;
    @Autowired
    private TokenRepositoryImpl tokenRepositoryImpl;

    public UserService() {
    }

    private User prepareForSave(User user) {
        user.setUserId(null);
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRole("ROLE_USER");
        user.setCreationDate(new Date(System.currentTimeMillis()));
        user.setEnabled(false);
        user.setProfileImage("/profileImage/generic.png");
        user.setAccountNonLocked(true);
        user.setType("NORMAL");
        return user;
    }

    private User prepareForUpdate(User userFromDb, User userFromDto) {
        userFromDto.setType(userFromDb.getType());
        userFromDto.setAccountNonLocked(userFromDb.getAccountNonLocked());
        userFromDto.setEnabled(userFromDb.getEnabled());
        userFromDto.setCreationDate(userFromDb.getCreationDate());
        userFromDto.setRole(userFromDb.getRole());
        userFromDto.setPassword(userFromDb.getRole());
        userFromDto.setEmail(userFromDb.getEmail());
        userFromDto.setUserId(userFromDb.getUserId());
        return userFromDto;
    }

    public boolean save(UserDTO user) {
        if (userValidator.validate(user)) {
            User userFromDto = new User();
            modelMapper.map(user, userFromDto);
            userFromDto = prepareForSave(userFromDto);
            if ((userRepository.findByEmail(userFromDto.getEmail()) == null) && (userRepository.findByUsername(userFromDto.getUsername()) == null)) {
                User savedUser = userRepository.saveAndFlush(userFromDto);
                if (savedUser != null)
                    if (savedUser.getUserId() != null) {
                        sendToken(savedUser);
                        return true;
                    }
            }
        }
        return false;
    }

    public boolean updateUser(UserDTO user) {
        User userFromDb = userRepository.findByUsername(user.getEmail());
        User userFromDto = new User();
        modelMapper.map(user, userFromDto);
        userFromDto = prepareForUpdate(userFromDb, userFromDto);
        userRepository.save(userFromDto);
        return true;
    }

    public boolean sendToken(User user) {
        String token = RandomUtils.randomString(30);
        tokenRepositoryImpl.deleteToken(user.getUserId());
        if (tokenRepositoryImpl.saveToken(user.getUserId(), token)) {
            email.sendActivationEmail(user.getEmail(), user.getUsername(), "http://localhost:8080/activate?token=" + token + "&userId=" + user.getUserId());
            return true;
        }
        return false;
    }

    public boolean useToken(String token, Long userId) {
        long found = tokenRepositoryImpl.findToken(token, userId);
        if (found != 0) {
            long timeCurrent = new java.util.Date().getTime();
            if (timeCurrent - found > 7200000) {
                tokenRepositoryImpl.deleteToken(userId);
                return false;
            } else {
                tokenRepositoryImpl.deleteToken(userId);
                enableUser(userId);
                return true;
            }
        }
        return false;
    }

    private boolean enableUser(Long userId) {
        User user = userRepository.findByUserId(userId);
        if (user != null) {
            user.setEnabled(true);
            userRepository.save(user);
            return true;
        }
        return false;
    }

    public boolean sendPasswordReset(UserDTO userFromDto) {
        User user = userRepository.findByUsername(userFromDto.getUsername());
        if (user != null) {
            String token = RandomUtils.randomString(30);
            tokenRepositoryImpl.deletePasswordReset(user.getUserId());
            if (tokenRepositoryImpl.savePasswordReset(user.getUserId(), token)) {
                email.sendPasswordResetEmail(user.getEmail(), user.getUsername(), "http://localhost:8080/reset?token=" + token + "&userId=" + user.getUserId());
                return true;
            }
        }
        return false;
    }

    public boolean usePasswordReset(String token, Long userId) {
        long found = tokenRepositoryImpl.findPasswordResetToken(token, userId);
        if (found != 0) {
            long timeCurrent = new java.util.Date().getTime();
            if (timeCurrent - found > 7200000) {
                tokenRepositoryImpl.deletePasswordReset(userId);
                return false;
            } else {
                tokenRepositoryImpl.deletePasswordReset(userId);
                return true;
            }
        }
        return false;
    }

    public boolean resetPassword(UserDTO user) {
        User userFromDto = new User();
        modelMapper.map(user, userFromDto);
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        if (userValidator.validateUserPassword(user)) {
            userRepository.updatePasswordById(user.getPassword(), user.getUserId());
            return true;
        }
        return false;
    }

    public User[] getAll() {
        return userRepository.findAll().toArray(new User[0]);
    }

    public boolean makeAdmin(User user) {
        userRepository.updateRoleById("ROLE_ADMIN", user.getUserId());
        return true;
    }

    public User find(String username) {
        return userRepository.findByUsername(username);
    }

    public User find(Long id) {
        return userRepository.findByUserId(id);
    }

    public Long toggleEnabled(User user) {
        return userRepository.toggleEnabled(user.getUserId()).getUserId();
    }

    public Page<User> getUserList(Integer page, Integer size) {
        return userRepository.findAll(new PageRequest(page, size));
    }

    public void updateProfileImage(String filename, String username) {
        userRepository.updateProfileImage("/profileImage/" + filename, username);
    }

    public List<Question> newAnswers(User user) {
        return questionRepository.newReplies(find(user.getUsername()).getUserId());
    }

    public List<Question> topQuestions(User user) {
        return questionRepository.topQuestion(user.getUserId());
    }

    public void block(String username) {
        User user = userRepository.findByUsername(username);
        if (user.getEmail() != null) {
            email.sendAccountLockedEmail(user.getEmail(), username);
        }
        userRepository.block(user.getUserId());
    }

}
