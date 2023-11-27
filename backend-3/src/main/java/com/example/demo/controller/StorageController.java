package com.example.demo.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.Image;
import com.example.demo.model.MyUser;
import com.example.demo.model.Service;
import com.example.demo.service.ImageService;

import java.io.IOException;

@RestController
@RequestMapping("/image")

public class StorageController {

    @Autowired
    private ImageService imageDataService;

    @PostMapping("/upload")
    public ResponseEntity<String> uploadImage(@RequestParam("image") MultipartFile[] files,@RequestParam("service")  Service service,@RequestParam("user")  MyUser user)throws IOException {
        imageDataService.uploadImage(files,service,user);
       
        return ResponseEntity.status(HttpStatus.OK)
                .body("ok");
    }

    @GetMapping("/info/{name}")
    public ResponseEntity<?>  getImageInfoByName(@PathVariable("name") String name){
        Image image = imageDataService.getInfoByImageByName(name);

        return ResponseEntity.status(HttpStatus.OK)
                .body(image);
    }

    @GetMapping("/{name}")
    public ResponseEntity<?>  getImageByName(@PathVariable("name") String name){
        byte[] image = imageDataService.getImage(name);

        return ResponseEntity.status(HttpStatus.OK)
                .contentType(MediaType.valueOf("image/png"))
                .body(image);
    }




















}
