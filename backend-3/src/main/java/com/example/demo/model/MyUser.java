package com.example.demo.model;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;




@Entity
@Table(name = "my_user", uniqueConstraints = @UniqueConstraint(columnNames = "email"))
public class MyUser  {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    private String email;

    private String password;
   private String tel   ;


	private String diplome ;
    
    private String adresseDomicile ;
    
    private String adresseTravail ;
    
    
    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "role_id", nullable = false)
    private Role role;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Service> services;
    
    
    

    /*@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private Set<Image> images;
    */
    @ManyToMany
    @JoinTable(
        name = "my_user_categories",
        joinColumns = @JoinColumn(name = "user_id"),
        inverseJoinColumns = @JoinColumn(name = "category_id"))
    private Set<Category> categories;
 
    
    
    public MyUser() {

    }

    public MyUser(String firstName, String lastName, String email, String password, Role role) {
        super();
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.role = role != null ? role : new Role(Role.DEFAULT_ROLE);
    }
  
    
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    public String getTel() {
	return tel;
}

public void setTel(String tel) {
	this.tel = tel;
}
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDiplome() {
    	return diplome;
    }

    public void setDiplome(String diplome) {
    	this.diplome = diplome;
    }

    public String getAdresseDomicile() {
    	return adresseDomicile;
    }

    public void setAdresseDomicile(String adresseDomicile) {
    	this.adresseDomicile = adresseDomicile;
    }

    public String getAdresseTravail() {
    	return adresseTravail;
    }

    public void setAdresseTravail(String adresseTravail) {
    	this.adresseTravail = adresseTravail;
    }
    
    
    
    
    
    
    
 
    
    
    
public Set<Category> getCategories() {
    return categories;
}

public void setCategories(Set<Category> categories) {
    this.categories = categories;
}

 /*

	public Set<Image> getImages() {
		return images;
	}

	public void setImages(Set<Image> images) {
		this.images = images;
	}

	*/
    public Set<Service> getServices() {
        return services;
    }

    public void setServices(Set<Service> services) {
        this.services = services;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }


}
