package com.example.controller.admin;

import com.example.constant.SystemConstant;
import com.example.dto.CategoryDTO;
import com.example.dto.ComicDTO;
import com.example.service.IChapterService;
import com.example.service.IComicService;
import com.example.util.MessageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.security.GeneralSecurityException;

@Controller(value = "comicAdmin")
public class ComicController {
    @Autowired
    private IComicService comicService;

    @RequestMapping(value = "/admin/comic", method = RequestMethod.GET)
    public ModelAndView showList(@RequestParam(value = "msg", required = false) String msg,
                                 @RequestParam(value = "search", required = false) String search,
                                 @RequestParam("page") int page,
                                 @RequestParam("limit") int limit) {
        ComicDTO comicDTO = new ComicDTO();
        Pageable pageable = new PageRequest(page - 1, limit);
        comicDTO.setPage(page);
        comicDTO.setLimit(limit);
        comicDTO.setTotalItem(comicService.getTotalItem(search));
        comicDTO.setTotalPage((int) Math.ceil((double) comicDTO.getTotalItem() / comicDTO.getLimit()));
        if (search == null || search.isEmpty()) {
            comicDTO.setListResult(comicService.findAll(pageable));
            comicDTO.setSearch("");
        } else {
            comicDTO.setListResult(comicService.searchComic(search, pageable));
            comicDTO.setSearch(search);
        }
        ModelAndView mav = new ModelAndView("/admin/comic/list");
        if (msg != null) {
            mav.addObject("msg", MessageUtils.handleMessage(msg));
        }
        mav.addObject("model", comicDTO);
        return mav;
    }

    @RequestMapping(value = "/admin/comic/edit", method = RequestMethod.GET)
    public ModelAndView editComic(@RequestParam(value = "id", required = false) Long id) throws GeneralSecurityException, IOException {
        ComicDTO comicDTO = new ComicDTO();
        if(id != null) {
            comicDTO = comicService.findOne(id);
        }
        ModelAndView mav = new ModelAndView("/admin/comic/edit");
        mav.addObject("model", comicDTO);
        return mav;
    }
}
