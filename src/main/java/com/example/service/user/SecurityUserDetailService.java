package com.example.service.user;

import java.util.Collection;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.dto.user.UserDto;
import com.example.entity.User;
import com.example.repository.UserRepository;
import com.example.security.SecurityUser;

import jakarta.servlet.http.HttpSession;

@Service
public class SecurityUserDetailService  implements UserDetailsService {
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	HttpSession session;

	@Override
	public UserDetails loadUserByUsername(String userid) throws UsernameNotFoundException {
	    // 사용자 ID를 받아 회원 정보 조회
	    System.out.println("UserDetailService: username===" + userid);

	    // 사용자가 없는 경우 예외 처리
	    User user = userRepository.findByUserid(userid)
	            .orElseThrow(() -> new UsernameNotFoundException(userid + " 사용자없음"));
	    System.out.println("UserDetailService: user===" + user);

	    // 사용자 상태가 'WITHDRAWN'인지 확인하여 로그인 차단
	    if ("WITHDRAWN".equals(user.getStatus())) {
	        throw new UsernameNotFoundException("탈퇴된 계정입니다. 로그인할 수 없습니다.");
	    }

	    // User 객체를 UserDto로 변환
	    UserDto userdto = new UserDto();
	    userdto.setUserid(user.getUserid());
	    userdto.setUserpw(user.getUserpw());
	    userdto.setRole(user.getRole()); // 필요한 경우
	    userdto.setUsernumber(user.getUsernumber());

	    // 사용자가 있을 때 SecurityUser 객체 생성 및 반환
	    return new SecurityUser(userdto);
	}

}
