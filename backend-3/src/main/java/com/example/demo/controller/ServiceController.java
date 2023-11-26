package com.example.demo.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
	import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import com.example.demo.model.Category;
import com.example.demo.model.Image;
import com.example.demo.model.MyUser;
import com.example.demo.model.Service;
import com.example.demo.repository.CategoryRepository;
import com.example.demo.repository.ServiceRepository;
import com.example.demo.repository.StorageRepository;
import com.example.demo.service.ImageService;
import com.example.demo.service.UserServiceImp;
import com.example.demo.util.ImageUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

import java.io.IOException;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
	@RestController
	@RequestMapping("/services")

	public class ServiceController {

		@Autowired
		    private  ServiceRepository serviceRepository;
		@Autowired
		private  StorageRepository storageRepository;
		@Autowired
		private  UserServiceImp userService;
		@Autowired
		private  CategoryRepository CategoryRepository;
		 @Autowired

		  private ObjectMapper objectMapper;
		    @Autowired
		    private ImageService imageDataService;

		
		//getServices
		    @GetMapping
		    public List<Service> getAllServices() {
		        return serviceRepository.findAll();
		    }
		    
		    //getServiceById

		    @GetMapping("/{id}")
		    public ResponseEntity<Service> getServiceById(@PathVariable Long id) {
		        Service service = serviceRepository.findById(id)
		                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Service not found with id " + id));
		        return ResponseEntity.ok(service);
		    }


		    
		    @PostMapping("/addService")
		    public ResponseEntity<?> saveService(
		            @RequestParam("service") String serviceJson,
		            @RequestParam("file") MultipartFile file
		    ) {
		        try {
		            ResponseEntity<String> imageResponse = imageDataService.uploadImage(file);
		            String fileName = imageResponse.getBody(); // Assuming the file upload response contains the file name

		            Service service = objectMapper.readValue(serviceJson, Service.class);
		            service.setDate(new Date());

		            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		            String email = userDetails.getUsername();
		            MyUser currentUser = userService.findByEmail(email);
		            service.setUser(currentUser);

		            Service savedService = serviceRepository.save(service);

		            // Save images
		            saveImages(savedService, fileName);

		            // Save categories
		            saveCategories(savedService);

		            return ResponseEntity.ok("Service saved successfully");
		        } catch (IOException e) {
		            // Handle exceptions appropriately (e.g., return an error response)
		            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error saving service");
		        }
		    }

		    
		    private void saveCategories(Service service) {
		        Set<Category> categories = service.getCategories();
		        Set<Service> services = new HashSet<>();
		        services.add(service);

		        categories.forEach(category -> {
		            category.setServices(services);
		            CategoryRepository.save(category);
		        });
		    }	    
		    private void saveImages(com.example.demo.model.Service  service, String fileName) {
		        Image image = Image.builder()
		                .name(fileName)
		                .type("image/jpeg") // Set the appropriate content type
		                .imageData(ImageUtil.compressImage(fileName.getBytes()))
		                .service(service)
		                .build();

		        storageRepository.save(image);
		    }
		    
		    
		    
		    
		    
		    
		    
		    
		    
//deleteService
		    @DeleteMapping("/{id}")
		    public void deleteService(@PathVariable Long id) {
		        serviceRepository.deleteById(id);
		    }

//UpdateService
		    @PutMapping("/{id}")
		    public ResponseEntity<Service> updateService(@PathVariable Long id, @RequestBody Service serviceDetails) {
		        Service service = serviceRepository.findById(id)
		                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Service not found with id " + id));

		        service.setTitre(serviceDetails.getTitre());
		        service.setPrice(serviceDetails.getPrice());
		        service.setDescription(serviceDetails.getDescription());
		        service.setDetails(serviceDetails.getDetails());
		        service.setDate(serviceDetails.getDate());
		        service.setAdresse(serviceDetails.getAdresse());
		        service.setImages(serviceDetails.getImages());

		        final Service updatedService = serviceRepository.save(service);
		        return ResponseEntity.ok(updatedService);
		    }

		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    /*
		    @PostMapping("/addService")

		    
		    public ResponseEntity<?> saveService(@RequestBody Service service) {
		        // Set the date
		        service.setDate(new Date());
service.setImages(service.getImages());
//service.setImages(service.getImages());
service.setCategories(service.getCategories());
// Get the currently authenticated user

    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
  	  UserDetails userDetails =   (UserDetails) authentication.getPrincipal();
        String email = userDetails.getUsername();
      MyUser  currentUser=userService.findByEmail(email);
  		        // Set the user for the service
  		        service.setUser(currentUser);
Service s=serviceRepository.save(service);
/*
Set<Image> image=s.getImages();
image.forEach(a->{ a.setService(s);
	storageRepository.save(a);
	});
	});
Set<Category> categories=s.getCategories();
Set<Service> services= new HashSet<>();
services.add(service);
categories.forEach(x->{x.setServices(services);
CategoryRepository.save(x);
	});
		        // Save the service
		        return ResponseEntity.ok("ok") ;
		    }
		    
		    */
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    

	}


