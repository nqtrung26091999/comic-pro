package com.example.api;

import com.example.dto.ContentDTO;
import com.example.service.IContentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@RestController("contentAPI")
public class ContentAPI {
    @Autowired
    private IContentService contentService;

    @PostMapping(value = "/api/content")
    public Object uploadImages(MultipartHttpServletRequest request,
                               @RequestParam(value = "id", required = false) Long id,
                               @RequestParam("chapterId") Long chapterId) throws Exception {
        MultipartFile[] files = request.getFiles("arrayImages").toArray(new MultipartFile[0]);
        return contentService.uploadFilesAndInsertOrUpdate(files, id, chapterId);
    }
    @DeleteMapping(value = "/api/content")
    public void delete(@RequestBody ContentDTO dto) {
        contentService.delete(dto.getIds());
    }
}
