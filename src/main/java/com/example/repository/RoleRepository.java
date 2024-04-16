package com.example.repository;

import com.example.entity.RoleEntity;
import com.example.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<RoleEntity, Long>{
	RoleEntity findByCode(String roleCode);
}
