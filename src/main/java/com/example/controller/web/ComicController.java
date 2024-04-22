package com.example.controller.web;

import com.example.dto.CategoryDTO;
import com.example.dto.ChapterDTO;
import com.example.dto.ComicDTO;
import com.example.service.ICategoryService;
import com.example.service.IChapterService;
import com.example.service.IComicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller("comicWeb")
public class ComicController {
    @Autowired
    private IComicService comicService;
    @Autowired
    private ICategoryService categoryService;
    @Autowired
    private IChapterService chapterService;

    @RequestMapping(value = "/comic", method = RequestMethod.GET)
    public ModelAndView showPage(@RequestParam("id") Long id) {
        List<CategoryDTO> categories = categoryService.findAll();
        List<ChapterDTO> chapters = chapterService.findByComicId(id);
        ComicDTO model = comicService.findOne(id);
        ModelAndView mav = new ModelAndView("web/page-comic");
        mav.addObject("chapters", chapters);
        mav.addObject("model", model);
        mav.addObject("categories", categories);
        return mav;
    }
}
