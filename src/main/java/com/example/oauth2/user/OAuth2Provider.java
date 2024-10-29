package com.example.oauth2.user;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * OAuth2 제공자를 나타내는 열거형
 * 각 제공자는 인증 요청 시 사용되는 고유한 식별자를 가짐
 */
@Getter // 모든 필드에 대한 getter 메서드를 자동 생성
@RequiredArgsConstructor // final 필드를 초기화하는 생성자를 자동 생성
public enum OAuth2Provider {
    GOOGLE("google"),   // Google OAuth2 제공자
    FACEBOOK("facebook"), // Facebook OAuth2 제공자
    GITHUB("github"),   // GitHub OAuth2 제공자
    NAVER("naver"),     // Naver OAuth2 제공자
    KAKAO("kakao");     // Kakao OAuth2 제공자

    // OAuth2 제공자의 등록 ID
    private final String registrationId;

    /**
     * 제공자의 등록 ID를 반환
     *
     * @return 등록 ID
     */
    public String getRegistrationId() {
        return registrationId; // 제공자의 등록 ID 반환
    }
}