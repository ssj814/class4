package com.example.oauth2.handler;

import static com.example.oauth2.HttpCookieOAuth2AuthorizationRequestRepository.MODE_PARAM_COOKIE_NAME;
import static com.example.oauth2.HttpCookieOAuth2AuthorizationRequestRepository.REDIRECT_URI_PARAM_COOKIE_NAME;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

import com.example.entity.User;
import com.example.oauth2.HttpCookieOAuth2AuthorizationRequestRepository;
import com.example.oauth2.service.OAuth2UserPrincipal;
import com.example.oauth2.user.OAuth2Provider;
import com.example.oauth2.user.OAuth2UserUnlinkManager;
import com.example.oauth2.util.CookieUtils;
import com.example.repository.UserRepository;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

//OAuth2 인증 성공 시의 처리 로직을 구현하는 클래스
//사용자가 OAuth2 인증에 성공했을 때, 특정 URL로 리다이렉트
@Slf4j // Slf4j 로깅을 위한 어노테이션
@RequiredArgsConstructor // final 필드를 가진 생성자를 자동 생성
@Component // 이 클래스를 Spring의 컴포넌트로 등록
public class OAuth2AuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    // OAuth2 인증 요청을 쿠키에서 관리하는 리포지토리
    private final HttpCookieOAuth2AuthorizationRequestRepository httpCookieOAuth2AuthorizationRequestRepository;
    
    // OAuth2 사용자 연결 관리를 위한 매니저
    private final OAuth2UserUnlinkManager oAuth2UserUnlinkManager;
    
    private final UserRepository userRepository; // UserRepository 추가

    //인증 성공 시 호출되는 메서드
    //@param request HTTP 요청 객체
    //@param response HTTP 응답 객체
    //@param authentication 인증 정보 객체
    //@throws IOException 입출력 예외 발생 가능
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException {

        String targetUrl;

        // 리다이렉트할 URL 결정
        targetUrl = determineTargetUrl(request, response, authentication);

        // 응답이 이미 커밋된 경우 리다이렉트할 수 없으므로 종료
        if (response.isCommitted()) {
            logger.debug("Response has already been committed. Unable to redirect to " + targetUrl);
            return;
        }

        // 인증 속성을 클리어하고 리다이렉트 실행
        clearAuthenticationAttributes(request, response);
        getRedirectStrategy().sendRedirect(request, response, targetUrl);
    }

    //리다이렉트할 URL을 결정하는 메서드입니다.
    //@param request HTTP 요청 객체
    //@param response HTTP 응답 객체
    //@param authentication 인증 정보 객체
    //@return 결정된 리다이렉트 URL
    protected String determineTargetUrl(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) {

        // 쿠키에서 리다이렉트 URL을 가져옴
        Optional<String> redirectUri = CookieUtils.getCookie(request, REDIRECT_URI_PARAM_COOKIE_NAME)
                .map(Cookie::getValue);

        // 가져온 리다이렉트 URL이 없으면 기본 URL 사용
        String targetUrl = redirectUri.orElse(getDefaultTargetUrl());

        // 쿠키에서 모드 파라미터를 가져옴
        String mode = CookieUtils.getCookie(request, MODE_PARAM_COOKIE_NAME)
                .map(Cookie::getValue)
                .orElse("");

        // 인증 정보에서 OAuth2 사용자 정보를 가져옴
        OAuth2UserPrincipal principal = getOAuth2UserPrincipal(authentication);

        // 사용자가 null인 경우 로그인 실패 처리
        if (principal == null) {
            return UriComponentsBuilder.fromUriString(targetUrl)
                    .queryParam("error", "Login failed")
                    .build().toUriString();
        }

        // 로그인 모드일 때 처리
        if ("login".equalsIgnoreCase(mode)) {
            // TODO: DB 저장
            // TODO: 액세스 토큰, 리프레시 토큰 발급
            // TODO: 리프레시 토큰 DB 저장
        	
        	 // OAuth2 사용자 정보를 가져옴
            String email = principal.getUserInfo().getEmail();
            String name = principal.getUserInfo().getName();
            String nickname = principal.getUserInfo().getNickname();
            String accessToken = "test_access_token"; // 실제 액세스 토큰 발급 로직 필요
            String refreshToken = "test_refresh_token"; // 실제 리프레시 토큰 발급 로직 필요

            // 사용자 정보 저장
            Optional<User> existingUser = userRepository.findByEmail(email); // 이메일로 사용자 검색
            if (existingUser.isPresent()) {
                // 기존 사용자 업데이트 (필요한 필드만 업데이트)
                User user = existingUser.get();
                user.setLastlogin(LocalDateTime.now()); // 마지막 로그인 시간 업데이트
                userRepository.save(user); // 업데이트된 사용자 정보 저장
            } else {
                // 새로운 사용자 생성
                User newUser = User.builder()
                        .userid(email) // 사용자 ID는 이메일로 설정
                        .realusername(name)
                        .nickname(nickname)
                        .email(email)
                        .role(User.Role.USER) // 기본 역할 설정
                        .created(LocalDateTime.now()) // 생성일자 설정
                        .isactive(1) // 활성화 상태
                        .build();

                userRepository.save(newUser); // 새 사용자 정보 저장
            }
            
            // 사용자 정보 로깅
            log.info("email={}, name={}, nickname={}, accessToken={}", principal.getUserInfo().getEmail(),
                    principal.getUserInfo().getName(),
                    principal.getUserInfo().getNickname(),
                    principal.getUserInfo().getAccessToken()
            );

            // 사용자 정보 로깅
            log.info("email={}, name={}, nickname={}, accessToken={}", email, name, nickname, accessToken);

            // 리다이렉트 URL에 액세스 토큰과 리프레시 토큰을 추가
            return UriComponentsBuilder.fromUriString(targetUrl)
                    .queryParam("access_token", accessToken)
                    .queryParam("refresh_token", refreshToken)
                    .build().toUriString();

        // 언링크 모드일 때 처리
        } else if ("unlink".equalsIgnoreCase(mode)) {
            String accessToken = principal.getUserInfo().getAccessToken();
            OAuth2Provider provider = principal.getUserInfo().getProvider();

            // TODO: DB 삭제
            // TODO: 리프레시 토큰 삭제
            oAuth2UserUnlinkManager.unlink(provider, accessToken); // 사용자 언링크 처리

            // 리다이렉트 URL 반환
            return UriComponentsBuilder.fromUriString(targetUrl)
                    .build().toUriString();
        }

        // 기본적으로 로그인 실패 처리
        return UriComponentsBuilder.fromUriString(targetUrl)
                .queryParam("error", "Login failed")
                .build().toUriString();
    }

    //인증 정보를 통해 OAuth2 사용자 정보를 반환
    //@param authentication 인증 정보 객체
    //@return OAuth2UserPrincipal 객체 또는 null
    private OAuth2UserPrincipal getOAuth2UserPrincipal(Authentication authentication) {
        Object principal = authentication.getPrincipal();

        // 인증 주체가 OAuth2UserPrincipal인 경우 캐스팅하여 반환
        if (principal instanceof OAuth2UserPrincipal) {
            return (OAuth2UserPrincipal) principal;
        }
        return null; // 아니면 null 반환
    }

    //인증 속성을 클리어하는 메서드입니다.
    //@param request HTTP 요청 객체
    //@param response HTTP 응답 객체
    protected void clearAuthenticationAttributes(HttpServletRequest request, HttpServletResponse response) {
        super.clearAuthenticationAttributes(request); // 상위 클래스의 메서드 호출
        httpCookieOAuth2AuthorizationRequestRepository.removeAuthorizationRequestCookies(request, response); // 쿠키 제거
    }
}