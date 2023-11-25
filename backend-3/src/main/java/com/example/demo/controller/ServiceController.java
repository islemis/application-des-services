package com.example.demo.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
	import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import com.example.demo.model.Image;
import com.example.demo.model.MyUser;
import com.example.demo.model.Service;
import com.example.demo.repository.ServiceRepository;
import com.example.demo.repository.StorageRepository;
import com.example.demo.service.UserServiceImp;

import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;


import java.util.Date;
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
		    
		   
		    @GetMapping
		    public List<Service> getAllServices() {
		        return serviceRepository.findAll();
		    }

		    @GetMapping("/{id}")
		    public ResponseEntity<Service> getServiceById(@PathVariable Long id) {
		        Service service = serviceRepository.findById(id)
		                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Service not found with id " + id));
		        return ResponseEntity.ok(service);
		    }


		    @PostMapping("/addService")
		    public ResponseEntity<?> saveService(@RequestBody Service service) {
		        // Set the date
		        service.setDate(new Date());
service.setImages(service.getImages());
		        // Get the currently authenticated user
	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	  UserDetails userDetails =  (UserDetails) authentication.getPrincipal();
      String email = userDetails.getUsername();
    MyUser  currentUser=userService.findByEmail(email);
		        // Set the user for the service
		        service.setUser(currentUser); 
Service s=serviceRepository.save(service);

Set<Image> image=s.getImages();
image.forEach(a->{ a.setService(s);
	storageRepository.save(a);

	});

	

		        // Save the service
		        return ResponseEntity.ok("ok") ;
		    }
		    
		    
		    
		    
		    
		    
		    
		    
		    
/*
		    @PostMapping

		    public Service saveService(@RequestBody Service service) {
		    	service.setDate(new Date());
		        return serviceRepository.save(service);
		    }*/
		    
		    @CrossOrigin(origins = "http://localhost:4200")

		    @DeleteMapping("/{id}")
		    public void deleteService(@PathVariable Long id) {
		        serviceRepository.deleteById(id);
		    }
		    @CrossOrigin(origins = "http://localhost:4200")

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


	}


