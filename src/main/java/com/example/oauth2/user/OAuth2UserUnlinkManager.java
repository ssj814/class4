package com.example.oauth2.user;

import com.example.oauth2.exception.OAuth2AuthenticationProcessingException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * OAuth2 사용자 연결 해제 관리 클래스
 * 이 클래스는 다양한 OAuth2 제공자에 대한 사용자 연결 해제를 처리
 */
@RequiredArgsConstructor // final 필드를 초기화하는 생성자를 자동 생성
@Component // Spring의 컴포넌트로 등록
public class OAuth2UserUnlinkManager {

    // Google 제공자에 대한 사용자 연결 해제 처리 클래스
    private final GoogleOAuth2UserUnlink googleOAuth2UserUnlink;
    // Kakao 제공자에 대한 사용자 연결 해제 처리 클래스
    private final KakaoOAuth2UserUnlink kakaoOAuth2UserUnlink;
    // Naver 제공자에 대한 사용자 연결 해제 처리 클래스
    private final NaverOAuth2UserUnlink naverOAuth2UserUnlink;

    /**
     * 주어진 제공자와 액세스 토큰을 사용하여 사용자 연결을 해제
     *
     * @param provider    OAuth2Provider 열거형, 연결 해제를 수행할 제공자
     * @param accessToken OAuth2 액세스 토큰, 해제할 사용자의 인증 정보
     * @throws OAuth2AuthenticationProcessingException 지원되지 않는 제공자일 경우 예외 발생
     */
    public void unlink(OAuth2Provider provider, String accessToken) {
        // Google 제공자의 경우 연결 해제 처리
        if (OAuth2Provider.GOOGLE.equals(provider)) {
            googleOAuth2UserUnlink.unlink(accessToken);
        } 
        // Naver 제공자의 경우 연결 해제 처리
        else if (OAuth2Provider.NAVER.equals(provider)) {
            naverOAuth2UserUnlink.unlink(accessToken);
        } 
        // Kakao 제공자의 경우 연결 해제 처리
        else if (OAuth2Provider.KAKAO.equals(provider)) {
            kakaoOAuth2UserUnlink.unlink(accessToken);
        } 
        // 지원되지 않는 제공자의 경우 예외 발생
        else {
            throw new OAuth2AuthenticationProcessingException(
                    "Unlink with " + provider.getRegistrationId() + " is not supported");
        }
    }
}