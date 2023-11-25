package com.example.demo.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.model.Image;

public interface StorageRepository extends JpaRepository<Image,Long>{
	
	
	
	Optional <Image>findByName(String fileName);

}
