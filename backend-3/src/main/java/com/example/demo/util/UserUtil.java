package com.example.demo.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.example.demo.dto.CategoryDto;
import com.example.demo.dto.ImageDto;
import com.example.demo.dto.MyUserDto;
import com.example.demo.model.Category;
import com.example.demo.model.ImageData;
import com.example.demo.model.MyUser;
import com.example.demo.service.ImageService;
@Component
public  class UserUtil {
	 private final ImageService imageService;
	    @Autowired
	    public UserUtil(ImageService imageService) {
	        this.imageService = imageService;
	    }
	
	public  MyUserDto convert(MyUser user) {
	    MyUserDto userDto = new MyUserDto();
	    userDto.setId(user.getId());
	    userDto.setFirstName(user.getFirstName());
	    userDto.setLastName(user.getLastName());
	    userDto.setEmail(user.getEmail());
	    userDto.setDiplome(user.getDiplome());
	    userDto.setAdresseDomicile(user.getAdresseDomicile());
	    userDto.setAdresseTravail(user.getAdresseTravail());


        
//image
        List  <ImageDto> imagedto= new ArrayList <>();

for (ImageData image : user.getImages()) {

try {                                           
	ImageDto	imageDto=new ImageDto();    
	
	// Download the image data
    byte[] imageData =imageService.downloadImageFromFileSystem(image.getName());
System.out.println(imageData);
    
imageDto.setUrl(imageData);
    imageDto.setName(image.getName());
    imagedto.add(imageDto);
} catch (IOException e) {
    // Handle the exception if there's an issue reading the image data
    e.printStackTrace();
}
}
        userDto.setImages(imagedto);
	        

	    // set categories if needed
	    List<CategoryDto> categorydto=new ArrayList<>();
        for(Category  category :user.getCategories()  )
        {
     	   categorydto.add(new CategoryDto(category.getId(), category.getName())) ;      
        	
        }
        userDto.setCategory(categorydto);      

	    return userDto;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
