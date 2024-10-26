package com.example.oauth2.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

/**
 * Google OAuth2 사용자 연결 해제를 처리하는 클래스
 * 이 클래스는 Google OAuth2 API를 사용하여 사용자 인증을 해제
 */
@RequiredArgsConstructor // 필드를 final로 선언한 후 생성자 자동 생성
@Component // Spring의 컴포넌트로 등록
public class GoogleOAuth2UserUnlink implements OAuth2UserUnlink {

    // Google OAuth2 API의 사용자 연결 해제 엔드포인트 URL
    private static final String URL = "https://oauth2.googleapis.com/revoke";
    
    // REST 요청을 보내기 위한 RestTemplate 객체
    private final RestTemplate restTemplate;

    /**
     * 사용자 연결 해제 메서드
     *
     * @param accessToken OAuth2 액세스 토큰
     */
    @Override
    public void unlink(String accessToken) {
        // 파라미터를 담기 위한 MultiValueMap 생성
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        
        // 액세스 토큰을 파라미터에 추가
        params.add("token", accessToken);
        
        // Google OAuth2 API에 POST 요청을 보내고 응답을 String으로 받음
        restTemplate.postForObject(URL, params, String.class);
    }
}