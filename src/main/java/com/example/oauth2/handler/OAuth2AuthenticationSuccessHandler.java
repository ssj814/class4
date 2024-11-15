package com.example.oauth2.handler;

import static com.example.oauth2.HttpCookieOAuth2AuthorizationRequestRepository.MODE_PARAM_COOKIE_NAME;
import static com.example.oauth2.HttpCookieOAuth2AuthorizationRequestRepository.REDIRECT_URI_PARAM_COOKIE_NAME;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
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

@Slf4j
@RequiredArgsConstructor
@Component
public class OAuth2AuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    private final HttpCookieOAuth2AuthorizationRequestRepository httpCookieOAuth2AuthorizationRequestRepository;
    private final OAuth2UserUnlinkManager oAuth2UserUnlinkManager;
    private final UserRepository userRepository;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException {

        String targetUrl = determineTargetUrl(request, response, authentication);

        if (response.isCommitted()) {
            logger.debug("Response has already been committed. Unable to redirect to " + targetUrl);
            return;
        }

        // 인증 속성 클리어
        clearAuthenticationAttributes(request, response);
        getRedirectStrategy().sendRedirect(request, response, targetUrl);
    }

    protected String determineTargetUrl(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) {

        Optional<String> redirectUri = CookieUtils.getCookie(request, REDIRECT_URI_PARAM_COOKIE_NAME)
                .map(Cookie::getValue);
        String targetUrl = redirectUri.orElse(getDefaultTargetUrl());

        String mode = CookieUtils.getCookie(request, MODE_PARAM_COOKIE_NAME)
                .map(Cookie::getValue)
                .orElse("");

        OAuth2UserPrincipal principal = getOAuth2UserPrincipal(authentication);

        if (principal == null) {
            return UriComponentsBuilder.fromUriString(targetUrl)
                    .queryParam("error", "Login failed")
                    .build().toUriString();
        }

        if ("login".equalsIgnoreCase(mode)) {
            String email = principal.getUserInfo().getEmail();
            String name = principal.getUserInfo().getName();
            String nickname = principal.getUserInfo().getNickname();
            String accessToken = "test_access_token"; 
            String refreshToken = "test_refresh_token"; 

            Optional<User> existingUser = userRepository.findByEmail(email);
            User user;
            if (existingUser.isPresent()) {
                user = existingUser.get();
                user.setLastlogin(LocalDateTime.now());
                userRepository.save(user);
            } else {
                user = User.builder()
                        .userid(email)
                        .realusername(name)
                        .nickname(nickname)
                        .email(email)
                        .role(User.Role.USER)  // 기본 role은 USER로 설정
                        .created(LocalDateTime.now())
                        .isactive(1)
                        .build();
                userRepository.save(user);
            }

            // user의 role에 맞는 권한을 설정
            List<SimpleGrantedAuthority> authorities = new ArrayList<>();
            if (user.getRole() == User.Role.ADMIN) {
                authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
            } else if (user.getRole() == User.Role.TRAINER) {
                authorities.add(new SimpleGrantedAuthority("ROLE_TRAINER"));
            } else {
                authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
            }

            log.info("email={}, name={}, nickname={}, accessToken={}", email, name, nickname, accessToken);

            // SecurityContext에 사용자 정보 설정
            OAuth2UserPrincipal updatedPrincipal = new OAuth2UserPrincipal(principal.getUserInfo());
            Authentication updatedAuthentication = new OAuth2AuthenticationToken(updatedPrincipal, authorities, refreshToken);
            SecurityContextHolder.getContext().setAuthentication(updatedAuthentication);

            return UriComponentsBuilder.fromUriString(targetUrl)
                    .queryParam("access_token", accessToken)
                    .queryParam("refresh_token", refreshToken)
                    .build().toUriString();
        } else if ("unlink".equalsIgnoreCase(mode)) {
            String accessToken = principal.getUserInfo().getAccessToken();
            OAuth2Provider provider = principal.getUserInfo().getProvider();

            oAuth2UserUnlinkManager.unlink(provider, accessToken);

            return UriComponentsBuilder.fromUriString(targetUrl).build().toUriString();
        }

        return UriComponentsBuilder.fromUriString(targetUrl)
                .queryParam("error", "Login failed")
                .build().toUriString();
    }

    private OAuth2UserPrincipal getOAuth2UserPrincipal(Authentication authentication) {
        Object principal = authentication.getPrincipal();
        if (principal instanceof OAuth2UserPrincipal) {
            return (OAuth2UserPrincipal) principal;
        }
        return null;
    }

    protected void clearAuthenticationAttributes(HttpServletRequest request, HttpServletResponse response) {
        super.clearAuthenticationAttributes(request);
        httpCookieOAuth2AuthorizationRequestRepository.removeAuthorizationRequestCookies(request, response);
    }
}