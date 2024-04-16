package com.example.converter;

import com.example.dto.RoleDTO;
import com.example.entity.RoleEntity;
import org.springframework.stereotype.Component;

@Component
public class RoleConverter {
    public RoleDTO toDTO(RoleEntity roleEntity) {
        RoleDTO result = new RoleDTO();
        result.setCode(roleEntity.getCode());
        result.setName(roleEntity.getName());
        return result;
    }
}
