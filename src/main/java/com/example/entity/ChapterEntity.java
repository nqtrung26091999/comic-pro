package com.example.entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "chapter")
public class ChapterEntity extends BaseEntity {
    @Column(name = "name")
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "comicid")
    private ComicEntity comic;

    @OneToMany(mappedBy = "chapter")
    private List<ContentEntity> contents;

    public List<ContentEntity> getContents() {
        return contents;
    }

    public void setContents(List<ContentEntity> contents) {
        this.contents = contents;
    }

    public ComicEntity getComic() {
        return comic;
    }

    public void setComic(ComicEntity comic) {
        this.comic = comic;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
