package com.example.controller.web;

import com.example.dto.UserDTO;
import com.example.service.IUserService;
import com.example.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.GeneralSecurityException;

@Controller("homeWeb")
public class HomeController {

    @Autowired
    private IUserService userService;

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public ModelAndView homePage() {
        return new ModelAndView("web/home");
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
        if(authentication != null) {
            new SecurityContextLogoutHandler().logout(request, response, authentication);
        }
        return new ModelAndView("redirect:/home");
    }

    @RequestMapping(value = "/accessDenied", method = RequestMethod.GET)
    public ModelAndView accessDenied() {
        return new ModelAndView("redirect:/home");
    }
}
