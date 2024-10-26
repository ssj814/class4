package com.example.oauth2.handler;

import com.example.oauth2.util.CookieUtils;
import com.example.oauth2.HttpCookieOAuth2AuthorizationRequestRepository;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.IOException;

import static com.example.oauth2.HttpCookieOAuth2AuthorizationRequestRepository.REDIRECT_URI_PARAM_COOKIE_NAME;

 //OAuth2 인증 실패 시의 처리 로직을 구현하는 클래스입니다.
 //사용자가 OAuth2 인증에 실패했을 때, 특정 URL로 리다이렉트합니다.
@RequiredArgsConstructor // final 필드를 가진 생성자를 자동 생성합니다.
@Component // 이 클래스를 Spring의 컴포넌트로 등록합니다.
public class OAuth2AuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {

    // OAuth2 인증 요청을 쿠키에서 관리하는 리포지토리
    private final HttpCookieOAuth2AuthorizationRequestRepository httpCookieOAuth2AuthorizationRequestRepository;

    
     //인증 실패 시 호출되는 메서드입니다.
     //@param request HTTP 요청 객체
     //@param response HTTP 응답 객체
     //@param exception 인증 실패에 대한 예외 정보
     //@throws IOException 입출력 예외 발생 가능
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException {

        // 쿠키에서 리다이렉트 URL을 가져오고, 없으면 기본 URL("/")로 설정합니다.
        String targetUrl = CookieUtils.getCookie(request, REDIRECT_URI_PARAM_COOKIE_NAME)
                .map(Cookie::getValue) // 쿠키에서 값을 추출합니다.
                .orElse(("/")); // 쿠키가 없으면 기본 경로로 설정합니다.

        // URL에 오류 메시지를 쿼리 파라미터로 추가합니다.
        targetUrl = UriComponentsBuilder.fromUriString(targetUrl)
                .queryParam("error", exception.getLocalizedMessage()) // 예외 메시지를 쿼리 파라미터로 추가합니다.
                .build().toUriString(); // 최종 URL 문자열로 변환합니다.

        // 요청 쿠키에서 인증 요청 관련 쿠키를 제거합니다.
        httpCookieOAuth2AuthorizationRequestRepository.removeAuthorizationRequestCookies(request, response);

        // 클라이언트를 지정된 URL로 리다이렉트합니다.
        getRedirectStrategy().sendRedirect(request, response, targetUrl);
    }
}