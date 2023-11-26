package com.example.demo.service;

import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.demo.model.Category;
import com.example.demo.model.Image;
import com.example.demo.model.MyUser;
import com.example.demo.model.Role;
import com.example.demo.repository.RoleRepository;
import com.example.demo.repository.StorageRepository;
import com.example.demo.repository.UserRepository;

@Service
public class UserServiceImp implements UserService, UserDetailsService {

	  private final UserRepository userRepository;
	    private final BCryptPasswordEncoder passwordEncoder;
		  private final RoleRepository RoleRepository;
			@Autowired
			private  StorageRepository storageRepository;


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
	    
	    
	    
	    //saveUser

	@Override
	public MyUser save(MyUser user) {
		   // Get or create the role with the name "user"
        Role userRole = RoleRepository.findByName(Role.DEFAULT_ROLE);
      //  user.setImages(user.getImages());

        // Set the obtained role to the user
        user.setRole(userRole);

        // Encode the password before saving
        user.setPassword(passwordEncoder.encode(user.getPassword()));

       
        MyUser savedUser = userRepository.save(user);
      
        System.out.println("User saved: " + savedUser.toString());

        return savedUser;
	}
	
	//UpdateUser
/*
	public MyUser updateMyUser(Long userId, MyUser updatedUserData) {
	    MyUser existingUser = userRepository.findById(userId)
	            .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));

	    // Mettez à jour les champs nécessaires
	    existingUser.setFirstName(updatedUserData.getFirstName());
	    existingUser.setLastName(updatedUserData.getLastName());
	    existingUser.setDiplome(updatedUserData.getDiplome());
	    existingUser.setAdresseDomicile(updatedUserData.getAdresseDomicile());
	    existingUser.setAdresseTravail(updatedUserData.getAdresseTravail());
	    existingUser.setTel(updatedUserData.getTel());

	    // Ajouter les catégories existantes
	    existingUser.setCategories(updatedUserData.getCategories());

	    // Mettez à jour les images associées
	    Set<Image> updatedImages = updatedUserData.getImages();
	    existingUser.getImages().clear(); // Supprimer toutes les images existantes
	    for (Image image : updatedImages) {
	        // Assurez-vous que votre storageRepository est correctement configuré
	        storageRepository.save(image);
	        existingUser.getImages().add(image);
	    }

	    return userRepository.save(existingUser);
	}
*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	
    public MyUser updateMyUser(Long userId, MyUser updatedUserData) {
        MyUser existingUser = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));

        // Mettez à jour les champs nécessaires
        existingUser.setFirstName(updatedUserData.getFirstName());
        existingUser.setLastName(updatedUserData.getLastName());
        existingUser.setEmail(updatedUserData.getEmail());
        existingUser.setRole(updatedUserData.getRole());
        existingUser.setDiplome(updatedUserData.getDiplome());
        existingUser.setAdresseDomicile(updatedUserData.getAdresseDomicile());
        existingUser.setAdresseTravail(updatedUserData.getAdresseTravail());

        // Mettez à jour les services associés s'il y a lieu
        // existingUser.setServices(updatedUserData.getServices());

        // Mettez à jour les catégories associées s'il y a lieu
        
        Set<Category> categories=updatedUserData.getCategories();
        Set<User> users= new HashSet<>();
        users.add(updatedUserData);

        categories.forEach(x->{x.;

        CategoryRepository.save(x);
        	});
        
        
        
        
        existingUser.setCategories(updatedUserData.getCategories());

        // Mettez à jour les images associées s'il y a lieu
        
        Set<Image> image=updatedUserData.getImages();
        image.forEach(a->{ a.setUser(updatedUserData);
        	storageRepository.save(a);
        	});
        existingUser.setImages(updatedUserData.getImages());

        // Vous pouvez également ajouter la logique pour gérer d'autres relations

        return userRepository.save(existingUser);
    }
	
	
	*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
 


    
}