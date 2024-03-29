package com.example.demo.serviceimpl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dto.MyUserDto;

import com.example.demo.model.MyUser;
import com.example.demo.model.Role;
import com.example.demo.repository.CategoryRepository;
import com.example.demo.repository.RoleRepository;
import com.example.demo.repository.UserRepository;
import com.example.demo.security.JwtTokenProvider;
import com.example.demo.service.ImageService;
import com.example.demo.service.UserService;
import com.example.demo.util.UserUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class UserServiceImp implements UserService,UserDetailsService{


	private final UserRepository userRepository;
	private final BCryptPasswordEncoder passwordEncoder;
	private final RoleRepository RoleRepository;
	@Autowired
	private ObjectMapper objectMapper;
	@Autowired
	private ImageService imageDataService;


	private final AuthenticationManager authenticationManager;
	private final JwtTokenProvider jwtTokenProvider;

	public UserServiceImp(AuthenticationManager authenticationManager, @Lazy JwtTokenProvider jwtTokenProvider,
			UserRepository userRepository, @Lazy BCryptPasswordEncoder passwordEncoder, RoleRepository roleRepository) {
		this.userRepository = userRepository;
		this.passwordEncoder = passwordEncoder;
		this.RoleRepository = roleRepository;
		this.authenticationManager = authenticationManager;
		this.jwtTokenProvider = jwtTokenProvider;

	}

	// findUserByEmail
	public MyUserDto findByEmail(String email) {
	       MyUser user= userRepository.findByEmail(email);
	       return UserUtil.convert(user,imageDataService);
	                
	    }

	// loadUserByUsername
	
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		MyUser user = userRepository.findByEmail(email);
		if (user == null) {
			throw new UsernameNotFoundException("Invalid email or password.");
		}

		// Assuming each user has only one role
		Role userRole = user.getRole();
		GrantedAuthority authority = new SimpleGrantedAuthority(userRole.getName());
		List<GrantedAuthority> authorities = Collections.singletonList(authority);

		return new User(user.getEmail(), user.getPassword(), authorities);
	}

	// saveUser

	@Override
	public MyUser save(MyUser user) {
		// Get or create the role with the name "user"
		Role userRole = RoleRepository.findByName(Role.DEFAULT_ROLE);
		// user.setImages(user.getImages());

		// Set the obtained role to the user
		user.setRole(userRole);

		// Encode the password before saving
		user.setPassword(passwordEncoder.encode(user.getPassword()));

		MyUser savedUser = userRepository.save(user);

		System.out.println("User saved: " + savedUser.toString());

		return savedUser;
	}

//updateUser
	public void updateUser(Long id, String userJson, MultipartFile[] images, MultipartFile profilImage) {
		MyUser userUpdate = new MyUser();
		MyUser user = userRepository.findById(id).orElseThrow();
		try {
			userUpdate = objectMapper.readValue(userJson, MyUser.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		user.setFirstName(userUpdate.getFirstName());
		user.setLastName(userUpdate.getLastName());
		user.setDiplome(userUpdate.getDiplome());
		user.setAdresseDomicile(userUpdate.getAdresseDomicile());
		user.setAdresseTravail(userUpdate.getAdresseTravail());
		user.setTel(userUpdate.getTel());

		try {
			for (MultipartFile file : images) {
				String imageResponse = imageDataService.uploadImageToFileSystem(file, null, user, false);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		try {
			String imageResponseProfil = imageDataService.uploadImageToFileSystem(profilImage, null, user, true);
		} catch (IOException e) {
			e.printStackTrace();
		}
		user.setCategories(userUpdate.getCategories());
		MyUser updatedUser = userRepository.save(user);


	}

//deleteUser

	public void deleteUserById(Long userId) {
		userRepository.deleteById(userId);

	}

	// getUser
	public MyUserDto getUserById(Long userId) {
		MyUser user = userRepository.findById(userId).orElse(null);

		return UserUtil.convert(user, imageDataService);

	}

//getUsers
	public List<MyUserDto> getUsers() {
		List<MyUser> list = userRepository.findAll();
		List<MyUserDto> listeDto = new ArrayList<>();

		for (MyUser user : list) {

			MyUserDto userdto = UserUtil.convert(user, imageDataService);

			listeDto.add(userdto);
		}
		return listeDto;

	}

	public void changeUserRole(Long userId) {
		// Find the user by ID
		MyUser user = userRepository.findById(userId).orElse(null);

		if (user != null) {
			// Find the role by name
			Role newRole = RoleRepository.findByName("prestataire");

			if (newRole != null) {
				// Set the new role for the user
				user.setRole(newRole);

				// Save the updated user
				userRepository.save(user);
			} else {
				throw new IllegalArgumentException("Role not found: ");
			}
		} else {
			throw new IllegalArgumentException("User not found with ID: " + userId);
		}
	}



}