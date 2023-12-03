package com.example.demo.controller;


import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.ImageData;
import com.example.demo.model.Service;
import com.example.demo.service.ImageService;


@RestController
@RequestMapping("/image")

public class StorageController {


    @Autowired
    private ImageService imageService ;

	@PostMapping("/fileSystem")
	public ResponseEntity<?> uploadImageToFIleSystem(@RequestParam("image")MultipartFile file,@RequestParam("Service") Service service) throws IOException {
		String uploadImage = imageService.uploadImageToFileSystem(file,service);
		return ResponseEntity.status(HttpStatus.OK)
				.body(uploadImage);
	}

	@GetMapping("/fileSystem/{fileName}")
	public ResponseEntity<?> downloadImageFromFileSystem(@PathVariable String fileName) throws IOException {
		byte[] imageData=imageService.downloadImageFromFileSystem(fileName);
		return ResponseEntity.status(HttpStatus.OK)
				.contentType(MediaType.valueOf("image/png"))
				.body(imageData);

	}

    

}
