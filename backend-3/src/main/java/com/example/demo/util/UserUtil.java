package com.example.demo.util;

import java.util.ArrayList;
import java.util.List;

import com.example.demo.dto.CategoryDto;
import com.example.demo.dto.ImageDto;
import com.example.demo.dto.MyUserDto;
import com.example.demo.model.Category;
import com.example.demo.model.Image;
import com.example.demo.model.MyUser;

public abstract class UserUtil {

	
	public static MyUserDto convert(MyUser user) {
	    MyUserDto userDto = new MyUserDto();
	    userDto.setId(user.getId());
	    userDto.setFirstName(user.getFirstName());
	    userDto.setLastName(user.getLastName());
	    userDto.setEmail(user.getEmail());
	    userDto.setDiplome(user.getDiplome());
	    userDto.setAdresseDomicile(user.getAdresseDomicile());
	    userDto.setAdresseTravail(user.getAdresseTravail());


	    // set categories if needed
	    List<ImageDto> imagedto=new ArrayList<>();
        for(Image  image :user.getImages()  )
        {
        	imagedto.add(new ImageDto(image.getId(), image.getName(),image.getType())) ;      
        	
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
