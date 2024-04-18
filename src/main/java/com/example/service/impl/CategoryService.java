package com.example.service.impl;

import com.example.converter.CategoryConverter;
import com.example.dto.CategoryDTO;
import com.example.dto.UserDTO;
import com.example.entity.CategoryEntity;
import com.example.repository.CategoryRepository;
import com.example.service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CategoryService implements ICategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private CategoryConverter categoryConverter;

    @Override
    public int getTotalItem(String search) {
        int count = 0;
        if (search != null && !search.isEmpty()) {

        } else {
            count = (int) categoryRepository.count();
        }
        return count;
    }

    @Override
    public List<CategoryDTO> findAll(Pageable pageable) {
        List<CategoryDTO> result = new ArrayList<>();
        List<CategoryEntity> entityList = categoryRepository.findAll(pageable).getContent();
        for (CategoryEntity entity : entityList) {
            CategoryDTO dto = categoryConverter.toDTO(entity);
            result.add(dto);
        }
        return result;
    }

    @Override
    public CategoryDTO findOneById(Long id) {
        CategoryEntity entity = categoryRepository.findOne(id);
        if (entity != null) {
            return categoryConverter.toDTO(entity);
        }
        return null;
    }

    @Override
    public List<CategoryDTO> searchCategory(String search, Pageable pageable) {
        return null;
    }

    @Override
    public CategoryDTO searchCategory(String search) {
        CategoryDTO result = new CategoryDTO();
        List<CategoryDTO> categoryDTOList = new ArrayList<>();
        List<CategoryEntity> listSearch = categoryRepository.findByNameStartingWith(search);
        for (CategoryEntity entity : listSearch) {
            CategoryDTO dto = categoryConverter.toDTO(entity);
            categoryDTOList.add(dto);
        }
        result.setListResult(categoryDTOList);
        return result;
    }

    @Override
    public CategoryDTO save(CategoryDTO categoryDTO) {
        CategoryEntity categoryEntity;
        Long id = categoryDTO.getId();
        if (id != null) {
            CategoryEntity oldEntity = categoryRepository.findOne(id);
            categoryEntity = categoryConverter.toEntity(oldEntity, categoryDTO);
        } else {
            categoryEntity = categoryConverter.toEntity(categoryDTO);
        }

        return categoryConverter.toDTO(categoryRepository.save(categoryEntity));
    }

    @Override
    public void remove(CategoryDTO categoryDTO) {
        long[] ids = categoryDTO.getIds();
        if (ids != null) {
            for (long id : ids) {
                categoryRepository.delete(id);
            }
        }
    }

    @Override
    public CategoryDTO findByArrayIds(CategoryDTO categoryDTO) {
        CategoryDTO result = new CategoryDTO();
        List<CategoryDTO> categoryDTOList = new ArrayList<>();
        if (categoryDTO.getIds() != null) {
            for (long id : categoryDTO.getIds()) {
                CategoryDTO dto = categoryConverter.toDTO(categoryRepository.findOne(id));
                categoryDTOList.add(dto);
            }
            result.setListResult(categoryDTOList);
        }
        return result;
    }
}
