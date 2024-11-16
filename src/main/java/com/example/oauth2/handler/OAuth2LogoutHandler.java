package com.example.oauth2.handler;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

import com.example.oauth2.util.CookieUtils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class OAuth2LogoutHandler implements LogoutSuccessHandler {

    private static final String REDIRECT_URI_PARAM_COOKIE_NAME = "redirect_uri";

    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, 
                                org.springframework.security.core.Authentication authentication) throws java.io.IOException {

        // 로그아웃 성공 후 SecurityContext에서 인증 정보 제거
        SecurityContextHolder.clearContext();

        // 세션 무효화
        request.getSession().invalidate();

        // "redirect_uri" 쿠키에서 리디렉션 URI를 가져옴
        String redirectUri = CookieUtils.getCookie(request, REDIRECT_URI_PARAM_COOKIE_NAME)
                .map(Cookie::getValue)
                .orElse("/app"); // 기본 리디렉션 URL은 "/" (홈 페이지)

        // 로그아웃 후 리디렉션 URL 생성
        String targetUrl = UriComponentsBuilder.fromUriString(redirectUri)
                .queryParam("message", "Successfully logged out")
                .build().toUriString();

        // 리디렉션
        response.sendRedirect(targetUrl);
    }
}