package com.example.repository;

import com.example.entity.UserEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<UserEntity, Long> {
    UserEntity findOneByUserNameAndStatus(String name, int status);

    UserEntity findOneByUserName(String username);

    List<UserEntity> findByUserNameStartsWith(String str, Pageable pageable);

    List<UserEntity> findByUserNameStartsWith(String str);
}
