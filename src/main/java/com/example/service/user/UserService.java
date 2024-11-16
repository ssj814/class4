package com.example.service.user;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.dto.user.UserDTO;
import com.example.dto.user.ValidationUserDTO;
import com.example.entity.User;
import com.example.entity.User.Role;
import com.example.repository.UserRepository;
import com.example.util.jwt.JwtUtil;

import jakarta.validation.Valid;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository; // 사용자 레포지토리

    @Autowired
    private PasswordEncoder passwordEncoder; // 비밀번호 암호화
    
    @Autowired
    private JwtUtil jwtUtil; // JWT 유틸리티
    
    // 회원가입 메서드
    public User register(UserDTO userDto) {
        User user = new User();
        user.setUserid(userDto.getUserid());
        user.setUserpw(passwordEncoder.encode(userDto.getUserpw()));
        user.setRealusername(userDto.getRealusername());
        user.setEmailUsername(userDto.getEmailUsername());
        user.setEmailDomain(userDto.getEmailDomain());
        user.setBirthdate(userDto.getBirthdate());
        user.setGender(userDto.getGender());
        user.setTermsagreed(userDto.getTermsagreed());
        user.setPhone1(userDto.getPhone1());
        user.setPhone2(userDto.getPhone2());
        user.setPhone3(userDto.getPhone3());
        user.setPostalcode(userDto.getPostalcode());
        user.setStreetaddress(userDto.getStreetaddress());
        user.setDetailedaddress(userDto.getDetailedaddress());
        user.setNickname(userDto.getNickname());
        user.setProfilepicture(userDto.getProfilepicture());
        user.setIsactive(1); // 기본적으로 활성화된 계정
        user.setCreated(LocalDateTime.now());
        user.setUpdated(LocalDateTime.now());
        user.setLastlogin(null); // 초기 로그인 시간
        user.setRole(userDto.getRole()); // 역할 저장
        user.setEmail(userDto.getEmailUsername() + "@" + userDto.getEmailDomain());

        return userRepository.save(user); // 사용자 저장
    }

    // 로그인 메서드
    public User login(UserDTO userDto) { // UserDto를 인자로 받는 로그인 메서드
        User user = userRepository.findByUserid(userDto.getUserid())
                .orElseThrow(() -> new RuntimeException("Invalid credentials")); // 사용자 없음 예외 처리

        // 상태 로그 추가
        //logger.info("User status for {}: {}", user.getUserid(), user.getIsactive());
      System.out.println("이거시발 왜안됨 ?"+user.getIsactive());
        // 사용자 상태가 '0'인지 확인
        if (0==(user.getIsactive())) {
            //logger.warn("Login attempt for withdrawn account: {}", user.getUserid());
            throw new RuntimeException("Account has been withdrawn"); // 탈퇴된 계정은 로그인 불가
        }	

        // 입력한 비밀번호와 저장된 비밀번호 비교
        if (passwordEncoder.matches(userDto.getUserpw(), user.getUserpw())) {
            return user; // 로그인 성공 시 사용자 반환
        } else {
            throw new RuntimeException("Invalid credentials"); // 비밀번호 불일치 예외 처리
        }
    }
    
    // 아이디 중복 확인 메서드
    public boolean isUserIdAvailable(String userid) {
        Optional<User> user = userRepository.findByUserid(userid);
        //System.out.println("조회된 사용자: " + user);
        return user.isEmpty();  // 값이 없으면 true 반환, 중복이 없다는 의미
    }

    // 사용자 목록을 오름차순으로 반환하는 메서드 추가
    public List<User> findAllSortedByUsernumber() {
        // usernumber 기준으로 오름차순 정렬
        return userRepository.findAll(Sort.by(Sort.Order.asc("usernumber")));
    }

    // 전체 출력
    public List<User> findAll() {
        return userRepository.findAll();
    }
    
    // 사용자 삭제
    public void deleteUserById(int usernumber) {
        userRepository.deleteById(usernumber);  // usernumber로 사용자 삭제
    }
    
    // 역할 변경 메서드
    public void updateUserRole(int usernumber, Role newRole) {
        User user = userRepository.findById(usernumber)
                .orElseThrow(() -> new RuntimeException("User not found"));

        // 새로운 역할 설정
        user.setRole(newRole);
        
        // 변경된 사용자 저장
        userRepository.save(user);
    }


 // ValidationUserDTO를 사용한 회원가입 메서드
    public void registerWithValidation(@Valid ValidationUserDTO validationUserDTO) {
        // 비밀번호 확인 로직
        if (!validationUserDTO.getUserpw().equals(validationUserDTO.getUserpwConfirm())) {
            throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
        }

        // ValidationUserDTO를 User 엔티티로 변환
        User user = toUserEntity(validationUserDTO);

        // 사용자 저장
        userRepository.save(user);
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
    
 // ValidationUserDTO를 사용한 회원 정보 수정 메서드
    public void updateUserWithValidation(@Valid ValidationUserDTO validationUserDTO) {
        // 비밀번호 확인 로직 (비밀번호 수정 시에만 적용)
        if (validationUserDTO.getUserpw() != null && !validationUserDTO.getUserpw().isEmpty()) {
            if (!validationUserDTO.getUserpw().equals(validationUserDTO.getUserpwConfirm())) {
                throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
            }
        }

        // 기존 사용자 정보 조회
        User user = userRepository.findByUserid(validationUserDTO.getUserid())
                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));

        // 수정할 필드 업데이트
        if (validationUserDTO.getUserpw() != null && !validationUserDTO.getUserpw().isEmpty()) {
            user.setUserpw(passwordEncoder.encode(validationUserDTO.getUserpw()));
        }
        user.setEmailUsername(validationUserDTO.getEmailUsername());
        user.setEmailDomain(validationUserDTO.getEmailDomain());
        user.setPhone1(validationUserDTO.getPhone1());
        user.setPhone2(validationUserDTO.getPhone2());
        user.setPhone3(validationUserDTO.getPhone3());
        user.setStreetaddress(validationUserDTO.getStreetaddress());
        user.setDetailedaddress(validationUserDTO.getDetailedaddress());
        user.setUpdated(LocalDateTime.now());
        user.setGender(validationUserDTO.getGender());
        user.setProfilepicture(validationUserDTO.getProfilePictureUrl());
        // 변경된 사용자 정보 저장
        userRepository.save(user);
    }

    // ValidationUserDTO를 User 엔티티로 변환하는 메서드
    private User toUserEntity(ValidationUserDTO validationUserDTO) {
        User user = new User();
        user.setUserid(validationUserDTO.getUserid());
        user.setUserpw(passwordEncoder.encode(validationUserDTO.getUserpw())); // 비밀번호 암호화
        user.setRealusername(validationUserDTO.getRealusername());
        user.setEmailUsername(validationUserDTO.getEmailUsername());
        user.setEmailDomain(validationUserDTO.getEmailDomain());
        user.setPhone1(validationUserDTO.getPhone1());
        user.setPhone2(validationUserDTO.getPhone2());
        user.setPhone3(validationUserDTO.getPhone3());
        user.setPostalcode(validationUserDTO.getPostalcode());
        user.setStreetaddress(validationUserDTO.getStreetaddress());
        user.setDetailedaddress(validationUserDTO.getDetailedaddress());
        user.setTermsagreed(validationUserDTO.getTermsagreed());
        
        // Role 처리 (필요에 따라 DTO에서 받은 값을 사용하거나 기본값 설정)
        if (validationUserDTO.getRole() != null) {
            user.setRole(validationUserDTO.getRole());
        } else {
            user.setRole(User.Role.USER);  // 기본값 설정
        }
        if (validationUserDTO.getProfilePictureUrl() != null && !validationUserDTO.getProfilePictureUrl().isEmpty()) {
            user.setProfilepicture(validationUserDTO.getProfilePictureUrl());
        }
        // 기타 필드 설정
        user.setIsactive(1); // 기본적으로 활성화된 계정
        user.setCreated(LocalDateTime.now());
        user.setUpdated(LocalDateTime.now());
        user.setLastlogin(null); // 초기 로그인 시간
        user.setEmail(validationUserDTO.getEmailUsername() + "@" + validationUserDTO.getEmailDomain());
        user.setGender(validationUserDTO.getGender());
        
        return user;
    }
    
 // 특정 사용자 조회
    public User getUserById(int usernumber) {
        return userRepository.findById(usernumber)
                .orElseThrow(() -> new IllegalArgumentException("Invalid user number: " + usernumber));
    }

    // 사용자 정보 수정
    public User updateUser(int usernumber, ValidationUserDTO validationUserDTO) {
        User existingUser = userRepository.findById(usernumber)
                .orElseThrow(() -> new IllegalArgumentException("Invalid user number: " + usernumber));
        
        existingUser.setUserid(validationUserDTO.getUserid());
        existingUser.setUserpw(passwordEncoder.encode(validationUserDTO.getUserpw())); // 비밀번호 암호화
        existingUser.setRealusername(validationUserDTO.getRealusername());
        existingUser.setEmailUsername(validationUserDTO.getEmailUsername());
        existingUser.setEmailDomain(validationUserDTO.getEmailDomain());
        existingUser.setPhone1(validationUserDTO.getPhone1());
        existingUser.setPhone2(validationUserDTO.getPhone2());
        existingUser.setPhone3(validationUserDTO.getPhone3());
        existingUser.setPostalcode(validationUserDTO.getPostalcode());
        existingUser.setStreetaddress(validationUserDTO.getStreetaddress());
        existingUser.setDetailedaddress(validationUserDTO.getDetailedaddress());
        existingUser.setTermsagreed(validationUserDTO.getTermsagreed());
        
        // Role 처리 (필요에 따라 DTO에서 받은 값을 사용하거나 기본값 설정)
        if (validationUserDTO.getRole() != null) {
        	existingUser.setRole(validationUserDTO.getRole());
        } else {
        	existingUser.setRole(User.Role.USER);  // 기본값 설정
        }
        if (validationUserDTO.getProfilePictureUrl() != null && !validationUserDTO.getProfilePictureUrl().isEmpty()) {
        	existingUser.setProfilepicture(validationUserDTO.getProfilePictureUrl());
        }
        // 기타 필드 설정
        existingUser.setIsactive(1); // 기본적으로 활성화된 계정
        existingUser.setUpdated(LocalDateTime.now());
        existingUser.setLastlogin(null); // 초기 로그인 시간
        existingUser.setEmail(validationUserDTO.getEmailUsername() + "@" + validationUserDTO.getEmailDomain());
        existingUser.setGender(validationUserDTO.getGender());
        
        return userRepository.save(existingUser);  // 수정된 사용자 정보를 저장
    }
}