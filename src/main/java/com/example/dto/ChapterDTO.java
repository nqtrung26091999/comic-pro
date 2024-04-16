package com.example.dto;

public class ChapterDTO extends AbstractDTO<ChapterDTO> {
    private String name;

    private Long comicId;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getComicId() {
        return comicId;
    }

    public void setComicId(Long comicId) {
        this.comicId = comicId;
    }
}
