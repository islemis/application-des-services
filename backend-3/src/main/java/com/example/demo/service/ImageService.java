package com.example.demo.service;

import com.example.demo.model.ImageData;
import com.example.demo.repository.ImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Optional;


@Service
public class ImageService {

    @Autowired
    private ImageRepository imageRepository ;
    
    private final String FOLDER_PATH="C:/isetrades/semestre5/projet_dintegration/servicesProject/backend-3/images/";

    public String uploadImageToFileSystem(MultipartFile file,com.example.demo.model.Service service) throws IOException {
    	String filePath = FOLDER_PATH  + file.getOriginalFilename();

       ImageData fileData= imageRepository.save(ImageData.builder()
               .name(file.getOriginalFilename())
               .type(file.getContentType())
               .imagePath(filePath)
               .service(service)
               .build());          

        file.transferTo(new File(filePath));

        if (fileData != null) {
            return "file uploaded successfully : " + filePath;
        }
        return null;
    }

    public byte[] downloadImageFromFileSystem(String fileName) throws IOException {
        Optional<ImageData> fileData =  imageRepository.findByName(fileName);     
        String filePath=fileData.get().getImagePath();
        
        
        
        byte[] images = Files.readAllBytes(new File(filePath).toPath());
        return images;
    }
      
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
/*
    public List<Image> uploadImage(MultipartFile[] files, com.example.demo.model.Service service, MyUser user) throws IOException {
        List<Image> imageList = new ArrayList<>();

        for (MultipartFile file : files) {
            String filePath = Paths.get(uploadDir, file.getOriginalFilename()).toString();

            // Perform file storage logic
            Files.copy(file.getInputStream(), Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);

            // Save image data to the database
            Image savedImage = imageDataRepository.save(Image.builder()
                    .name(file.getOriginalFilename())
                    .type(file.getContentType())
                    .imageData(ImageUtil.compressImage(file.getBytes()))
                    .service(service)
                    .user(user)
                    .build());

            imageList.add(savedImage);
        }

        // Cleanup: Delete the temporary files
        for (MultipartFile file : files) {
            try {
                Files.delete(Paths.get(uploadDir, file.getOriginalFilename()));
            } catch (IOException e) {
                // Handle deletion failure
                System.err.println("Failed to delete the temporary file: " + file.getOriginalFilename());
                e.printStackTrace();
            }
        }

        return imageList;
    }

    */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  

}
