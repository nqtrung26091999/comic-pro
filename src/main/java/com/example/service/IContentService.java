package com.example.service;

import com.example.dto.ContentDTO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.List;

public interface IContentService {
    ContentDTO findAll();

    List<ContentDTO> findByChapterId(Long chapterId);
    List<ContentDTO> uploadFilesAndInsertOrUpdate(MultipartFile[] files, Long id, Long chapterId);
    void delete(long[] ids);

}
