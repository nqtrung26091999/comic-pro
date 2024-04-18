package com.example.controller.admin;

import com.example.constant.SystemConstant;
import com.example.dto.CategoryDTO;
import com.example.dto.RoleDTO;
import com.example.dto.UserDTO;
import com.example.service.ICategoryService;
import com.example.util.MessageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller(value = "categoryAdmin")
public class CategoryController {
    @Autowired
    private ICategoryService categoryService;

    @RequestMapping(value = "/admin/category", method = RequestMethod.GET)
    public ModelAndView showListCategory(@RequestParam(value = "msg", required = false) String msg,
                                     @RequestParam(value = "search", required = false) String search,
                                     @RequestParam("page") int page,
                                     @RequestParam("limit") int limit) {
        CategoryDTO categoryDTO = new CategoryDTO();
        Pageable pageable = new PageRequest(page - 1, limit);
        categoryDTO.setPage(page);
        categoryDTO.setLimit(limit);
        categoryDTO.setTotalItem(categoryService.getTotalItem(search));
        categoryDTO.setTotalPage((int) Math.ceil((double) categoryDTO.getTotalItem() / categoryDTO.getLimit()));
        if (search == null || search.isEmpty()) {
            categoryDTO.setListResult(categoryService.findAll(pageable));
            categoryDTO.setSearch("");
        } else {
            categoryDTO.setListResult(categoryService.searchCategory(search, pageable));
            categoryDTO.setSearch(search);
        }
        ModelAndView mav = new ModelAndView("/admin/category/list");
        if (msg != null) {
            mav.addObject("msg", MessageUtils.handleMessage(msg));
        }
        mav.addObject("model", categoryDTO);
        return mav;
    }

    @RequestMapping(value = "/admin/category/edit")
    public ModelAndView editCategory(@RequestParam(value = "id", required = false) Long id) {
        CategoryDTO model = new CategoryDTO();
        if (id != null) {
            model = categoryService.findOneById(id);
        }
        ModelAndView mav = new ModelAndView("admin/category/edit");
        mav.addObject("model", model);
        return mav;
    }
}
