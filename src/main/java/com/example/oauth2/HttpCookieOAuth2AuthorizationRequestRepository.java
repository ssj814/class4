package com.example.oauth2;

import com.example.oauth2.util.CookieUtils;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.oauth2.client.web.AuthorizationRequestRepository;
import org.springframework.security.oauth2.core.endpoint.OAuth2AuthorizationRequest;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

/**
 * OAuth2 인증 요청을 쿠키에 저장하고 로드하는 리포지토리 클래스
 * 이 클래스는 OAuth2AuthorizationRequestRepository 인터페이스를 구현
 */
@RequiredArgsConstructor
@Component
public class HttpCookieOAuth2AuthorizationRequestRepository
        implements AuthorizationRequestRepository<OAuth2AuthorizationRequest> {

    // OAuth2 인증 요청을 저장할 쿠키 이름 상수
    public static final String OAUTH2_AUTHORIZATION_REQUEST_COOKIE_NAME = "oauth2_auth_request";
    // 리다이렉트 URI를 저장할 쿠키 이름 상수
    public static final String REDIRECT_URI_PARAM_COOKIE_NAME = "redirect_uri";
    // 모드를 저장할 쿠키 이름 상수
    public static final String MODE_PARAM_COOKIE_NAME = "mode";
    // 쿠키의 유효 시간(초 단위)
    private static final int COOKIE_EXPIRE_SECONDS = 180;

    /**
     * HTTP 요청에서 OAuth2AuthorizationRequest를 로드
     *
     * @param request HTTP 요청 객체
     * @return 로드된 OAuth2AuthorizationRequest 객체 또는 null
     */
    @Override
    public OAuth2AuthorizationRequest loadAuthorizationRequest(HttpServletRequest request) {
        // 쿠키에서 OAuth2AuthorizationRequest를 역직렬화하여 반환
        return CookieUtils.getCookie(request, OAUTH2_AUTHORIZATION_REQUEST_COOKIE_NAME)
                .map(cookie -> CookieUtils.deserialize(cookie, OAuth2AuthorizationRequest.class))
                .orElse(null); // 쿠키가 없으면 null 반환
    }

    /**
     * OAuth2AuthorizationRequest를 쿠키에 저장
     *
     * @param authorizationRequest 저장할 OAuth2AuthorizationRequest 객체
     * @param request              HTTP 요청 객체
     * @param response             HTTP 응답 객체
     */
    @Override
    public void saveAuthorizationRequest(OAuth2AuthorizationRequest authorizationRequest, HttpServletRequest request,
                                         HttpServletResponse response) {
        // 요청이 null인 경우, 기존 쿠키 삭제
        if (authorizationRequest == null) {
            CookieUtils.deleteCookie(request, response, OAUTH2_AUTHORIZATION_REQUEST_COOKIE_NAME);
            CookieUtils.deleteCookie(request, response, REDIRECT_URI_PARAM_COOKIE_NAME);
            CookieUtils.deleteCookie(request, response, MODE_PARAM_COOKIE_NAME);
            return; // 메서드 종료
        }

        // OAuth2AuthorizationRequest를 쿠키에 직렬화하여 저장
        CookieUtils.addCookie(response,
                OAUTH2_AUTHORIZATION_REQUEST_COOKIE_NAME,
                CookieUtils.serialize(authorizationRequest),
                COOKIE_EXPIRE_SECONDS);

        // 요청 파라미터에서 리다이렉트 URI 가져오기
        String redirectUriAfterLogin = request.getParameter(REDIRECT_URI_PARAM_COOKIE_NAME);
        if (StringUtils.hasText(redirectUriAfterLogin)) {
            // 리다이렉트 URI가 존재하는 경우 쿠키에 저장
            CookieUtils.addCookie(response,
                    REDIRECT_URI_PARAM_COOKIE_NAME,
                    redirectUriAfterLogin,
                    COOKIE_EXPIRE_SECONDS);
        }

        // 요청 파라미터에서 모드 가져오기
        String mode = request.getParameter(MODE_PARAM_COOKIE_NAME);
        if (StringUtils.hasText(mode)) {
            // 모드가 존재하는 경우 쿠키에 저장
            CookieUtils.addCookie(response,
                    MODE_PARAM_COOKIE_NAME,
                    mode,
                    COOKIE_EXPIRE_SECONDS);
        }
    }

    /**
     * HTTP 요청에서 OAuth2AuthorizationRequest를 제거
     *
     * @param request  HTTP 요청 객체
     * @param response HTTP 응답 객체
     * @return 제거된 OAuth2AuthorizationRequest 객체
     */
    @Override
    public OAuth2AuthorizationRequest removeAuthorizationRequest(HttpServletRequest request,
                                                                 HttpServletResponse response) {
        // 요청에서 OAuth2AuthorizationRequest를 로드하여 반환
        return this.loadAuthorizationRequest(request);
    }

    /**
     * 모든 OAuth2 관련 쿠키를 제거합니다.
     *
     * @param request  HTTP 요청 객체
     * @param response HTTP 응답 객체
     */
    public void removeAuthorizationRequestCookies(HttpServletRequest request, HttpServletResponse response) {
        // 관련 쿠키들을 삭제
        CookieUtils.deleteCookie(request, response, OAUTH2_AUTHORIZATION_REQUEST_COOKIE_NAME);
        CookieUtils.deleteCookie(request, response, REDIRECT_URI_PARAM_COOKIE_NAME);
        CookieUtils.deleteCookie(request, response, MODE_PARAM_COOKIE_NAME);
    }
}