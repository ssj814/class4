package com.example.dto.user;

import java.time.LocalDateTime;

import com.example.entity.User.Role;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO {
	private int usernumber; // 필수, 사용자 번호
	private String realusername; // 필수, 실명
    private String userid; // 필수, 사용자 ID
    private String userpw; // 필수, 비밀번호
    private String userpwConfirm; // 비밀번호 확인
    private String emailUsername; // 필수, 이메일 사용자 이름
    private String emailDomain; // 필수, 이메일 도메인
    private String birthdate; // 필수, 생년월일
    private String gender; // 필수, 성별
    private int termsagreed; //약관동의
    
    private String phone1; // 전화번호 1
    private String phone2; // 전화번호 2
    private String phone3; // 전화번호 3
    private String postalcode; // 우편번호
    private String streetaddress; // 도로명 주소
    private String detailedaddress; // 상세 주소
    private String nickname; // 선택 입력, 별명
    private String profilepicture; // 프로필 사진 URL
    //private String gradename; // 회원 등급
    private int isactive; // 계정 활성 여부
    private LocalDateTime created; // 생성일자
    private LocalDateTime updated; // 수정일자
    private LocalDateTime lastlogin;
    
    private String email;
    
    private Role role;
}
