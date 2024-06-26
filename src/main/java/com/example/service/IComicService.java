package com.example.service;

import com.example.dto.ComicDTO;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.List;

public interface IComicService {
    ComicDTO insert(ComicDTO dto);
    ResponseEntity<String> uploadImageCover(MultipartFile imageCover, Long id);
    int getTotalItem(String search);
    String getNameComicById(Long id);
    List<ComicDTO> findAll(Pageable pageable);
    List<ComicDTO> findAll();
    List<ComicDTO> searchComic(String search, Pageable pageable);
//    ComicDTO searchComic(String search);
    ComicDTO findOne(Long id);
    ComicDTO update(ComicDTO comicDTO);
    ComicDTO findOneNewest();
    void deleteComic(ComicDTO comicDTO);

    List<ComicDTO> findByCategoryId(Long categoryId);

    void updateHistory(String username, Long chapterId);
}
