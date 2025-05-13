package com.example.demo.serviceimpl;

import java.io.IOException;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.stereotype.*;
import com.example.demo.dto.MyUserDto;
import com.example.demo.dto.OffreDto;
import com.example.demo.model.Category;
import com.example.demo.model.MyUser;
import com.example.demo.model.Offre;
import com.example.demo.repository.CategoryRepository;
import com.example.demo.repository.OffreRepository;
import com.example.demo.security.JwtTokenProvider;
import com.example.demo.service.OffreService;
import com.example.demo.util.OffreUtil;
import com.example.demo.util.UserUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class OffreServiceImp implements OffreService {

    @Autowired
    private  OffreRepository offreRepository;

    @Autowired
    private  UserServiceImp userService;
    @Autowired
    private  CategoryRepository categoryRepository;
    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private  JwtTokenProvider jwtTokenProvider;

    @Autowired

    private  OffreUtil offreUtil;

    //getUserS

    @Override
    public List<OffreDto> getAllUserOffres(String authorizationHeader) {
        List<Offre> liste = offreRepository.findAll();

        // Extract token from Bearer header
        String token = authorizationHeader.substring("Bearer ".length()).trim();

        // Get user details from token
        UserDetails userDetails = jwtTokenProvider.getUserDetailsFromToken(token);
        String email = userDetails.getUsername();

        // Get user ID from email
        MyUserDto currentUser = userService.findByEmail(email);
        Long userId = currentUser.getId();

        List<OffreDto> listeDto = liste.stream()
                .filter(offre -> offre.getUser() != null && offre.getUser().getId().equals(userId))
                .map(offre -> offreUtil.Convert(offre))
                .collect(Collectors.toList());

        return listeDto;
    }
    //getoffres

    @Override
    public List<OffreDto> getAllOffres() {

        List<Offre> liste= offreRepository.findAll();
        List<OffreDto> listeDto = liste.stream()
                .map(offreUtil::Convert)
                .collect(Collectors.toList());

        return listeDto ;

    }


    @Override
    public OffreDto getOffreById(Long id) {
        Offre offre = offreRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "offre not found with id " + id));
        OffreDto   offredto =offreUtil.Convert(offre);
        return offredto;
    }
    //addOffre
    @Override
    @Transactional
    public void saveOffre(String offreJson, String authorizationHeader) {
        try {
            Offre offre = objectMapper.readValue(offreJson, Offre.class);
            offre.setDate(new Date());

            // Extract token from Bearer header
            String token = authorizationHeader.substring("Bearer ".length()).trim();

            // Get user details from token
            UserDetails userDetails = jwtTokenProvider.getUserDetailsFromToken(token);
            String email = userDetails.getUsername();

            MyUserDto userDto = userService.findByEmail(email);
            MyUser currentUser = UserUtil.convertToUser(userDto);
            offre.setUser(currentUser);

            Offre savedoffre = offreRepository.save(offre);
            savedoffre.setCategories(offre.getCategories());
        } catch (IOException e) {
            // Handle exception
        }
    }
    //deleteoffre
    @Override
    public void deleteOffre(Long id) {
        offreRepository.deleteById(id); }
    //updateoffre
    @Override
    public void  updateOffre(Long id, String offreJson) {
        Offre offreUpdate = new Offre();

        Offre offre = offreRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "offre not found with id " + id));
        try {
            offreUpdate = objectMapper.readValue(offreJson, Offre.class);
        } catch (JsonMappingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (JsonProcessingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        //offre.getCategories().clear();

        offre.setCategories(offreUpdate.getCategories());

        offre.setTitre(offreUpdate.getTitre());
        offre.setPrice(offreUpdate.getPrice());
        offre.setDescription(offreUpdate.getDescription());
        offre.setDetails(offreUpdate.getDetails());
        offre.setDate(new Date());
        offre.setAdresse(offreUpdate.getAdresse());





        final Offre updatedoffre = offreRepository.save(offre);
    }
    //getoffresByCategory
    @Override
    public List<OffreDto> getOffresByCategory(String nom) {
        List<Offre> offres = offreRepository.findAll();

        Set<Category> c = new  HashSet<>();
        List<OffreDto> offresCat = offres.stream()
                .filter(offre -> offre.getCategories().stream()
                        .anyMatch(cat -> cat.getName().equals(nom)))
                .map(offreUtil::Convert)
                .collect(Collectors.toList());

        return offresCat;


    }
}
