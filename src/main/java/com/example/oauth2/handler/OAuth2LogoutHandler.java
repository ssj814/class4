package com.example.oauth2.handler;

import java.io.IOException;
import java.net.URLEncoder;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;

import com.example.oauth2.service.OAuth2UserPrincipal;
import com.example.oauth2.util.CookieUtils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Component
public class OAuth2LogoutHandler implements LogoutSuccessHandler {

    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, 
                                Authentication authentication) throws IOException {
        
        // 인증 정보에서 OAuth2 사용자 정보를 가져옴
        OAuth2UserPrincipal principal = getOAuth2UserPrincipal(authentication);
        
        // 사용자가 null인 경우 로그아웃 실패 처리
        if (principal == null) {
            response.sendRedirect(getDefaultRedirectUrl());
            return;
        }

        // 로그아웃 처리 로직 (예: 세션 정리, 쿠키 삭제 등)
        clearAuthenticationAttributes(request, response);

        // 로그아웃 성공 로깅
        log.info("User {} has logged out successfully", principal.getUsername());

        // 로그아웃 후 리다이렉트할 URL 설정
        String targetUrl = getDefaultRedirectUrl();
        String encodedTargetUrl = URLEncoder.encode(targetUrl, "UTF-8");

        // 각 서비스의 로그아웃 URL 설정
        String naverLogoutUrl = "https://nid.naver.com/nidlogin.logout?returnUrl=" + encodedTargetUrl;
        String googleLogoutUrl = "https://accounts.google.com/Logout?continue=" + encodedTargetUrl;

        // 여기서 원하는 로그아웃 URL을 선택할 수 있습니다.
        // 예를 들어, 주석을 해제하고 아래 라인 중 하나를 선택합니다.
         response.sendRedirect(naverLogoutUrl);
        // response.sendRedirect(googleLogoutUrl);
        //response.sendRedirect(kakaoLogoutUrl); // 카카오 로그아웃으로 기본 설정
    }

    // 인증 정보를 통해 OAuth2 사용자 정보를 반환
    private OAuth2UserPrincipal getOAuth2UserPrincipal(Authentication authentication) {
        Object principal = authentication.getPrincipal();
        if (principal instanceof OAuth2UserPrincipal) {
            return (OAuth2UserPrincipal) principal;
        }
        return null; // 아니면 null 반환
    }

    // 인증 속성을 클리어하는 메서드입니다.
    private void clearAuthenticationAttributes(HttpServletRequest request, HttpServletResponse response) {
        CookieUtils.removeCookie(request, response, "YOUR_COOKIE_NAME"); // 적절한 쿠키 이름으로 수정
        // 필요한 경우 추가적인 세션 정보 정리 로직 추가
    }

    // 기본 리다이렉트 URL 반환
    private String getDefaultRedirectUrl() {
        return "http://localhost:8090/app/"; // 로그아웃 후 리다이렉트할 기본 URL
    }
}