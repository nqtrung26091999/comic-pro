package com.example.repository;

import com.example.entity.ComicEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ComicRepository extends JpaRepository<ComicEntity, Long> {
    @Query("SELECT c FROM ComicEntity c WHERE c.createdDate = (SELECT MAX(co.createdDate) FROM ComicEntity co)")
    ComicEntity findComicEntityByMaxCreatedDate();
}
