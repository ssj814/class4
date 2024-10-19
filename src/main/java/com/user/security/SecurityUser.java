package com.user.security;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import com.user.dto.UserDto;

public class SecurityUser extends User{

	private static final long serialVersionUID = 1L; //객체의 직렬화 및 역직렬화 과정에서 발생할 수 있는 호환성 문제를 줄여주는 역할
//{noop}은 암호화 사용안함을 의미함
//	public SecurityUser(Member member) {
//		super(member.getId(), "{noop}"+member.getPassword(), AuthorityUtils.createAuthorityList(member.getRole().toString()));
//	}
	
	//암호화 사용
	public SecurityUser(UserDto userdto) {
		super(userdto.getUserid(), userdto.getUserpw(), AuthorityUtils.createAuthorityList("ROLE_" + userdto.getRole()));
		// 시큐리티에서 ROLE_**로 데이터 값을 사용하기때문에 "ROLE_" + userdto.getRole()로 설정해야함
	}

}
