package artsoftconsult.study.service;

import artsoftconsult.study.dto.model.UserDTO;
import artsoftconsult.study.model.Question;
import artsoftconsult.study.model.User;
import artsoftconsult.study.model.VirtualClass;
import artsoftconsult.study.repository.QuestionRepository;
import artsoftconsult.study.repository.TokenRepositoryImpl;
import artsoftconsult.study.repository.UserRepository;
import artsoftconsult.study.repository.VirtualClassRepository;
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
import org.springframework.transaction.annotation.Transactional;

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
    @Autowired
    private VirtualClassRepository virtualClassRepository;

    public UserService() {
    }

    private User prepareForSave(User user) {
        user.setUserId(null);
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRole("ROLE_USER");
        user.setCreationDate(new Date(System.currentTimeMillis()));
        user.setEnabled(false);
        if (user.getProfileImage() == null || user.getProfileImage().equals(""))
            user.setProfileImage("/profileImage/generic.png");
        user.setAccountNonLocked(true);
        user.setDeleted(false);
        return user;
    }

    private User prepareForUpdate(User userFromDb, User userFromDto) {
        userFromDto.setAccountNonLocked(userFromDb.getAccountNonLocked());
        userFromDto.setEnabled(userFromDb.getEnabled());
        userFromDto.setCreationDate(userFromDb.getCreationDate());
        userFromDto.setRole(userFromDb.getRole());
        userFromDto.setPassword(userFromDb.getRole());
        userFromDto.setEmail(userFromDb.getEmail());
        userFromDto.setUserId(userFromDb.getUserId());
        return userFromDto;
    }

    @Transactional
    public Integer save(UserDTO user) {
        if (userValidator.validate(user)) {
            if (userRepository.findByEmail(user.getEmail()) == null) {
                if (userRepository.findByUsername(user.getUsername()) == null) {
                    User userFromDto = new User();
                    modelMapper.map(user, userFromDto);
                    userFromDto = prepareForSave(userFromDto);
                    User savedUser = userRepository.saveAndFlush(userFromDto);
                    if (savedUser != null)
                        if (savedUser.getUserId() != null) {
                            sendToken(savedUser);
                            return 1;//success
                        } else {
                            return -4;//something went wrong
                        }
                } else {
                    return -3;//username exists
                }
            } else {
                return -2; //email exists
            }
        }
        return -1; //invalid validation
    }

    @Transactional
    public Integer updateUser(UserDTO user, String username) {
        if (userValidator.validateUpdate(user)) {
            User userFromDb = userRepository.findByUsername(username);
            userFromDb.setFirstName(user.getFirstName());
            userFromDb.setLastName(user.getLastName());
            userFromDb.setProfileImage(user.getProfileImage());
            return 1;
        }
        return -1;
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

    @Transactional
    public boolean enableUser(Long userId) {
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

    @Transactional
    public boolean resetPassword(UserDTO user) {
        if (userValidator.validateUserPassword(user)) {
            BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
            User userFromDb = userRepository.findByUserId(user.getUserId());
            userFromDb.setPassword(passwordEncoder.encode(user.getPassword()));
            userRepository.saveAndFlush(userFromDb);
            return true;
        }
        return false;
    }

    @Transactional(readOnly = true)
    public User[] getAll() {
        return userRepository.findAll().toArray(new User[0]);
    }

    public boolean makeAdmin(User user) {
        userRepository.updateRoleById("ROLE_ADMIN", user.getUserId());
        return true;
    }

    @Transactional(readOnly = true)
    public User find(String username) {
        return userRepository.findByUsername(username);
    }

    @Transactional(readOnly = true)
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

    @Transactional
    public List<Question> newAnswers(User user) {
        return questionRepository.newReplies(find(user.getUsername()).getUserId());
    }

    @Transactional
    public List<Question> topQuestions(User user) {
        return questionRepository.topQuestion(user.getUserId());
    }

    @Transactional
    public void block(String username) {
        User user = userRepository.findByUsername(username);
        if (user.getEmail() != null) {
            email.sendAccountLockedEmail(user.getEmail(), username);
        }
        userRepository.block(user.getUserId());
    }

    public Boolean resendToken(Long userId) {
        User user = userRepository.findByUserId(userId);
        if (user != null) {
            return sendToken(user);
        }
        return false;
    }

    public List<VirtualClass> newClassActivity(User user) {
        return virtualClassRepository.newActivity(user.getUserId());
    }
}
