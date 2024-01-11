package com.example.demo.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.example.demo.dto.CategoryDto;
import com.example.demo.dto.ImageDto;
import com.example.demo.dto.MyUserDto;
import com.example.demo.dto.OffreDto;
import com.example.demo.model.Category;
import com.example.demo.model.ImageData;
import com.example.demo.model.Offre;
import com.example.demo.service.ImageService;
@Component

public  class OffreUtil {
	 private final ImageService imageService;

	    @Autowired
	    public OffreUtil(ImageService imageoffre) {
	        this.imageService = imageoffre;
	    }
	
 	public  OffreDto Convert (Offre offre)
	{
		
		Long id=offre.getIdOffre();
        OffreDto offredto=new OffreDto();
          List  <ImageDto> imagedto= new ArrayList <>();
          List  <CategoryDto> categorydto= new ArrayList <>();
            MyUserDto userdto=new MyUserDto();
            
            
            
            
            //offre
            offredto.setIdOffre(id);
            offredto.setTitre(offre.getTitre());
            offredto.setPrice(offre.getPrice());
            offredto.setAdresse(offre.getAdresse());
            offredto.setDescription(offre.getDescription());
            offredto.setDetails(offre.getDetails());
            offredto.setDate(offre.getDate());
            
//image
for (ImageData image : offre.getImages()) {

    try {                                           
    	ImageDto	imageDto=new ImageDto();    
    	
    	// Download the image data
        byte[] imageData =imageService.downloadImageFromFileSystem(image.getName());
System.out.println(imageData);
        
   imageDto.setUrl(imageData);
        imageDto.setImagePath(image.getImagePath());
        imageDto.setName(image.getName());
        imageDto.setType(image.getType());
        imagedto.add(imageDto);
    } catch (IOException e) {
        // Handle the exception if there's an issue reading the image data
        e.printStackTrace();
    }
}
            offredto.setImages(imagedto);

            //user
            userdto.setId(offre.getUser().getId());
            userdto.setFirstName(offre.getUser().getFirstName());
            userdto.setLastName(offre.getUser().getLastName());
            userdto.setEmail(offre.getUser().getEmail());
            userdto.setDiplome(offre.getUser().getDiplome());
            userdto.setAdresseDomicile(offre.getUser().getAdresseDomicile());
            userdto.setAdresseTravail(offre.getUser().getAdresseTravail());
            userdto.setTel(offre.getUser().getTel());
            
           offredto.setUser(userdto);
           //categories
           for(Category  category :offre.getCategories()  )
           {
        	   categorydto.add(new CategoryDto(category.getId(), category.getName())) ;      
           	
           }
           offredto.setCategory(categorydto);

		
	
	
	
	
	
	
return offredto;

	
	
}
}
