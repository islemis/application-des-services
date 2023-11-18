package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.example.demo", "com.example.demo.config"})

public class Backend3Application {

	public static void main(String[] args) {
		
		SpringApplication.run(Backend3Application.class, args);
	}

}
