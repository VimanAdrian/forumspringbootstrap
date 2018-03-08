package artsoftconsult.study.dto.converter.impl;

import artsoftconsult.study.dto.converter.DtoConverter;
import artsoftconsult.study.dto.model.UserDTO;
import artsoftconsult.study.model.User;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class UserDtoConverter implements DtoConverter<User, UserDTO>{

    @Override
    public User convertFromDto(UserDTO dto) {
        User user = new User();
        user.setAdmin(dto.getAdmin());
        user.setCreationDate(dto.getCreationDate());
        user.setEmail(dto.getEmail());
        user.setEnabled(dto.getEnabled());
        user.setFirstName(dto.getFirstName());
        user.setLastName(dto.getLastName());
        user.setPassword(dto.getPassword());
        user.setPassword2(dto.getPassword2());
        user.setProfileImage(dto.getProfileImage());
        user.setUserId(dto.getUserId());
        user.setRole(dto.getRole());
        user.setUsername(dto.getUsername());
        return user;
    }

    @Override
    public UserDTO convertToDto(User obj) {
        UserDTO userDTO = new UserDTO();
        userDTO.setAdmin(obj.getAdmin());
        userDTO.setCreationDate(obj.getCreationDate());
        userDTO.setEmail(obj.getEmail());
        userDTO.setEnabled(obj.getEnabled());
        userDTO.setFirstName(obj.getFirstName());
        userDTO.setLastName(obj.getLastName());
        userDTO.setPassword(obj.getPassword());
        userDTO.setPassword2(obj.getPassword2());
        userDTO.setProfileImage(obj.getProfileImage());
        userDTO.setUserId(obj.getUserId());
        userDTO.setRole(obj.getRole());
        userDTO.setUsername(obj.getUsername());
        return userDTO;
    }

    @Override
    public List<User> convertFromDtos(List<UserDTO> dtos) {
        List<User> users = new ArrayList<>();
        for (UserDTO userDTO:dtos) {
            users.add(convertFromDto(userDTO));
        }
        return users;
    }

    @Override
    public List<UserDTO> convertToDtos(List<User> objs) {
        List<UserDTO> userDTOS = new ArrayList<>();
        for (User user:objs) {
            userDTOS.add(convertToDto(user));
        }
        return userDTOS;
    }
}
