package com.example.dto;

import java.util.ArrayList;
import java.util.List;

public class ComicDTO extends AbstractDTO<ComicDTO> {
    private String name;
    private String code;
    private String description;
    private String cover;
    private String author;

    private int totalChapters = 0;

    public int getTotalChapters() {
        return totalChapters;
    }

    public void setTotalChapters(int totalChapters) {
        this.totalChapters = totalChapters;
    }

    private List<CategoryDTO> listCategory;

    public List<CategoryDTO> getListCategory() {
        return listCategory;
    }

    public void setListCategory(List<CategoryDTO> listCategory) {
        this.listCategory = listCategory;
    }

    private long[] arrayCategoryId;

    public long[] getArrayCategoryId() {
        return arrayCategoryId;
    }

    public void setArrayCategoryId(long[] arrayCategoryId) {
        this.arrayCategoryId = arrayCategoryId;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }
}
