package com.example.demo.model;

import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;

import lombok.Builder;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Images")

@Builder
public  class Image {
	 @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)

	 private Long id;

    @Column(name = "name")
    private String name;
    
    @Column(name = "type")
private String type ;
    @Lob
    @Column(name = "imagedata",length=1000)
private byte [] imageData ;

    @ManyToOne
    @JoinColumn(name = "service_id")
    private Service service;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

 
    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

	  public Image( String name, String type, byte[] imageData) {
	        this.name = name;
	        this.type = type;
	        this.imageData = imageData;
	        this.service = service;
	    }

	  public Image(Long id, String name, String type, byte[] imageData, Service service) {
	        this.id = id;
	        this.name = name;
	        this.type = type;
	        this.imageData = imageData;
	        this.service = service;
	    }
	  public Image() {
	    }

	public byte[] getImageData() {
		return imageData;
	}

	public void setImageData(byte[] imageData) {
		this.imageData = imageData;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}

