package com.example.demo.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.MyUser;
import com.example.demo.service.UserServiceImp;

@Controller

@RequestMapping("/registration")

public class UserController {

	private UserServiceImp userService;
	

	public UserController(UserServiceImp userService) {
		super();
		this.userService = userService;
	}
	
	@ModelAttribute("user")
    public MyUser user() {
        return new MyUser();
    }
	   @GetMapping("/secured-resource")
	    @PreAuthorize("hasRole('user')")
	    public ResponseEntity<String> getSecuredResource() {
	        // Your code here
	        return ResponseEntity.ok("Access granted to secured resource!");
	    }
	
	   @PostMapping
	   public ResponseEntity<MyUser> registerUserAccount(@RequestBody MyUser user) {
		   MyUser registeredUser = userService.save(user);
	       System.out.println("User registered: " + registeredUser.toString());
	       // Return the registered user as JSON
	       return new ResponseEntity<>(registeredUser, HttpStatus.CREATED);
	   }
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   /*
	   //updateeeeeeuser
	   @PutMapping("/{userId}")
	    public ResponseEntity<MyUser> updateUser(@PathVariable Long userId, @RequestBody MyUser updatedUserData) {
	        MyUser updatedUser = userService.updateMyUser(userId, updatedUserData);
	        return ResponseEntity.ok(updatedUser);
	    }
	   
	   */
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   


}