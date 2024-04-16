package com.example.controller.admin;

import com.example.constant.SystemConstant;
import com.example.dto.RoleDTO;
import com.example.dto.UserDTO;
import com.example.service.IUserService;
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
import java.util.List;

@Controller(value = "userAdmin")
public class UserController {
    @Autowired
    private IUserService userService;

    @RequestMapping(value = "/admin/user", method = RequestMethod.GET)
    public ModelAndView showListUser(@RequestParam(value = "msg", required = false) String msg,
                                     @RequestParam(value = "search", required = false) String search,
                                     @RequestParam("page") int page,
                                     @RequestParam("limit") int limit) {
        UserDTO userDTO = new UserDTO();
        Pageable pageable = new PageRequest(page - 1, limit);
        userDTO.setPage(page);
        userDTO.setLimit(limit);
        userDTO.setTotalItem(userService.getTotalItem(search));
        userDTO.setTotalPage((int) Math.ceil((double) userDTO.getTotalItem() / userDTO.getLimit()));
        if (search == null) {
            userDTO.setListResult(userService.findAll(pageable));
            userDTO.setSearch("");
        } else {
            userDTO.setListResult(userService.searchUser(search, pageable));
            userDTO.setSearch(search);
        }
        ModelAndView mav = new ModelAndView("/admin/user/list");
        if (msg != null) {
            switch (msg) {
                case SystemConstant.INSERT_SUCCESS:
                    userDTO.setMsg("Đăng ký thành công !");
                    userDTO.setAlert("success");
                    break;
                case SystemConstant.INSERT_FAILED:
                    userDTO.setMsg("Đăng ký thất bại !");
                    userDTO.setAlert("danger");
                    break;
                case SystemConstant.DELETE_SUCCESS:
                    userDTO.setMsg("Xóa người dùng thành công !");
                    userDTO.setAlert("success");
                    break;
            }
        }
        mav.addObject("model", userDTO);
        return mav;
    }

    @RequestMapping(value = "/admin/user/edit", method = RequestMethod.GET)
    public ModelAndView editUser(@RequestParam(value = "id", required = false) Long id) {
        UserDTO model = new UserDTO();
        List<RoleDTO> roles = userService.findAllRoles();
        if (id != null) {
            model = userService.findOneById(id);
        }
        ModelAndView mav = new ModelAndView("admin/user/edit");
        mav.addObject("roles", roles);
        mav.addObject("model", model);
        return mav;
    }
}