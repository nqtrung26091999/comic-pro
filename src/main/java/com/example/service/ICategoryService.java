package com.example.service;

import com.example.dto.CategoryDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ICategoryService {
    int getTotalItem(String search);
    List<CategoryDTO> findAll(Pageable pageable);
    List<CategoryDTO> findAll();
    CategoryDTO findOneById(Long id);
    List<CategoryDTO> searchCategory(String search, Pageable pageable);
    CategoryDTO searchCategory(String search);
    CategoryDTO save(CategoryDTO categoryDTO);
    void remove(CategoryDTO categoryDTO);
    CategoryDTO findByArrayIds(CategoryDTO categoryDTO);
}
