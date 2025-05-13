package com.example.demo.util;


import com.example.demo.dto.MyUserDto;
import com.example.demo.dto.RoleDto;
import com.example.demo.model.MyUser;
import com.example.demo.model.Role;

public final class UserUtil {
	

	
	private UserUtil() {
		
	}

	public static MyUserDto convert(MyUser user) {
		MyUserDto userDto = new MyUserDto();
		userDto.setId(user.getId());
		userDto.setFirstName(user.getFirstName());
		userDto.setLastName(user.getLastName());
		userDto.setEmail(user.getEmail());
		userDto.setDiplome(user.getDiplome());
		userDto.setAdresseDomicile(user.getAdresseDomicile());
		userDto.setAdresseTravail(user.getAdresseTravail());

		userDto.setTel(user.getTel());
		RoleDto r = new RoleDto(user.getRole().getId(), user.getRole().getName());
		userDto.setRole(r);




		return userDto;
	}

	// from userDTo to user
	public static MyUser convertToUser(MyUserDto userDto) {
		MyUser user = new MyUser();
		user.setId(userDto.getId());
		user.setFirstName(userDto.getFirstName());
		user.setLastName(userDto.getLastName());
		user.setEmail(userDto.getEmail());
		user.setDiplome(userDto.getDiplome());
		user.setAdresseDomicile(userDto.getAdresseDomicile());
		user.setAdresseTravail(userDto.getAdresseTravail());
		user.setTel(userDto.getTel());
		Role r = new Role(userDto.getRole().getId(), userDto.getRole().getName());

		user.setRole(r);






		return user;
	}

}
