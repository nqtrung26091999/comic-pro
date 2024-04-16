package com.example.service.impl;

import com.example.constant.AWSConstant;
import com.example.converter.ChapterConverter;
import com.example.converter.ContentConverter;
import com.example.dto.ContentDTO;
import com.example.entity.ChapterEntity;
import com.example.entity.ComicEntity;
import com.example.entity.ContentEntity;
import com.example.repository.ChapterRepository;
import com.example.repository.ContentRepository;
import com.example.service.IContentService;
import com.example.service.awss3.AWSClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Service
public class ContentService implements IContentService {
    @Autowired
    private ContentRepository contentRepository;
    @Autowired
    private ContentConverter contentConverter;
    @Autowired
    private ChapterRepository chapterRepository;
    @Autowired
    private ChapterConverter chapterConverter;
    @Autowired
    private AWSClient awsClient;

    @Override
    public ContentDTO findAll() {
        List<ContentDTO> dtoList = new ArrayList<>();
        ContentDTO result = new ContentDTO();
        List<ContentEntity> entityList = contentRepository.findAll();
        for (ContentEntity entity : entityList) {
            ContentDTO dto = contentConverter.toDTO(entity);
            dtoList.add(dto);
        }
        result.setListResult(dtoList);
        return result;
    }

    @Override
    public List<ContentDTO> findByChapterId(Long chapterId) {
        List<ContentEntity> contentEntityList = contentRepository.findByChapterId(chapterId);
        List<ContentDTO> result = new ArrayList<>();
        for (ContentEntity entity : contentEntityList) {
            ContentDTO dto = contentConverter.toDTO(entity);
            result.add(dto);
        }
        return result;
    }

    @Override
    public List<ContentDTO> uploadFilesAndInsertOrUpdate(MultipartFile[] files, Long id, Long chapterId) {
        ChapterEntity chapterEntity = chapterRepository.findOne(chapterId);
        List<ContentDTO> result = new ArrayList<>();
        if (id != null) {
            ContentEntity contentEntity = contentRepository.findOne(id);
        }
        if (chapterEntity != null) {
            String path = AWSConstant.PATH_COMIC_S3 + chapterEntity.getComic().getId() + "/" + chapterEntity.getId() + "/";
            for (MultipartFile file : files) {
                String url = awsClient.uploadFile(file, path);
                ContentEntity entity = new ContentEntity();
                entity.setName(url);
                entity.setChapter(chapterEntity);
                ContentDTO contentDTO = contentConverter.toDTO(contentRepository.save(entity));
                result.add(contentDTO);
            }
        }
        return result;
    }

    @Override
    public ResponseEntity<String> delete(long[] ids) {
        if (ids != null) {
            for (long id : ids) {
                contentRepository.delete(id);
            }
        }
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
