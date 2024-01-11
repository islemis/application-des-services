package com.example.demo.service;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetailsService;

import com.example.demo.dto.MyUserDto;
import com.example.demo.model.LoginRequest;
import com.example.demo.model.MyUser;



public interface UserService  {
	
	MyUser save(MyUser user);
	MyUserDto findByEmail(String email);
	List<MyUserDto> getUsers();
	MyUserDto getUserById(Long id);
	void deleteUserById(Long id);
	void changeUserRole(Long id) ;
}
