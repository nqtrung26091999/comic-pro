package com.example.service.impl;

import com.example.converter.ChapterConverter;
import com.example.dto.ChapterDTO;
import com.example.entity.ChapterEntity;
import com.example.entity.ComicEntity;
import com.example.repository.ChapterRepository;
import com.example.repository.ComicRepository;
import com.example.service.IChapterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class ChapterService implements IChapterService {

    @Autowired
    private ChapterRepository chapterRepository;
    @Autowired
    private ComicRepository comicRepository;
    @Autowired
    private ChapterConverter chapterConverter;

    @Override
    public int totalChapter(Long comicId) {
        return 0;
    }

    @Override
    public int getTotalItem(String search) {
        return 0;
    }

    @Override
    public List<ChapterDTO> findByComicId(Long id, Pageable pageable) {
        List<ChapterDTO> result = new ArrayList<>();
        List<ChapterEntity> chapterEntityList = chapterRepository.findByComicId(id, pageable);
        for (ChapterEntity entity : chapterEntityList) {
            ChapterDTO dto = chapterConverter.toDTO(entity);
            result.add(dto);
        }
        return result;
    }

    @Override
    public List<ChapterDTO> searchComic(String search, Pageable pageable) {
        return null;
    }

    @Override
    public ChapterDTO findOne(Long id) {
        return chapterConverter.toDTO(chapterRepository.findOne(id));
    }

    @Override
    @Transactional
    public ChapterDTO save(ChapterDTO dto) throws Exception {
        ComicEntity comicEntity = comicRepository.findOne(dto.getComicId());
        return null;
    }

    @Override
    public void remove(ChapterDTO dto) {
        if (dto.getIds() != null) {
            for (Long id : dto.getIds()) {
                chapterRepository.delete(id);
            }
        }
    }

    @Override
    public ChapterDTO searchCategory(String search) {
        return null;
    }

    @Override
    public String getNameChapterById(Long chapterId) {
        return chapterRepository.findOne(chapterId).getName();
    }
}
