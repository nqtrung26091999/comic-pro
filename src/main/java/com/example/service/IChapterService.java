package com.example.service;

import com.example.dto.ChapterDTO;
import org.springframework.data.domain.Pageable;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.List;

public interface IChapterService {
    int totalChapter(Long comicId);

    int getTotalItem(String search);

    List<ChapterDTO> findByComicId(Long id, Pageable pageable);

    List<ChapterDTO> searchComic(String search, Pageable pageable);

    ChapterDTO findOne(Long id);

    ChapterDTO save(ChapterDTO dto) throws Exception;

    void remove(ChapterDTO dto);

    ChapterDTO searchCategory(String search);

    String getNameChapterById(Long chapterId);
}
