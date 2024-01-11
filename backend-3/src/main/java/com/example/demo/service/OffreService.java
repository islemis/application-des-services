package com.example.demo.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dto.OffreDto;

public interface OffreService {
    List<OffreDto> getAllUserOffres(String authorizationHeader);
    List<OffreDto> getAllOffres();
    OffreDto getOffreById(Long id);
     void saveOffre(String offreJson, MultipartFile[] images, String authorizationHeader);
   void deleteOffre(Long id);
   void updateOffre(Long id, String offreJson, MultipartFile[] files);
    List<OffreDto> getOffresByCategory(String nom);
}