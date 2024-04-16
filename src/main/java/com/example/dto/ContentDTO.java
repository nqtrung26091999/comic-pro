package com.example.dto;

public class ContentDTO extends AbstractDTO<ContentDTO> {
    private String name;
    private Long chapterId;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getChapterId() {
        return chapterId;
    }

    public void setChapterId(Long chapterId) {
        this.chapterId = chapterId;
    }
}
