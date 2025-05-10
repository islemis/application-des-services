package com.example.demo.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.example.demo.dto.CategoryDto;
import com.example.demo.dto.MyUserDto;
import com.example.demo.dto.RoleDto;
import com.example.demo.model.Category;
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



		// set categories if needed
		List<CategoryDto> categorydto = new ArrayList<>();
		for (Category category : user.getCategories()) {
			categorydto.add(new CategoryDto(category.getId(), category.getName()));

		}
		userDto.setCategory(categorydto);

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



		// Categories
		Set<Category> categoryList = new HashSet<>();
		for (CategoryDto categoryDto : userDto.getCategory()) {
			Category category = new Category();
			category.setId(categoryDto.getId());
			category.setName(categoryDto.getName());
			categoryList.add(category);
		}
		user.setCategories(categoryList);

		return user;
	}

}
