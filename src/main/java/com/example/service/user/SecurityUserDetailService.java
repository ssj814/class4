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

import com.example.dto.user.UserDTO;
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
		//사용자id를 매개변수로 받아서 회원정보조회, 조회후 UserDetail객체로 리턴 시킴
		System.out.println("UserDetailServie: username==="+ userid);
		
		//사용자가 없는 경우
		User user = userRepository.findByUserid(userid)
                .orElseThrow(() -> new UsernameNotFoundException(userid + " 사용자없음"));
		if (user.getIsactive() == 0) {
			throw new RuntimeException("Account has been withdrawn"); // 비활성화된 계정 로그인 불가
		}
		System.out.println("UserDetailServie: dto==="+ user);
		
		 // User 객체를 UserDto로 변환
	    UserDTO userdto = new UserDTO();
	    userdto.setUserid(user.getUserid());
	    userdto.setUserpw(user.getUserpw());
	    userdto.setRole(user.getRole()); // 필요한 경우
	    userdto.setUsernumber(user.getUsernumber());
	    
	    
	    //사용자가 있을 때
		return new SecurityUser(userdto);  //SecurityUser 객체 생성 리턴 
	}

}
