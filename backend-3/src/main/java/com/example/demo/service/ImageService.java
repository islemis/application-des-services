package com.example.demo.service;

import com.example.demo.model.Image;
import com.example.demo.model.MyUser;
import com.example.demo.repository.StorageRepository;
import com.example.demo.util.ImageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Service
public class ImageService {

    @Autowired
    private StorageRepository imageDataRepository;
    
    
    
    public List<Image>  uploadImage(MultipartFile[] files,com.example.demo.model.Service service,MyUser user) throws IOException {
    	 String message="\"Images uploaded successfully: \"";
    	 List<Image> imageList = new ArrayList<>();
    	
    	   for (MultipartFile file : files) {
    		   Image savedImage =   imageDataRepository.save(Image.builder()
    	                .name(file.getOriginalFilename())
    	                .type(file.getContentType())
    	                .imageData(ImageUtil.compressImage(file.getBytes()))
    	          .service(service)
    	          .user(user)
                  .build());
    	        imageList.add(savedImage);

           }
    	  

        return imageList;
    }

    
    
    
    
    
    
    
    
    
    @Transactional
    public Image getInfoByImageByName(String name) {
        Optional<Image> dbImage = imageDataRepository.findByName(name);

        return Image.builder()
                .name(dbImage.get().getName())
                .type(dbImage.get().getType())
                .imageData(ImageUtil.decompressImage(dbImage.get().getImageData())).build();

    }

    @Transactional
    public byte[] getImage(String name) {
        Optional<Image> dbImage = imageDataRepository.findByName(name);
        byte[] image = ImageUtil.decompressImage(dbImage.get().getImageData());
        return image;
    }


}
