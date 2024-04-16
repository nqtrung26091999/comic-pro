package com.example.converter;

import com.example.dto.UserDTO;
import com.example.entity.UserEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class UserConverter {
    public UserDTO toDTO(UserEntity userEntity) {
        UserDTO result = new UserDTO();
        result.setId(userEntity.getId());
        result.setUsername(userEntity.getUserName());
        result.setEmail(userEntity.getEmail());
        result.setFullName(userEntity.getFullName());
        result.setPhone(userEntity.getPhone());
        result.setCreatedDate(userEntity.getCreatedDate());
        result.setStatus(userEntity.getStatus());
        result.setRoleCode(userEntity.getRoles().get(0).getCode());
        result.setAvatar(userEntity.getAvatar());
        return result;
    }

    public UserEntity toEntity(UserDTO userDTO) {
        UserEntity result = new UserEntity();
        result.setEmail(userDTO.getEmail());
        result.setFullName(userDTO.getFullName());
        result.setUserName(userDTO.getUsername());
        result.setPhone(userDTO.getPhone());
        result.setStatus(userDTO.getStatus());
        result.setPassword(new BCryptPasswordEncoder().encode(userDTO.getPassword()));
        return result;
    }

    public UserEntity toEntity(UserEntity entity, UserDTO dto) {
        entity.setUserName(dto.getUsername());
        entity.setPhone(dto.getPhone());
        entity.setFullName(dto.getFullName());
        entity.setStatus(dto.getStatus());
        entity.setEmail(dto.getEmail());
        return entity;
    }
}
