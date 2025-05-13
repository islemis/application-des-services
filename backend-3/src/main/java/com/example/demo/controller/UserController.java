package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.example.demo.dto.MyUserDto;
import com.example.demo.model.MyUser;
import com.example.demo.serviceimpl.UserServiceImp;

@RestController
@RequestMapping("api/MyUser")

public class UserController {
@Autowired
	private UserServiceImp userServiceImp;

	  
	//Register
	   @PostMapping("register")
	   public ResponseEntity<?> registerUserAccount(@RequestBody MyUser user) {
		   MyUser registeredUser = userServiceImp.save(user);
	       return new ResponseEntity<>("the user "+registeredUser.getId()+" is registred successfully", HttpStatus.CREATED);
	   }

	 //UpdateUser
	   @PutMapping("update/{userId}")

	   public ResponseEntity<?> updateUser(@PathVariable Long userId, @RequestParam("user") String userJson) {
	         userServiceImp.updateUser(userId, userJson);
		       return new ResponseEntity<>("the user "+userId+" is updated successfully", HttpStatus.CREATED);

	         
	    }
	   //deleteUser
	    @DeleteMapping("/delete/{userId}")
	    public ResponseEntity<String> deleteUser(@PathVariable Long userId) {
	        userServiceImp.deleteUserById(userId);
	       
	        return  ResponseEntity.ok("deleted successfully");
	    }
	    
        //getUserbyid
	    @GetMapping("/{userId}")
	    public MyUserDto getUserById(@PathVariable Long userId) {
	        return 	   userServiceImp.getUserById(userId);

	    }
	    
	  //getUserbyEmail
	    @GetMapping("email/{email}")
	    public MyUserDto findByEmail(@PathVariable String email) {
	        return userServiceImp.findByEmail(email);

	    }   
        //getALLusers
	    @GetMapping("/Users")

	    public List<MyUserDto> getUsers() {
	        return userServiceImp.getUsers();
	    }




}