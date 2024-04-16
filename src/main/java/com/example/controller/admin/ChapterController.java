package com.example.controller.admin;

import com.example.constant.SystemConstant;
import com.example.dto.ChapterDTO;
import com.example.service.IChapterService;
import com.example.service.IComicService;
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

@Controller(value = "chapterAdmin")
public class ChapterController {
    @Autowired
    private IChapterService chapterService;

    @Autowired
    private IComicService comicService;

    @RequestMapping(value = "/admin/chapter", method = RequestMethod.GET)
    public ModelAndView showList(@RequestParam(value = "msg", required = false) String msg,
                                 @RequestParam(value = "search", required = false) String search,
                                 @RequestParam("page") int page,
                                 @RequestParam("limit") int limit,
                                 @RequestParam(value = "comicId", required = false) Long comicId) throws GeneralSecurityException, IOException {
        ChapterDTO chapterDTO = new ChapterDTO();
        String comicName = comicService.getNameComicById(comicId);
        Pageable pageable = new PageRequest(page - 1, limit);
        chapterDTO.setPage(page);
        chapterDTO.setLimit(limit);
        chapterDTO.setTotalItem(chapterService.getTotalItem(search));
        chapterDTO.setTotalPage((int) Math.ceil((double) chapterDTO.getTotalItem() / chapterDTO.getLimit()));
        if (search == null) {
            chapterDTO.setListResult(chapterService.findByComicId(comicId, pageable));
            chapterDTO.setSearch("");
        } else {
            chapterDTO.setListResult(chapterService.searchComic(search, pageable));
            chapterDTO.setSearch(search);
        }
        ModelAndView mav = new ModelAndView("/admin/chapter/list");
        if (msg != null) {
            switch (msg) {
                case SystemConstant.INSERT_SUCCESS:
                    chapterDTO.setMsg("Đăng ký thành công !");
                    chapterDTO.setAlert("success");
                    break;
                case SystemConstant.INSERT_FAILED:
                    chapterDTO.setMsg("Đăng ký thất bại !");
                    chapterDTO.setAlert("danger");
                    break;
                case SystemConstant.DELETE_SUCCESS:
                    chapterDTO.setMsg("Xóa thể loại thành công !");
                    chapterDTO.setAlert("success");
                    break;
            }
        }
        mav.addObject("comicId", comicId);
        mav.addObject("comicName", comicName);
        mav.addObject("model", chapterDTO);
        return mav;
    }

    @RequestMapping(value = "/admin/chapter/edit", method = RequestMethod.GET)
    public ModelAndView editChapter(@RequestParam(value = "id", required = false) Long id
            , @RequestParam(value = "comicId", required = false) Long comicId) {
        ChapterDTO chapterDTO = new ChapterDTO();
        String comicName = comicService.getNameComicById(comicId);;
        if (id != null) {
            chapterDTO = chapterService.findOne(id);
        }
        ModelAndView mav = new ModelAndView("/admin/chapter/edit");
        mav.addObject("comicId", comicId);
        mav.addObject("comicName", comicName);
        mav.addObject("model", chapterDTO);
        return mav;
    }
}
