package com.example.controller.web;

import com.example.dto.ChapterDTO;
import com.example.dto.ComicDTO;
import com.example.dto.ContentDTO;
import com.example.service.IChapterService;
import com.example.service.IComicService;
import com.example.service.IContentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller("chapterWeb")
public class ChapterController {
    @Autowired
    private IContentService contentService;
    @Autowired
    private IComicService comicService;
    @Autowired
    private IChapterService chapterService;

    @RequestMapping(value = "/content")
    public ModelAndView showPage(@RequestParam("chapter") Long chapterId,
                                 @RequestParam("comic") Long comicId) {
        ComicDTO comicDTO = comicService.findOne(comicId);
        ChapterDTO chapterDTO =chapterService.findOne(chapterId);
        List<ContentDTO> listContent = contentService.findByChapterId(chapterId);
        ModelAndView mav = new ModelAndView("web/page-comic-content");
        mav.addObject("chapter", chapterDTO);
        mav.addObject("contents", listContent);
        mav.addObject("comic", comicDTO);
        return mav;
    }
}
