package com.example.oauth2.user;

import com.example.oauth2.exception.OAuth2AuthenticationProcessingException;

import java.util.Map;

/**
 * OAuth2UserInfo 객체를 생성하는 팩토리 클래스
 * 이 클래스는 다양한 OAuth2 제공자에 따라 사용자 정보를 처리하기 위한 객체를 생성
 */
public class OAuth2UserInfoFactory {

    /**
     * 주어진 등록 ID에 따라 적절한 OAuth2UserInfo 구현체를 생성
     *
     * @param registrationId OAuth2 제공자의 등록 ID
     * @param accessToken    OAuth2 액세스 토큰
     * @param attributes     사용자 속성을 담고 있는 맵
     * @return 해당 제공자의 OAuth2UserInfo 객체
     * @throws OAuth2AuthenticationProcessingException 지원되지 않는 제공자일 경우 예외 발생
     */
    public static OAuth2UserInfo getOAuth2UserInfo(String registrationId,
                                                   String accessToken,
                                                   Map<String, Object> attributes) {
        // Google 제공자의 경우 GoogleOAuth2UserInfo 객체 생성
        if (OAuth2Provider.GOOGLE.getRegistrationId().equals(registrationId)) {
            return new GoogleOAuth2UserInfo(accessToken, attributes);
        } 
        // Naver 제공자의 경우 NaverOAuth2UserInfo 객체 생성
        else if (OAuth2Provider.NAVER.getRegistrationId().equals(registrationId)) {
            return new NaverOAuth2UserInfo(accessToken, attributes);
        } 
        // Kakao 제공자의 경우 KakaoOAuth2UserInfo 객체 생성
        else if (OAuth2Provider.KAKAO.getRegistrationId().equals(registrationId)) {
            return new KakaoOAuth2UserInfo(accessToken, attributes);
        } 
        // 지원되지 않는 제공자일 경우 예외 발생
        else {
            throw new OAuth2AuthenticationProcessingException("Login with " + registrationId + " is not supported");
        }
    }
}