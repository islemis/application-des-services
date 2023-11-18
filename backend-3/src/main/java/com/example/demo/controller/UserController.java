package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.User;
import com.example.demo.service.UserService;
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
    public User user() {
        return new User();
    }
	

	
	@PostMapping
	public User registerUserAccount(@RequestBody User registrationDto) {
		return	userService.save(registrationDto);
	}
}