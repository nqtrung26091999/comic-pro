package com.example.converter;

import com.example.dto.CategoryDTO;
import com.example.dto.ComicDTO;
import com.example.entity.CategoryEntity;
import com.example.entity.ComicEntity;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class ComicConverter {
    public ComicDTO toDTO(ComicEntity entity) {
        ComicDTO dto = new ComicDTO();
        List<CategoryDTO> categories = new ArrayList<>();
        dto.setName(entity.getName());
        dto.setCode(entity.getCode());
        dto.setCover(entity.getCover());
        dto.setAuthor(entity.getAuthor());
        dto.setCreatedDate(entity.getCreatedDate());
        dto.setModifiedDate(entity.getModifiedDate());
        if (entity.getCategories() != null) {
            for (CategoryEntity categoryEntity : entity.getCategories()) {
                CategoryDTO categoryDTO = new CategoryDTO();
                categoryDTO.setId(categoryEntity.getId());
                categoryDTO.setCode(categoryEntity.getCode());
                categoryDTO.setName(categoryEntity.getName());
                categoryDTO.setDescription(categoryEntity.getDescription());
                categories.add(categoryDTO);
            }
            dto.setListCategory(categories);
        }
        dto.setDescription(entity.getDescription());
        dto.setId(entity.getId());
        return dto;
    }

    public ComicEntity toEntity(ComicDTO dto) {
        ComicEntity entity = new ComicEntity();
        entity.setAuthor(dto.getAuthor());
        entity.setName(dto.getName());
        entity.setCode(dto.getCode());
        entity.setCover(dto.getCover());
        entity.setDescription(dto.getDescription());
        return entity;
    }

    public ComicEntity toEntity(ComicEntity entity, ComicDTO dto) {
        entity.setAuthor(dto.getAuthor());
        entity.setName(dto.getName());
        entity.setCode(dto.getCode());
        if (dto.getCover() != null) {
            entity.setCover(dto.getCover());
        }
        entity.setDescription(dto.getDescription());
        return entity;
    }
}
