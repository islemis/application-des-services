package com.example.demo.util;

import java.util.ArrayList;
import java.util.List;

import com.example.demo.dto.CategoryDto;
import com.example.demo.dto.ImageDto;
import com.example.demo.dto.MyUserDto;
import com.example.demo.dto.ServiceDto;
import com.example.demo.model.Category;
import com.example.demo.model.Image;
import com.example.demo.model.Service;

public abstract class ServiceUtil {

	
	
	
	public static ServiceDto Convert (Service service)
	{
		Long id=service.getIdService();
        ServiceDto servicedto=new ServiceDto();
          List  <ImageDto> imagedto= new ArrayList <>();
          List  <CategoryDto> categorydto= new ArrayList <>();

            MyUserDto userdto=new MyUserDto();
            servicedto.setIdService(id);
            servicedto.setTitre(service.getTitre());
            servicedto.setPrice(service.getPrice());
            servicedto.setAdresse(service.getAdresse());
            servicedto.setDescription(service.getDescription());
            servicedto.setDetails(service.getDetails());
            for(Image  image :service.getImages()  )
            {
            	imagedto.add(new ImageDto(image.getId(),image.getName(),image.getType()));
            	
            }
            servicedto.setImages(imagedto);

            userdto.setId(id);
            userdto.setFirstName(service.getUser().getFirstName());
            userdto.setLastName(service.getUser().getLastName());
            userdto.setEmail(service.getUser().getEmail());
            userdto.setDiplome(service.getUser().getDiplome());
            userdto.setAdresseDomicile(service.getUser().getAdresseDomicile());
            userdto.setAdresseTravail(service.getUser().getAdresseTravail());
            
           servicedto.setUser(userdto);
           
           for(Category  category :service.getCategories()  )
           {
        	   categorydto.add(new CategoryDto(category.getId(), category.getName())) ;      
           	
           }
           servicedto.setCategory(categorydto);

            return servicedto;
		
	}
	
	
	
	
	
	
	
	
}
