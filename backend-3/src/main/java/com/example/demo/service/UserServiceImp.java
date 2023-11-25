package com.example.demo.service;

import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.demo.model.MyUser;
import com.example.demo.model.Role;
import com.example.demo.repository.RoleRepository;
import com.example.demo.repository.UserRepository;

@Service
public class UserServiceImp implements UserService, UserDetailsService {

	  private final UserRepository userRepository;
	    private final BCryptPasswordEncoder passwordEncoder;
		  private final RoleRepository RoleRepository;

	    public UserServiceImp( UserRepository userRepository, @Lazy BCryptPasswordEncoder passwordEncoder, RoleRepository roleRepository) {
	        this.userRepository = userRepository;
	        this.passwordEncoder = passwordEncoder;
			this.RoleRepository = roleRepository;
	    }
	    
	    public MyUser findByEmail(String email) {
	        return userRepository.findByEmail(email);
	                
	    }  
	    
	 
	    @Override
	    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
	    	MyUser user = userRepository.findByEmail(email);
	        if (user == null) {
	            throw new UsernameNotFoundException("Invalid email or password.");
	        }

	        // Assuming each user has only one role
	        Role userRole = user.getRole();
	        GrantedAuthority authority = new SimpleGrantedAuthority(userRole.getName());
	        List<GrantedAuthority> authorities = Collections.singletonList(authority);

	        return new User(
	            user.getEmail(),
	            user.getPassword(),
	            authorities
	        );
	    }

	@Override
	public MyUser save(MyUser user) {
		   // Get or create the role with the name "user"
        Role userRole = RoleRepository.findByName(Role.DEFAULT_ROLE);

        // Set the obtained role to the user
        user.setRole(userRole);

        // Encode the password before saving
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        // Save the user
        MyUser savedUser = userRepository.save(user);

        System.out.println("User saved: " + savedUser.toString());

        return savedUser;
	}
 


    
}