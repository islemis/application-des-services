package com.example.demo.service;

import java.util.Arrays;
import java.util.Collection;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import com.example.demo.model.Role;
import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;

@Service
public class UserServiceImp implements UserService, UserDetailsService {

	  private final UserRepository userRepository;
	    private final BCryptPasswordEncoder passwordEncoder;

	    public UserServiceImp( UserRepository userRepository, @Lazy BCryptPasswordEncoder passwordEncoder) {
	        this.userRepository = userRepository;
	        this.passwordEncoder = passwordEncoder;
	    }
	    
	    public User findByEmail(String email) {
	        return userRepository.findByEmail(email);
	                
	    }  
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
    @Override
    public User save(User user) {
        User user1 = new User(
            user.getFirstName(),
            user.getLastName(),
            user.getEmail(),
            passwordEncoder.encode(user.getPassword()),
            Arrays.asList(new Role("ROLE_USER"))
        );
        userRepository.save(user1);
        System.out.println("User saved: " + user1.toString());


        return user1;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email);
        if (user == null) {
            throw new UsernameNotFoundException("Invalid username or password.");
        }
        return new org.springframework.security.core.userdetails.User(
            user.getEmail(),
            user.getPassword(),
            mapRolesToAuthorities(user.getRoles())
        );
    }
 


    private Collection<? extends GrantedAuthority> mapRolesToAuthorities(Collection<Role> roles) {
        return roles.stream()
            .map(role -> new SimpleGrantedAuthority(role.getName()))
            .collect(Collectors.toList());
    }
}