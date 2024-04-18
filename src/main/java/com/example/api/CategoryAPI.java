package com.example.api;

import com.example.dto.CategoryDTO;
import com.example.service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("categoryAPI")
public class CategoryAPI {

    @Autowired
    private ICategoryService categoryService;

    @PostMapping(value = "/api/category")
    public CategoryDTO insertCategory(@RequestBody CategoryDTO categoryDTO) {
        return categoryService.save(categoryDTO);
    }

    @PutMapping(value = "/api/category")
    public CategoryDTO updateCategory(@RequestBody CategoryDTO categoryDTO) {
        return categoryService.save(categoryDTO);
    }

    @DeleteMapping(value = "/api/category")
    public void deleteCategory(@RequestBody CategoryDTO categoryDTO) {
        categoryService.remove(categoryDTO);
    }

    @PostMapping(value = "/api/category/search")
    public CategoryDTO searchList(@RequestBody CategoryDTO categoryDTO) {
        return categoryService.searchCategory(categoryDTO.getSearch());
    }

    @PostMapping(value = "/api/category/find")
    public CategoryDTO findByIds(@RequestBody CategoryDTO categoryDTO) {
        return categoryService.findByArrayIds(categoryDTO);
    }
}
