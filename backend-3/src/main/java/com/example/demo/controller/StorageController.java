package com.example.demo.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Optional;
import java.util.zip.DataFormatException;
import java.util.zip.Deflater;
import java.util.zip.Inflater;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity.BodyBuilder;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.Image;
import com.example.demo.model.Service;
import com.example.demo.repository.ServiceRepository;
import com.example.demo.repository.StorageRepository;
@CrossOrigin(origins = "http://localhost:4200")

@RestController
@RequestMapping("/image")

public class StorageController {

    @Autowired
    private StorageRepository repository;
    @Autowired
    private ServiceRepository serviceRepository ;
    
	// compress the image bytes before storing it in the database
	public static byte[] compressBytes(byte[] data) {
		Deflater deflater = new Deflater();
		deflater.setInput(data);
		deflater.finish();

		ByteArrayOutputStream outputStream = new ByteArrayOutputStream(data.length);
		byte[] buffer = new byte[1024];
		while (!deflater.finished()) {
			int count = deflater.deflate(buffer);
			outputStream.write(buffer, 0, count);
		}
		try {
			outputStream.close();
		} catch (IOException e) {
		}
		System.out.println("Compressed Image Byte Size - " + outputStream.toByteArray().length);

		return outputStream.toByteArray();
	}
	//Post
    
	@PostMapping("/upload")
	public ResponseEntity<?> uploadImage(@RequestParam("imageFile") MultipartFile file, @RequestParam("service_id") Long serviceId) throws IOException {
	
Service s=this.serviceRepository.getById(serviceId);
	    System.out.println("Original Image Byte Size - " + file.getBytes().length);
	    Image img = new Image(file.getOriginalFilename(), file.getContentType(), compressBytes(file.getBytes()));
	    img.setService(s) ; // Set the Service for the Image
	    repository.save(img);

	    return ResponseEntity.status(HttpStatus.OK).build();
	}


  
    
    // uncompress the image bytes before returning it to the angular application
 	public static byte[] decompressBytes(byte[] data) {
 		Inflater inflater = new Inflater();
 		inflater.setInput(data);
 		ByteArrayOutputStream outputStream = new ByteArrayOutputStream(data.length);
 		byte[] buffer = new byte[1024];
 		try {
 			while (!inflater.finished()) {
 				int count = inflater.inflate(buffer);
 				outputStream.write(buffer, 0, count);
 			}
 			outputStream.close();
 		} catch (IOException ioe) {
 		} catch (DataFormatException e) {
 		}
 		return outputStream.toByteArray();
 	}
    
    
    
    
 	@GetMapping(path = { "/get/{imageName}" })
	public Image getImage(@PathVariable("imageName") String imageName) throws IOException {

		final Optional<Image> retrievedImage = repository.findByName(imageName);
		Image img = new Image(retrievedImage.get().getName(), retrievedImage.get().getType(),
				decompressBytes(retrievedImage.get().getImageData()));
		return img;
	}
}



/*
public String uploadImage(@RequestBody MultipartFile file) {
    try {
        Image imageData = Image.builder()
                .name(file.getOriginalFilename())
                .type(file.getContentType())
                .imageData(ImageUtils.compressImage(file.getBytes()))
                .build();

        repository.save(imageData);

        return "File uploaded successfully: " + file.getOriginalFilename();
    } catch (IOException e) {
        return "Failed to upload file: " + e.getMessage();
    }
}
*/




















