package com.example.converter;

import com.example.dto.ContentDTO;
import com.example.entity.ContentEntity;
import org.springframework.stereotype.Component;

@Component
public class ContentConverter {
    public ContentDTO toDTO(ContentEntity entity) {
        ContentDTO dto = new ContentDTO();
        dto.setId(entity.getId());
        dto.setName(entity.getName());
        dto.setChapterId(entity.getChapter().getId());
        return dto;
    }
}
