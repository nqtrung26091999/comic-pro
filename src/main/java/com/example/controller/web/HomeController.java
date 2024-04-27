package com.example.controller.web;

import com.example.dto.CategoryDTO;
import com.example.dto.ComicDTO;
import com.example.dto.UserDTO;
import com.example.service.ICategoryService;
import com.example.service.IComicService;
import com.example.service.IUserService;
import com.example.util.MessageUtils;
import com.example.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.*;

@Controller("homeWeb")
public class HomeController {

    @Autowired
    private IUserService userService;
    @Autowired
    private IComicService comicService;
    @Autowired
    private ICategoryService categoryService;

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public ModelAndView homePage(@RequestParam(value = "search", required = false) String search,
                                 @RequestParam(value = "page", required = false) Integer page,
                                 @RequestParam(value = "limit", required = false) Integer limit,
                                 @RequestParam(value = "category", required = false) Long categoryId) {
        ModelAndView mav = new ModelAndView("web/home");
        ComicDTO comicDTO = new ComicDTO();
        List<CategoryDTO> categoryDTOList = categoryService.findAll();
        if (page != null && limit != null) {
            comicDTO = comicService.findOneNewest();
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
        } else {
            List<ComicDTO> listAll = new ArrayList<>();
            if (categoryId !=  null) {
                listAll = comicService.findByCategoryId(categoryId);
            } else {
                listAll = comicService.findAll();
            }
            List<ComicDTO> list = comicService.findAll();
            comicDTO = comicService.findOneNewest();
            ListIterator<ComicDTO> listIterator = list.listIterator();
            while (listIterator.hasNext()) {
                ComicDTO dto = listIterator.next();
                if (Objects.equals(comicDTO.getId(), dto.getId())) {
                    listIterator.remove();
                }
            }
            mav.addObject("comicNewest", comicDTO);
            mav.addObject("modelAll", listAll);
            mav.addObject("model", list);
        }
        mav.addObject("categories", categoryDTOList);
        return mav;
    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public ModelAndView profilePage() throws GeneralSecurityException, IOException {
        String username = SecurityUtils.getPrincipal().getUsername();
        UserDTO userDTO = userService.findOneByUsername(username);
        ModelAndView mav = new ModelAndView("web/profile");
        if (userDTO != null) {
            mav.addObject("model", userDTO);
        }
        return mav;
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null) {
            new SecurityContextLogoutHandler().logout(request, response, authentication);
        }
        return new ModelAndView("redirect:/home");
    }

    @RequestMapping(value = "/accessDenied", method = RequestMethod.GET)
    public ModelAndView accessDenied() {
        return new ModelAndView("redirect:/home");
    }
}
