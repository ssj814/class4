package com.example.service.user;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.dto.user.UserDto;
import com.example.entity.User;
import com.example.repository.UserRepository;
import com.example.util.jwt.JwtUtil;

@Service
public class UserService {
    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

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
        user.setEmail(userDto.getEmailusername() + "@" + userDto.getEmaildomain());
        user.setProvider(null);
        user.setProviderid(null);

        return userRepository.save(user); // 사용자 저장
    }

    // 로그인 메서드
    public User login(UserDto userDto) { // UserDto를 인자로 받는 로그인 메서드
        User user = userRepository.findByUserid(userDto.getUserid())
                .orElseThrow(() -> new RuntimeException("Invalid credentials")); // 사용자 없음 예외 처리

        // 상태 로그 추가
        logger.info("User status for {}: {}", user.getUserid(), user.getIsactive());

        // 사용자 상태가 'WITHDRAWN'인지 확인
        if (0==(user.getIsactive())) {
            logger.warn("Login attempt for withdrawn account: {}", user.getUserid());
            throw new RuntimeException("Account has been withdrawn"); // 탈퇴된 계정은 로그인 불가
        }

        // 입력한 비밀번호와 저장된 비밀번호 비교
        if (passwordEncoder.matches(userDto.getUserpw(), user.getUserpw())) {
            return user; // 로그인 성공 시 사용자 반환
        } else {
            throw new RuntimeException("Invalid credentials"); // 비밀번호 불일치 예외 처리
        }
    }

    // 전체 출력
    public List<User> findAll() {
        return userRepository.findAll();
    }
    
    // 사용자 삭제
    public void deleteUserById(int usernumber) {
        userRepository.deleteById(usernumber);  // usernumber로 사용자 삭제
    }

    // 사용자 비활성화 (탈퇴 처리)
    public void deactivateUser(String userid) {
        Optional<User> optionalUser = userRepository.findByUserid(userid);
        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            user.setIsactive(0); 
            user.setUpdated(LocalDateTime.now());
            userRepository.save(user);
        }
    }
}
