package com.example.demo.service;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.MyUser;
import com.example.demo.model.Offre;

public interface ImageService {

	 public String uploadImageToFileSystem(MultipartFile file, Offre offre, MyUser user,Boolean isProfile) throws IOException;
	 public byte[] downloadImageFromFileSystem(String fileName) throws IOException;
	 void deleteProfileImage(MyUser user);
    

}