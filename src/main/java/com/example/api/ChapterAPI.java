package com.example.api;

import com.example.dto.ChapterDTO;
import com.example.service.IChapterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController("chapterAPI")
public class ChapterAPI {

    @Autowired
    private IChapterService chapterService;

    @PostMapping(value = "/api/chapter")
    public ChapterDTO insertChapter(@RequestBody ChapterDTO chapterDTO) throws Exception {
        return chapterService.save(chapterDTO);
    }

    @PutMapping(value = "/api/chapter")
    public ChapterDTO updateChapter(@RequestBody ChapterDTO chapterDTO) throws Exception {
        return chapterService.save(chapterDTO);
    }

    @DeleteMapping(value = "/api/chapter")
    public void deleteCategory(@RequestBody ChapterDTO chapterDTO) {
        chapterService.remove(chapterDTO);
    }

    @PostMapping(value = "/api/chapter/search")
    public ChapterDTO searchList(@RequestBody ChapterDTO chapterDTO) {
        return chapterService.searchCategory(chapterDTO.getSearch());
    }
}
