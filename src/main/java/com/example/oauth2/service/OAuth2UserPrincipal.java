package com.example.oauth2.service;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import com.example.oauth2.user.OAuth2UserInfo;

/**
 * OAuth2User와 UserDetails 인터페이스를 구현한 사용자 프린시펄 클래스
 * OAuth2 인증을 통해 로드된 사용자 정보를 기반으로 사용자 상세 정보를 제공
 */
public class OAuth2UserPrincipal implements OAuth2User, UserDetails {

    // OAuth2 사용자 정보를 담고 있는 객체
    private final OAuth2UserInfo userInfo;

    /**
     * 생성자
     *
     * @param userInfo OAuth2 사용자 정보 객체
     */
    public OAuth2UserPrincipal(OAuth2UserInfo userInfo) {
        this.userInfo = userInfo; // 주입된 사용자 정보를 필드에 저장
    }

	/**
     * 비밀번호를 반환하는 메서드
     * OAuth2 사용자 인증에서는 비밀번호가 없으므로 null을 반환
     *
     * @return null
     */
    @Override
    public String getPassword() {
        return null; // OAuth2 사용자이므로 비밀번호는 필요 없음
    }

    /**
     * 사용자 이름(이메일)을 반환하는 메서드
     *
     * @return 사용자의 이메일
     */
    @Override
    public String getUsername() {
        return userInfo.getEmail(); // OAuth2 사용자 정보에서 이메일을 반환
    }

    /**
     * 계정이 만료되지 않았는지를 확인하는 메서드
     *
     * @return 항상 true
     */
    @Override
    public boolean isAccountNonExpired() {
        return true; // OAuth2 사용자 계정은 만료되지 않음
    }

    /**
     * 계정이 잠겨있지 않았는지를 확인하는 메서드
     *
     * @return 항상 true
     */
    @Override
    public boolean isAccountNonLocked() {
        return true; // OAuth2 사용자 계정은 잠겨있지 않음
    }

    /**
     * 자격 증명이 만료되지 않았는지를 확인하는 메서드
     *
     * @return 항상 true
     */
    @Override
    public boolean isCredentialsNonExpired() {
        return true; // OAuth2 사용자 자격 증명은 만료되지 않음
    }

    /**
     * 계정이 활성화되어 있는지를 확인하는 메서드
     *
     * @return 항상 true
     */
    @Override
    public boolean isEnabled() {
        return true; // OAuth2 사용자 계정은 활성화됨
    }

    /**
     * 사용자의 추가 속성을 반환하는 메서드
     *
     * @return 사용자 정보에서 가져온 속성 맵
     */
    @Override
    public Map<String, Object> getAttributes() {
        return userInfo.getAttributes(); // OAuth2 사용자 정보에서 속성 반환
    }

    /**
     * 사용자 권한을 반환하는 메서드
     *
     * @return 기본적으로 user권한
     */
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER"));
    }

    /**
     * 사용자의 이름을 반환하는 메서드
     * 여기서는 사용자의 이메일을 반환
     *
     * @return 사용자의 이메일
     */
    @Override
    public String getName() {
        return userInfo.getEmail(); // 사용자의 이메일을 반환
    }

    /**
     * OAuth2 사용자 정보를 반환하는 메서드
     *
     * @return OAuth2UserInfo 객체
     */
    public OAuth2UserInfo getUserInfo() {
        return userInfo; // 저장된 사용자 정보 반환
    }
}
