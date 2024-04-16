package com.example.controller.admin;

import com.example.dto.ContentDTO;
import com.example.service.IChapterService;
import com.example.service.IComicService;
import com.example.service.IContentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.List;

@Controller(value = "contentAdmin")
public class ContentController {
    @Autowired
    private IComicService comicService;
    @Autowired
    private IChapterService chapterService;
    @Autowired
    private IContentService contentService;

    @RequestMapping(value = "/admin/content", method = RequestMethod.GET)
    private ModelAndView showPage(@RequestParam("comicId") Long comicId,
                                  @RequestParam("chapterId") Long chapterId) throws GeneralSecurityException, IOException {
        String comicName = comicService.getNameComicById(comicId);
        String chapterName = chapterService.getNameChapterById(chapterId);
        List<ContentDTO> model = contentService.findByChapterId(chapterId);
        ModelAndView mav = new ModelAndView("/admin/content/list");
        mav.addObject("comicId", comicId);
        mav.addObject("chapterId", chapterId);
        mav.addObject("comicName", comicName);
        mav.addObject("chapterName", chapterName);
        mav.addObject("model", model);
        return mav;
    }

    @RequestMapping(value = "/admin/content/edit", method = RequestMethod.GET)
    private ModelAndView edit(@RequestParam("comicId") Long comicId,
                              @RequestParam("chapterId") Long chapterId,
                              @RequestParam(value = "id", required = false) Long id) {
        String comicName = comicService.getNameComicById(comicId);
        String chapterName = chapterService.getNameChapterById(chapterId);
        ContentDTO model = new ContentDTO();
        ModelAndView mav = new ModelAndView("/admin/content/edit");
        mav.addObject("comicId", comicId);
        mav.addObject("chapterId", chapterId);
        mav.addObject("comicName", comicName);
        mav.addObject("chapterName", chapterName);
        mav.addObject("model", model);
        return mav;
    }
}
