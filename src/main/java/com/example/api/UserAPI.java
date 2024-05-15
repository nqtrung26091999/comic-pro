package com.example.api;

import com.amazonaws.services.s3.model.Bucket;
import com.example.constant.AWSConstant;
import com.example.dto.History;
import com.example.dto.UserDTO;
import com.example.service.IUserService;
import com.example.service.awss3.AWSClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@RestController("userAPI")
public class UserAPI {

    @Autowired
    private IUserService userService;

    @Autowired
    private AWSClient awsClient;

    @PostMapping(value = "/api/user")
    public UserDTO registerUser(@RequestBody UserDTO userDTO) throws GeneralSecurityException, IOException {
        return userService.registerUser(userDTO);
    }

    @PostMapping(value = "/api/upload-avatar")
    public void uploadAvatar(MultipartHttpServletRequest request) throws Exception {
        MultipartFile file = request.getFile("avatar");
        Long id = Long.valueOf(request.getParameter("userId"));
        userService.uploadAvatar(file, id);
    }

    @PutMapping(value = "/api/user")
    public UserDTO updateUser(@RequestBody UserDTO userDTO) {
        return userService.updateUser(userDTO);
    }

    @PostMapping(value = "/api/history-comic")
    public List<History> getListHistoryComic(@RequestParam("username") String username) {
        return userService.getMapListHistory(username);
    }
}
