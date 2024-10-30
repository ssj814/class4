package com.example.entity;

import java.time.LocalDateTime;

import com.example.entity.User.Role;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// Users 엔티티 클래스
@Entity
@Table(name = "users") // DB에서 users 테이블과 매핑
@Builder //가독성 및 불변 객체로 사용하기 위해
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
	//Id컬럼 지정, DB서버의 키 값을 설정
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // ID 자동 증가 설정
	//@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_seq_gen")
    //@SequenceGenerator(name = "user_seq_gen", sequenceName = "users_seq", allocationSize = 1)
	private int usernumber;
	
	@Column(unique = true) // 사용자 ID는 유일해야 함
    private String userid;
    
	private String userpw; // 암호화된 비밀번호
    private String realusername; // 사용자의 실명
    private String emailusername; // 이메일 사용자 이름
    private String emaildomain; // 이메일 도메인
    private String birthdate; // 생년월일
    private String gender; // 성별
    
    private int emailverified; // 이메일 인증 여부 (0 또는 1)
    private int termsagreed; // 약관 동의 여부 (0 또는 1)
    
    private String phone1; // 전화번호 1
    private String phone2; // 전화번호 2
    private String phone3; // 전화번호 3
    
    private String postalcode; // 우편번호
    private String streetaddress; // 도로명 주소
    private String detailedaddress; // 상세 주소
    private String nickname; // 사용자 별명
    private String profilepicture; // 프로필 사진 URL
    //private String gradename; // 회원 등급
    private Integer mileage; // 포인트
    private String socialprovider; // 소셜 로그인 제공자
    private String ipaddress; // 사용자 접속 IP
    private int isactive; // 계정 활성 여부 (0 또는 1)

    private LocalDateTime created; // 생성일자
    private LocalDateTime updated; // 수정일자
    private LocalDateTime lastlogin; // 마지막 로그인 시간
    
    private String email;
    private String provider;
    private String providerid;

    @Enumerated(EnumType.STRING) // Enum 타입으로 역할을 정의
    private Role role;

    // 사용자 역할 정의
    public enum Role {
        USER, // 일반 사용자
        ADMIN, // 관리자
        TRAINER // 트레이너
    }
    
    //마이바티스의 경우 컬럼 디폴트로 대체 가능
    @PrePersist // 해당 초기값 DB에 저장
    public void prePersist(){
        if(this.mileage == null) {
        	this.mileage = 0;
        }
        if(this.role == null) {
        	this.role = Role.USER;
        }
    }
    
    
}
