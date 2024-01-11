package com.example.demo.controller;


import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.ImageData;
import com.example.demo.model.MyUser;
import com.example.demo.model.Offre;
import com.example.demo.service.ImageService;
import com.example.demo.serviceimpl.ImageServiceImp;


@RestController
@RequestMapping("/image")
//@CrossOrigin(origins = "http://localhost:53942") 

public class StorageController {


    @Autowired
    private ImageServiceImp imageService ;

	@PostMapping("/fileSystem")
	public ResponseEntity<?> uploadImageToFIleSystem(@RequestParam("image")MultipartFile file,@RequestParam("Offre") Offre offre,@RequestParam("user") MyUser user,@RequestParam("isProfil")Boolean b ) throws IOException {
		String uploadImage = imageService.uploadImageToFileSystem(file,offre,user,b);
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
