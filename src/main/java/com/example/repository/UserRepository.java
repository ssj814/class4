package com.example.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.entity.User;

@Repository // 사용자 데이터를 처리하는 JPA 레포지토리 인터페이스
public interface UserRepository  extends JpaRepository<User, Integer>{
//JpaUserRepository를 이용하여 Spring에서 구현 해줌
//구현을 위한 코드는 개발자가 아닌 Spring에서 처리함
//User 클래스를 Entity로 지정하고 , Id/Key의 데이터 타입을 Integer로 정함
	
	Optional<User> findByUserid(String userid);// 아이디로 사용자 조회
	
}
