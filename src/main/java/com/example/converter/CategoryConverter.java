package com.example.converter;

import com.example.dto.CategoryDTO;
import com.example.entity.CategoryEntity;
import org.springframework.stereotype.Component;

@Component
public class CategoryConverter {
    public CategoryDTO toDTO(CategoryEntity entity) {
        CategoryDTO result = new CategoryDTO();
        result.setId(entity.getId());
        result.setName(entity.getName());
        result.setCode(entity.getCode());
        result.setDescription(entity.getDescription());
        return result;
    }

    public CategoryEntity toEntity(CategoryDTO dto) {
        CategoryEntity result = new CategoryEntity();
        result.setCode(dto.getCode());
        result.setName(dto.getName());
        result.setDescription(dto.getDescription());
        return result;
    }

    public CategoryEntity toEntity(CategoryEntity entity, CategoryDTO dto) {
        entity.setDescription(dto.getDescription());
        entity.setName(dto.getName());
        entity.setCode(dto.getCode());
        return entity;
    }
}
