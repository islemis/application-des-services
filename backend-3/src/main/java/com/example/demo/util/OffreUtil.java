package com.example.demo.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.example.demo.dto.CategoryDto;
import com.example.demo.dto.MyUserDto;
import com.example.demo.dto.OffreDto;
import com.example.demo.model.Category;
import com.example.demo.model.Offre;

@Component

public  class OffreUtil {



 	public  OffreDto Convert (Offre offre)
	{
		
		Long id=offre.getIdOffre();
        OffreDto offredto=new OffreDto();
            MyUserDto userdto=new MyUserDto();
            
            
            
            
            //offre
            offredto.setIdOffre(id);
            offredto.setTitre(offre.getTitre());
            offredto.setPrice(offre.getPrice());
            offredto.setAdresse(offre.getAdresse());
            offredto.setDescription(offre.getDescription());
            offredto.setDetails(offre.getDetails());
            offredto.setDate(offre.getDate());
            


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
        List<CategoryDto> categorydto = offre.getCategories().stream()
                .map(category -> new CategoryDto(category.getId(), category.getName()))
                .collect(Collectors.toList());

        offredto.setCategory(categorydto);

		
	
	
	
	
	
	
return offredto;

	
	
}

}