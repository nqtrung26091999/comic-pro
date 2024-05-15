package com.example.service;

import com.example.dto.History;
import com.example.dto.RoleDTO;
import com.example.dto.UserDTO;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;
import java.util.Objects;

public interface IUserService {
    UserDTO registerUser(UserDTO dto);

    UserDTO findOneByUsername(String username);

    UserDTO findOneById(Long id);

    List<UserDTO> findAll(Pageable pageable);

    void uploadAvatar(MultipartFile avt, Long userId);

    int getTotalItem(String search);

    UserDTO updateUser(UserDTO dto);

    List<UserDTO> searchUser(String str, Pageable pageable);

    List<RoleDTO> findAllRoles();

    List<History> getMapListHistory(String username);
}
