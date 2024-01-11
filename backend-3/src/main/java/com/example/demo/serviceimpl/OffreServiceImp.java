package com.example.demo.serviceimpl;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.stereotype.*;
import com.example.demo.dto.MyUserDto;
import com.example.demo.dto.OffreDto;
import com.example.demo.model.Category;
import com.example.demo.model.MyUser;
import com.example.demo.model.Offre;
import com.example.demo.repository.CategoryRepository;
import com.example.demo.repository.OffreRepository;
import com.example.demo.security.JwtTokenProvider;
import com.example.demo.service.ImageService;
import com.example.demo.service.OffreService;
import com.example.demo.util.OffreUtil;
import com.example.demo.util.UserUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class OffreServiceImp implements OffreService {

	@Autowired
    private  OffreRepository offreRepository;

	@Autowired
	private  UserServiceImp userService;
	@Autowired
	private  CategoryRepository categoryRepository;
	 @Autowired
	private ObjectMapper objectMapper;
   @Autowired
	 private ImageServiceImp imageDataService;

   @Autowired  
  private  JwtTokenProvider jwtTokenProvider;
	    
   @Autowired  

    private  OffreUtil offreUtil; 

	//getUserS

 @Override
 public List<OffreDto> getAllUserOffres(String authorizationHeader) {
	 
     List<Offre> liste= offreRepository.findAll();
     List<OffreDto> listeDto =new ArrayList<>();
     String base64Credentials = authorizationHeader.substring("Basic".length()).trim();
     String credentials = new String(Base64.getDecoder().decode(base64Credentials), StandardCharsets.UTF_8);
     final String[] values = credentials.split(":", 2);
     String email = values[0];
       MyUserDto currentUser = userService.findByEmail(email);


 Long    userId=currentUser.getId();
    
     for(Offre offre:liste)
     {
         if (offre.getUser().getId().equals(userId)) {

	         OffreDto   offredto =offreUtil.Convert(offre);

     	listeDto.add(offredto); 
     	}
     }
     return listeDto ; }
	//getoffres

 @Override
 public List<OffreDto> getAllOffres() {
	    List<Offre> liste= offreRepository.findAll();
        List<OffreDto> listeDto =new ArrayList<>();
       
        for(Offre offre:liste)
        {
	         OffreDto   offredto =offreUtil.Convert(offre);

        	listeDto.add(offredto);
        }
        return listeDto ;
        
    }
    
    
 @Override
 public OffreDto getOffreById(Long id) {
	  Offre offre = offreRepository.findById(id)
              .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "offre not found with id " + id));
   OffreDto   offredto =offreUtil.Convert(offre);
      return offredto;
 }
 //addOffre
 @Override
 @Transactional
 public void saveOffre(String offreJson, MultipartFile[] images, String authorizationHeader) {
	 try {

         Offre offre = objectMapper.readValue(offreJson, Offre.class);

         offre.setDate(new Date());
      //   UserDetails userDetails = jwtTokenProvider.getUserDetailsFromToken(token);
    
         
         
         String base64Credentials = authorizationHeader.substring("Basic".length()).trim();
         String credentials = new String(Base64.getDecoder().decode(base64Credentials), StandardCharsets.UTF_8);
         final String[] values = credentials.split(":", 2);
         String email = values[0];
           MyUserDto userDto = userService.findByEmail(email);
           MyUser currentUser=UserUtil.convertToUser(userDto,imageDataService);
         offre.setUser(currentUser);
         
	      
         Offre savedoffre = offreRepository.save(offre);
         
         savedoffre.setCategories(offre.getCategories());

        for (MultipartFile file : images) {
            String result = imageDataService.uploadImageToFileSystem(file, savedoffre,null,false);
            System.out.println(result);
        }

     } catch (IOException e) {
     }
 }
//deleteoffre
 @Override
 public void deleteOffre(Long id) {
	 offreRepository.deleteById(id); }
//updateoffre
 @Override
 public void  updateOffre(Long id, String offreJson, MultipartFile[] files) {
     Offre offreUpdate = new Offre();

     Offre offre = offreRepository.findById(id)
             .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "offre not found with id " + id));
		try {
			offreUpdate = objectMapper.readValue(offreJson, Offre.class);
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//offre.getCategories().clear();

     offre.setCategories(offreUpdate.getCategories());

     offre.setTitre(offreUpdate.getTitre());
     offre.setPrice(offreUpdate.getPrice());
     offre.setDescription(offreUpdate.getDescription());
     offre.setDetails(offreUpdate.getDetails());
     offre.setDate(new Date());
     offre.setAdresse(offreUpdate.getAdresse());

     
			try {
				for (MultipartFile file : files) {
				String imageResponse = imageDataService.uploadImageToFileSystem(file, offre,null,false)   ;
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		

     final Offre updatedoffre = offreRepository.save(offre);
 }
//getoffresByCategory
 @Override
 public List<OffreDto> getOffresByCategory(String nom) {
	   List<Offre> offres = offreRepository.findAll();

   	Set<Category> c = new  HashSet<>();
       List<OffreDto> offresCat =new  ArrayList<>();
       for(Offre offre:offres)
       {
				c=offre.getCategories();
				for(Category cat:c)
				{
					if(cat.getName().equals(nom))
					{
				         OffreDto   offredto =offreUtil.Convert(offre);
							System.out.println("here");
				         offresCat.add(offredto);
						
					}
						
				}
				
       }
       return offresCat;

       	
       } 
}
