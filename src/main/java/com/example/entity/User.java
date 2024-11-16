package com.example.entity;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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

    @Column(name = "USERID", unique =true)
    private String userid;  // 사용자 ID

    @Column(name = "USERPW")
    private String userpw; // 암호화된 비밀번호

    @Column(name = "REALUSERNAME")
    private String realusername; // 사용자의 실명

    @Column(name = "EMAILUSERNAME")
    private String emailUsername; // 이메일 사용자 이름

    @Column(name = "EMAILDOMAIN")
    private String emailDomain; // 이메일 도메인

    @Column(name = "BIRTHDATE")
    private String birthdate; // 생년월일

    @Column(name = "GENDER")
    private String gender; // 성별

    @Column(name = "TERMSAGREED")
    private String termsagreed; // 약관 동의 여부 (0 또는 1)

    @Column(name = "PHONE1")
    private String phone1; // 전화번호 1

    @Column(name = "PHONE2")
    private String phone2; // 전화번호 2

    @Column(name = "PHONE3")
    private String phone3; // 전화번호 3

    @Column(name = "POSTALCODE")
    private String postalcode; // 우편번호

    @Column(name = "STREETADDRESS")
    private String streetaddress; // 도로명 주소

    @Column(name = "DETAILEDADDRESS")
    private String detailedaddress; // 상세 주소

    @Column(name = "NICKNAME")
    private String nickname; // 사용자 별명

    @Column(name = "PROFILEPICTURE")
    private String profilepicture; // 프로필 사진 URL

    @Column(name = "ISACTIVE")
    private int isactive; // 계정 활성 여부 (0 또는 1)

    @Column(name = "CREATED")
    private LocalDateTime created; // 생성일자

    @Column(name = "UPDATED")
    private LocalDateTime updated; // 수정일자

    @Column(name = "LASTLOGIN")
    private LocalDateTime lastlogin; // 마지막 로그인 시간

    @Column(name = "EMAIL")
    private String email;

    @Enumerated(EnumType.STRING) // Enum 타입으로 역할을 정의
    private Role role;

    // 사용자 역할 정의
    public enum Role {
        USER, // 일반 사용자
        ADMIN, // 관리자
        TRAINER // 트레이너
    }
    
 // LocalDateTime을 String으로 변환하는 메서드
    public String getFormattedCreated() {
        return formatLocalDateTime(created);
    }

    public String getFormattedUpdated() {
        return formatLocalDateTime(updated);
    }

    public String getFormattedLastLogin() {
        return formatLocalDateTime(lastlogin);
    }

    // LocalDateTime을 String으로 포맷팅
    private String formatLocalDateTime(LocalDateTime dateTime) {
        if (dateTime != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            return dateTime.format(formatter);
        }
        return "";
    }

    //마이바티스의 경우 컬럼 디폴트로 대체 가능
    @PrePersist // 해당 초기값 DB에 저장
    public void prePersist(){
    	
        if(this.role == null) {
        	this.role = Role.USER;
        }
        if (this.created == null) {
            this.created = LocalDateTime.now();
        }
        if (this.updated == null) {
            this.updated = LocalDateTime.now();
        }
        if (this.lastlogin == null) {
            this.lastlogin = LocalDateTime.now();
        }
    }
    
    
    
    
}
