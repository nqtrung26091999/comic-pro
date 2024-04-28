package com.example.api;

import com.example.dto.ComicDTO;
import com.example.service.IComicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@RestController("comicAPI")
public class ComicAPI {
    @Autowired
    private IComicService service;

    @PostMapping(value = "/api/comic")
    public ComicDTO insertComic(@RequestBody ComicDTO comicDTO) {
        return service.insert(comicDTO);
    }

    @PostMapping(value = "/api/upload-cover")
    public ResponseEntity<String> uploadImageCover(MultipartHttpServletRequest request) throws Exception {
        MultipartFile file = request.getFile("imageCover");
        Long id = Long.valueOf(request.getParameter("comicId"));
        return service.uploadImageCover(file, id);
    }

    @PutMapping(value = "/api/comic")
    public ComicDTO updateComic(@RequestBody ComicDTO comicDTO) {
        return service.update(comicDTO);
    }

    @DeleteMapping(value = "/api/comic")
    public void deleteComic(@RequestBody ComicDTO comicDTO) {
        service.deleteComic(comicDTO);
    }

    @PostMapping(value = "/api/comic-search")
    public ComicDTO searchComic(@RequestBody ComicDTO comicDTO) {
        ComicDTO dto = new ComicDTO();
        String text = comicDTO.getSearch();
        return service.searchComic(text);
    }
}
