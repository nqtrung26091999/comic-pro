package com.example.service.impl;

import com.example.constant.AWSConstant;
import com.example.converter.CategoryConverter;
import com.example.converter.ComicConverter;
import com.example.dto.CategoryDTO;
import com.example.dto.ComicDTO;
import com.example.entity.CategoryEntity;
import com.example.entity.ComicEntity;
import com.example.repository.CategoryRepository;
import com.example.repository.ChapterRepository;
import com.example.repository.ComicRepository;
import com.example.service.IComicService;
import com.example.service.awss3.AWSClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Service
public class ComicService implements IComicService {
    @Autowired
    private ComicRepository comicRepository;
    @Autowired
    private ComicConverter comicConverter;
    @Autowired
    private CategoryConverter categoryConverter;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private ChapterRepository chapterRepository;
    @Autowired
    private AWSClient awsClient;

    @Override
    public ComicDTO insert(ComicDTO dto) {
        List<CategoryEntity> categories = new ArrayList<>();
        ComicEntity comicEntity;
        long[] arrayCategoryId = dto.getArrayCategoryId();
        if (arrayCategoryId != null) {
            for (long id : arrayCategoryId) {
                CategoryEntity entity = categoryRepository.findOne(id);
                categories.add(entity);
            }
        }
        comicEntity = comicConverter.toEntity(dto);
        comicEntity.setCategories(categories);
        return comicConverter.toDTO(comicRepository.save(comicEntity));
    }

    @Override
    public ResponseEntity<String> uploadImageCover(MultipartFile imageCover, Long id) {
        ComicEntity entity = comicRepository.findOne(id);
        if (entity != null) {
            String path = AWSConstant.PATH_COMIC_S3 +
                    entity.getId() +
                    AWSConstant.COVER_S3;
            String url = awsClient.uploadFile(imageCover, path);
            entity.setCover(url);
            comicRepository.save(entity);
            return new ResponseEntity<>(HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @Override
    public int getTotalItem(String search) {
        int count = 0;
        if (search != null) {

        } else {
            count = (int) categoryRepository.count();
        }
        return count;
    }

    @Override
    public String getNameComicById(Long id) {
        return comicRepository.findOne(id).getName();
    }

    @Override
    public List<ComicDTO> findAll(Pageable pageable) {
        List<ComicDTO> result = new ArrayList<>();
        List<ComicEntity> entityList = comicRepository.findAll(pageable).getContent();
        for (ComicEntity entity : entityList) {
            ComicDTO dto = comicConverter.toDTO(entity);
            dto.setTotalChapters(chapterRepository.countByComicId(entity.getId()));
            result.add(dto);
        }
        return result;
    }

    @Override
    public List<ComicDTO> searchComic(String search, Pageable pageable) {
        return null;
    }

    @Override
    public ComicDTO findOne(Long id) {
        ComicEntity entity = comicRepository.findOne(id);
        ComicDTO dto = comicConverter.toDTO(entity);
        List<CategoryDTO> listCategory = new ArrayList<>();
        if (entity.getCategories() != null) {
            for (CategoryEntity categoryEntity : entity.getCategories()) {
                CategoryDTO categoryDTO = categoryConverter.toDTO(categoryEntity);
                listCategory.add(categoryDTO);
            }
        }
        dto.setListCategory(listCategory);
        return dto;
    }

    @Override
    public ComicDTO update(ComicDTO comicDTO) {
        List<CategoryEntity> categories = new ArrayList<>();
        ComicEntity comicEntity;
        long[] arrayCategoryId = comicDTO.getArrayCategoryId();
        if (arrayCategoryId != null) {
            for (long id : arrayCategoryId) {
                CategoryEntity entity = categoryRepository.findOne(id);
                categories.add(entity);
            }
        }
        ComicEntity comicOld = comicRepository.findOne(comicDTO.getId());
        comicEntity = comicConverter.toEntity(comicOld, comicDTO);
        comicEntity.setCategories(categories);
        return comicConverter.toDTO(comicRepository.save(comicEntity));
    }
}
