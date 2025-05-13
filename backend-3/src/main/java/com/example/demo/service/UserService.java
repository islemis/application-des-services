package com.example.demo.service;

import java.util.List;
import com.example.demo.dto.MyUserDto;
import com.example.demo.model.MyUser;



public interface UserService  {
	
	MyUser save(MyUser user);
	MyUserDto findByEmail(String email);
	List<MyUserDto> getUsers();
	MyUserDto getUserById(Long id);
	void deleteUserById(Long id);
}
