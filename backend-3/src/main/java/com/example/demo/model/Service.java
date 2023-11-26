package com.example.demo.model;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonManagedReference;



@Entity
@Table(name="Services")
public class Service {
		 @Id
		    @GeneratedValue(strategy = GenerationType.IDENTITY)
		    @Column(name = "id_service")
		    private Long idService;

		    @Column(name = "titre")
		    private String titre;

		    @Column(name = "price")
		    private Float price;

		    @Column(name = "description")
		    private String description;

		    @Column(name = "details")
		    private String details;

		    @Temporal(TemporalType.TIMESTAMP)		    
		    @Column(name = "date")
		    private Date date;

		    @Column(name = "adresse")
		    private String adresse;
		    
		    @OneToMany(mappedBy = "service", cascade = CascadeType.ALL)
		    private Set<Image> images;
		    
		   @ManyToOne
		    @JoinColumn(name = "user_id")
		    private MyUser user;
		   @ManyToMany
		    @JoinTable(
		        name = "service_category",
		        joinColumns = @JoinColumn(name = "service_id"),
		        inverseJoinColumns = @JoinColumn(name = "category_id"))
		    private Set<Category> categories = new HashSet<>();
		    


		    public Set<Category> getCategories() {
			return categories;
		}

		public void setCategories(Set<Category> categories) {
			this.categories = categories;
		}

			public MyUser getUser() {
		        return user;
		    }

		    public void setUser(MyUser user) {
		        this.user = user;
		    }

		  
		 
		public Set<Image> getImages() {
				return images;
			}

			public void setImages(Set<Image> images) {
				this.images = images;
			}

		public Long getIdService() {
			return idService;
		}
		public void setIdService(Long idService) {
			this.idService = idService;
		}
		public String getTitre() {
			return titre;
		}
		public void setTitre(String titre) {
			this.titre = titre;
		}
		public Float getPrice() {
			return price;
		}
		public void setPrice(Float price) {
			this.price = price;
		}
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
		public String getDetails() {
			return details;
		}
		public void setDetails(String details) {
			this.details = details;
		}
		public Date getDate() {
			return date;
		}
		public void setDate(Date date) {
			this.date = date;
		}
		public String getAdresse() {
			return adresse;
		}
		public void setAdresse(String adresse) {
			this.adresse = adresse;
		}

	

	

}
