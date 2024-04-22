package com.example.repository;

import com.example.entity.ChapterEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ChapterRepository extends JpaRepository<ChapterEntity, Long> {
    int countByComicId(Long comicId);
    List<ChapterEntity> findByComicId(Long id, Pageable pageable);
    List<ChapterEntity> findByComicId(Long id);
}
