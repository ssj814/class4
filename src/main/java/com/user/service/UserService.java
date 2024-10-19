package com.user.service;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.user.dto.UserDto;
import com.user.entity.User;
import com.user.repository.UserRepository;
import com.user.util.JwtUtil;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository; // 사용자 레포지토리

    @Autowired
    private PasswordEncoder passwordEncoder; // 비밀번호 암호화
    
    @Autowired
    private JwtUtil jwtUtil; // JWT 유틸리티
    
    // 회원가입 메서드
    public User register(UserDto userDto) {
        User user = new User();
        user.setUserid(userDto.getUserid());
        user.setUserpw(passwordEncoder.encode(userDto.getUserpw()));
        user.setRealusername(userDto.getRealusername());
        user.setEmailusername(userDto.getEmailusername());
        user.setEmaildomain(userDto.getEmaildomain());
        user.setBirthdate(userDto.getBirthdate());
        user.setGender(userDto.getGender());
        user.setEmailverified(userDto.getEmailverified());
        user.setTermsagreed(userDto.getTermsagreed());
        user.setPhone1(userDto.getPhone1());
        user.setPhone2(userDto.getPhone2());
        user.setPhone3(userDto.getPhone3());
        user.setPostalcode(userDto.getPostalcode());
        user.setStreetaddress(userDto.getStreetaddress());
        user.setDetailedaddress(userDto.getDetailedaddress());
        user.setNickname(userDto.getNickname());
        user.setProfilepicture(userDto.getProfilepicture());
        user.setMileage(userDto.getMileage());
        user.setSocialprovider(userDto.getSocialprovider());
        user.setIpaddress(userDto.getIpaddress());
        user.setIsactive(1); // 기본적으로 활성화된 계정
        user.setCreated(LocalDateTime.now());
        user.setUpdated(LocalDateTime.now());
        user.setLastlogin(null); // 초기 로그인 시간
        user.setRole(userDto.getRole()); // 역할 저장

        return userRepository.save(user); // 사용자 저장
    }

    // 로그인 메서드
    public User login(UserDto userDto) { // UserDto를 인자로 받는 로그인 메서드
        User user = userRepository.findByUserid(userDto.getUserid())
                .orElseThrow(() -> new RuntimeException("Invalid credentials")); // 사용자 없음 예외 처리

        // 입력한 비밀번호와 저장된 비밀번호 비교
        if (passwordEncoder.matches(userDto.getUserpw(), user.getUserpw())) {
            return user; // 로그인 성공 시 사용자 반환
        } else {
            throw new RuntimeException("Invalid credentials"); // 비밀번호 불일치 예외 처리
        }
    }
}