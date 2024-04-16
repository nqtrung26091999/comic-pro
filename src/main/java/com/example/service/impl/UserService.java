package com.example.service.impl;

import com.example.constant.AWSConstant;
import com.example.constant.SystemConstant;
import com.example.converter.RoleConverter;
import com.example.converter.UserConverter;
import com.example.dto.RoleDTO;
import com.example.dto.UserDTO;
import com.example.entity.RoleEntity;
import com.example.entity.UserEntity;
import com.example.repository.RoleRepository;
import com.example.repository.UserRepository;
import com.example.service.IUserService;
import com.example.service.awss3.AWSClient;
import com.example.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
public class UserService implements IUserService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserConverter userConverter;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private RoleConverter roleConverter;
    @Autowired
    private AWSClient awsClient;

    @Override
    @Transactional
    public UserDTO registerUser(UserDTO dto) {
        UserEntity result = userRepository.findOneByUserName(dto.getUsername());
        UserEntity userEntity = userConverter.toEntity(dto);
        List<RoleEntity> listRole = new ArrayList<>();
        List<String> roles = SecurityUtils.getAuthorities();
        if (result != null) {
            return null;
        }
        if (!Objects.equals(dto.getPassword(), dto.getRePassword())) {
            return null;
        }
        RoleEntity role;
        if (!roles.contains(SystemConstant.ROLE_ANONYMOUS)) {
            role = roleRepository.findByCode(dto.getRoleCode());
        } else {
            role = roleRepository.findByCode(SystemConstant.ROLE_USER);
        }
        if (role != null) {
            listRole.add(role);
            userEntity.setRoles(listRole);
        }
        userEntity.setStatus(SystemConstant.ACTIVE_STATUS);
        return userConverter.toDTO(userRepository.save(userEntity));
    }

    @Override
    public UserDTO findOneByUsername(String username) {
        return userConverter.toDTO(userRepository.findOneByUserName(username));
    }

    @Override
    public UserDTO findOneById(Long id) {
        UserEntity entity = userRepository.findOne(id);
        return userConverter.toDTO(entity);
    }

    @Override
    public List<UserDTO> findAll(Pageable pageable) {
        List<UserDTO> list = new ArrayList<>();
        List<UserEntity> userEntities = userRepository.findAll(pageable).getContent();
        for (UserEntity entity : userEntities) {
            UserDTO dto = userConverter.toDTO(entity);
            list.add(dto);
        }
        return list;
    }

    @Override
    public void uploadAvatar(MultipartFile avt, Long userId) {
        UserEntity entity = userRepository.findOne(userId);
        String path = AWSConstant.PATH_USER_S3 + entity.getId() + "/";
        String url = awsClient.uploadFile(avt, path);
        entity.setAvatar(url);
        userRepository.save(entity);
    }

    @Override
    public int getTotalItem(String search) {
        int count;
        if (search != null) {
            count = userRepository.findByUserNameStartsWith(search).size();
        } else {
            count = (int) userRepository.count();
        }
        return count;
    }

    @Override
    @Transactional
    public UserDTO updateUser(UserDTO dto) {
        long[] ids = dto.getIds();
        List<UserDTO> list = new ArrayList<>();
        UserDTO result = new UserDTO();
        if (ids != null) {
            for (long id : ids) {
                UserEntity entity = userRepository.findOne(id);
                if (entity != null) {
                    entity.setStatus(SystemConstant.DELETE_STATUS);
                    list.add(userConverter.toDTO(userRepository.save(entity)));
                }
            }
            result.setListResult(list);
            return result;
        }
        UserEntity oldUser = userRepository.findOne(dto.getId());
        UserEntity newUser = userConverter.toEntity(oldUser, dto);
        newUser.setStatus(1);
        return userConverter.toDTO(userRepository.save(newUser));
    }

    @Override
    public List<UserDTO> searchUser(String str, Pageable pageable) {
        if (str != null) {
            List<UserEntity> list = userRepository.findByUserNameStartsWith(str, pageable);
            List<UserDTO> listResult = new ArrayList<>();
            for (UserEntity entity : list) {
                UserDTO dto = userConverter.toDTO(entity);
                listResult.add(dto);
            }
            return listResult;
        }
        return null;
    }

    @Override
    public List<RoleDTO> findAllRoles() {
        List<RoleEntity> roleEntityList = roleRepository.findAll();
        List<RoleDTO> result = new ArrayList<>();
        for (RoleEntity roleEntity : roleEntityList) {
            RoleDTO roleDTO = roleConverter.toDTO(roleEntity);
            result.add(roleDTO);
        }
        return result;
    }
}
