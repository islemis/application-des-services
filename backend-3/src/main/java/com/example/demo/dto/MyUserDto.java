package com.example.demo.dto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MyUserDto {
    private Long id;
    private String firstName;
    private String adresseTravail ;
    private String adresseDomicile ;
	private String diplome ;
	   private String tel   ;
	    private String password;
	    private String email;
	    private String lastName;

}