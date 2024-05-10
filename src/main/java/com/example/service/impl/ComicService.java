package com.example.service.impl;

import com.amazonaws.services.s3.model.S3Object;
import com.example.constant.AWSConstant;
import com.example.constant.SystemConstant;
import com.example.converter.CategoryConverter;
import com.example.converter.ComicConverter;
import com.example.dto.CategoryDTO;
import com.example.dto.ComicDTO;
import com.example.entity.CategoryEntity;
import com.example.entity.ComicEntity;
import com.example.entity.ContentEntity;
import com.example.entity.UserEntity;
import com.example.repository.CategoryRepository;
import com.example.repository.ChapterRepository;
import com.example.repository.ComicRepository;
import com.example.repository.UserRepository;
import com.example.service.IComicService;
import com.example.service.awss3.AWSClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

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
    private UserRepository userRepository;
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
        if (search != null && !search.isEmpty()) {

        } else {
            count = (int) comicRepository.count();
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
    public List<ComicDTO> findAll() {
        List<ComicEntity> entityList = comicRepository.findAll();
        List<ComicDTO> result = new ArrayList<>();
        if (!entityList.isEmpty()) {
            for (ComicEntity entity : entityList) {
                ComicDTO dto = comicConverter.toDTO(entity);
                result.add(dto);
            }
        }
        return result;
    }

    @Override
    public List<ComicDTO> searchComic(String search, Pageable pageable) {
        return null;
    }

//    @Override
//    public ComicDTO searchComic(String search) {
//        List<ComicEntity> entityList = comicRepository.findByNameStartingWith(search);
//        List<ComicDTO> dtoList = new ArrayList<>();
//        for (ComicEntity entity : entityList) {
//            ComicDTO dto = comicConverter.toDTO(entity);
//            dtoList.add(dto);
//        }
//        ComicDTO result = new ComicDTO();
//        result.setListResult(dtoList);
//        return result;
//    }

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

    @Override
    public ComicDTO findOneNewest() {
        ComicEntity entity = comicRepository.findComicEntityByMaxCreatedDate();
        return comicConverter.toDTO(entity);
    }

    @Override
    public void deleteComic(ComicDTO comicDTO) {
        long[] ids = comicDTO.getIds();
        if (ids != null) {
            for (long id : ids) {
                ComicEntity entity = comicRepository.findOne(id);
                String name = entity.getCover();
                String path = name.substring(name.lastIndexOf(SystemConstant.DIR_PROJECT_NAME_S3));
                S3Object object = awsClient.getObjectFromS3(AWSConstant.BUCKET_NAME, path);
                if (object != null) {
                    awsClient.deleteFileFromS3(AWSConstant.BUCKET_NAME, path);
                }
                comicRepository.delete(id);
            }
        }
    }

    @Override
    public List<ComicDTO> findByCategoryId(Long categoryId) {
        List<ComicEntity> entityList = comicRepository.findAll();
        List<ComicDTO> dtoList = new ArrayList<>();
        for (ComicEntity entity : entityList) {
            for (int i = 0; i < entity.getCategories().size(); i++) {
                if (Objects.equals(entity.getCategories().get(i).getId(), categoryId)) {
                    ComicDTO dto = comicConverter.toDTO(entity);
                    dtoList.add(dto);
                }
            }
        }
        return dtoList;
    }

    @Override
    public void updateHistory(String username, Long comicId) {
        List<ComicEntity> comics = new ArrayList<>();
        UserEntity userEntity = userRepository.findOneByUserName(username);
        ComicEntity comicEntity = comicRepository.findOne(comicId);
        if (userEntity != null && comicEntity != null) {
            comics.add(comicEntity);
            userEntity.setComics(comics);
            userRepository.save(userEntity);
        }
    }
}
