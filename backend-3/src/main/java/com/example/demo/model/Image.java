package com.example.demo.model;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

import org.springframework.boot.context.properties.ConfigurationProperties;

@Entity
@Table(name = "images")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Image {
	

	    @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Long id;

	    private String name;

	    private String type;
	   

	    @Lob
	    @Column(name = "imagedata", length = 1000)
	    private byte[] imageData;
	    
	    @ManyToOne
	    @JoinColumn(name = "service_id")
	    private Service service;
	    @ManyToOne
	    @JoinColumn(name = "user_id")
	    private MyUser user;
	
}
