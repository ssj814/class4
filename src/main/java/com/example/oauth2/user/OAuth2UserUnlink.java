package com.example.oauth2.user;

/**
 * OAuth2 사용자 연결 해제를 위한 인터페이스
 * 이 인터페이스는 다양한 OAuth2 제공자에 대한 사용자 인증 해제 기능을 정의
 */
public interface OAuth2UserUnlink {
    
    /**
     * 주어진 액세스 토큰을 사용하여 사용자 연결을 해제
     *
     * @param accessToken OAuth2 액세스 토큰
     */
    void unlink(String accessToken);
}