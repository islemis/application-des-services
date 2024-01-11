package com.example.demo.controller;

import com.example.demo.dto.OffreDto;
import com.example.demo.service.OffreService;
import com.example.demo.serviceimpl.OffreServiceImp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/api/offres")
public class OffreController {

    @Autowired
    private OffreServiceImp offreService;

    @GetMapping("/all")
    public ResponseEntity<List<OffreDto>> getAllOffres() {
        List<OffreDto> offres = offreService.getAllOffres();
        return new ResponseEntity<>(offres, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OffreDto> getOffreById(@PathVariable Long id) {
        OffreDto offre = offreService.getOffreById(id);
        return new ResponseEntity<>(offre, HttpStatus.OK);
    }

    @PostMapping("/add")
    public ResponseEntity<String> saveOffre(@RequestParam("offre") String offreJson,
                                           @RequestParam("images") MultipartFile[] images,
                                           @RequestHeader("Authorization") String authorizationHeader) {
        offreService.saveOffre(offreJson, images, authorizationHeader);
        return new ResponseEntity<>("Offre added successfully", HttpStatus.CREATED);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteOffre(@PathVariable Long id) {
        offreService.deleteOffre(id);
        return new ResponseEntity<>("Offre deleted successfully", HttpStatus.OK);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<String> updateOffre(@PathVariable Long id,
    		@RequestParam("offre") String offreJson,
                                              @RequestParam("images") MultipartFile[] files) {
        offreService.updateOffre(id, offreJson, files);
        return new ResponseEntity<>("Offre updated successfully", HttpStatus.OK);
    }

    @GetMapping("/byCategory/{nom}")
    public ResponseEntity<List<OffreDto>> getOffresByCategory(@PathVariable String nom) {
        List<OffreDto> offres = offreService.getOffresByCategory(nom);
        return new ResponseEntity<>(offres, HttpStatus.OK);
    }
    @GetMapping("/byUser")
    public ResponseEntity<List<OffreDto>> getAllUserOffres(@RequestHeader("Authorization") String authorizationHeader) {
        List<OffreDto> offres = offreService.getAllUserOffres(authorizationHeader);
        return new ResponseEntity<>(offres, HttpStatus.OK);
    }
}
