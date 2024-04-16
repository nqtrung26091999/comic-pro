package com.example.repository;

import com.example.entity.ContentEntity;
import org.jboss.logging.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ContentRepository extends JpaRepository<ContentEntity, Long> {
    List<ContentEntity> findByChapterId(Long chapterId);
}
