package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.example.demo.dto.MyUserDto;
import com.example.demo.model.LoginRequest;
import com.example.demo.model.MyUser;
import com.example.demo.serviceimpl.UserServiceImp;

@Controller
@RequestMapping("api/MyUser")

public class UserController {
@Autowired
	private UserServiceImp userServiceImp;

	  
	//Register
	   @PostMapping("add")
	   public ResponseEntity<?> registerUserAccount(@RequestBody MyUser user) {
		   MyUser registeredUser = userServiceImp.save(user);
	       return new ResponseEntity<>("the user "+registeredUser.getId()+" is registred successfully", HttpStatus.CREATED);
	   }
	   
	   
	
	      
	 //UpdateUser
	   @PutMapping("update/{userId}")

	   public ResponseEntity<?> updateUser(@PathVariable Long userId, @RequestParam("user") String userJson,
	            @RequestParam("file") MultipartFile[] file,@RequestParam("profil") MultipartFile profil) {
	         userServiceImp.updateUser(userId, userJson, file,profil);
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
	    @ResponseBody
	    public MyUserDto getUserById(@PathVariable Long userId) {
	        return 	   userServiceImp.getUserById(userId);

	    }
	    
	  //getUserbyEmail
	    @GetMapping("email/{email}")
	    @ResponseBody
	    public MyUserDto findByEmail(@PathVariable String email) {
	        return userServiceImp.findByEmail(email);

	    }   
        //getALLusers
	    @GetMapping("/Users")
	    @ResponseBody

	    public List<MyUserDto> getUsers() {
	        return userServiceImp.getUsers();
	    }
	    //changeRoleUser
		   @PutMapping("/changeRole/{userId}")
		    public ResponseEntity<String> changeUserRole(@PathVariable Long userId) {
		        try {
		            userServiceImp.changeUserRole(userId);
		            return ResponseEntity.ok("User role changed successfully");
		        } catch (IllegalArgumentException e) {
		            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
		        }
		    }
		   


}