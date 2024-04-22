package com.example.converter;

import com.example.dto.ChapterDTO;
import com.example.entity.ChapterEntity;
import org.springframework.stereotype.Component;

@Component
public class ChapterConverter {
    public ChapterDTO toDTO(ChapterEntity entity) {
        ChapterDTO dto = new ChapterDTO();
        dto.setName(entity.getName());
        dto.setModifiedDate(entity.getModifiedDate());
        dto.setCreatedDate(entity.getCreatedDate());
        dto.setComicId(entity.getComic().getId());
        dto.setId(entity.getId());
        return dto;
    }

    public ChapterEntity toEntity(ChapterDTO dto) {
        ChapterEntity entity = new ChapterEntity();
        entity.setName(dto.getName());
        return entity;
    }

    public ChapterEntity toEntity(ChapterEntity entity, ChapterDTO dto) {
        entity.setName(dto.getName());
        return entity;
    }
}
