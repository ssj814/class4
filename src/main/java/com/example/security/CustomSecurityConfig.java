package com.example.security;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.example.oauth2.HttpCookieOAuth2AuthorizationRequestRepository;
import com.example.oauth2.handler.OAuth2AuthenticationFailureHandler;
import com.example.oauth2.handler.OAuth2AuthenticationSuccessHandler;
import com.example.oauth2.handler.OAuth2LogoutHandler;
import com.example.oauth2.service.CustomOAuth2UserService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Configuration
@EnableWebSecurity
public class CustomSecurityConfig {
	
	private final CustomOAuth2UserService customOAuth2UserService;
    private final OAuth2AuthenticationSuccessHandler oAuth2AuthenticationSuccessHandler;
    private final OAuth2AuthenticationFailureHandler oAuth2AuthenticationFailureHandler;
    private final OAuth2LogoutHandler OAuth2LogoutHandler;
    private final HttpCookieOAuth2AuthorizationRequestRepository httpCookieOAuth2AuthorizationRequestRepository;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    	System.out.println("CustomSecurityConfig 로딩됨>>>>>>>>>");
    	
    	http
    	//페이지 권한 설정
    	.authorizeHttpRequests(authorize -> authorize
    	.requestMatchers("/admin/**").hasRole("ADMIN")
    	.requestMatchers("/trainer/**").hasRole("TRAINER")
    	.requestMatchers("/user/**").authenticated() // /user/** 경로는 인증된 경우 접근 

    	//추후 트레이너 페이지 추가 시
    	.requestMatchers("/oracle/**").permitAll() // 오라클 콘솔 접근 허용
    	.anyRequest().permitAll() // 나머지 요청 허용
    	 )
        .formLogin(form -> form
            .loginPage("/login") // 로그인 페이지 설정
            .usernameParameter("userid") // submit할 아디이
            .passwordParameter("userpw") // submit할 비밀번호
            .defaultSuccessUrl("/", true) // 로그인 성공 후 이동할 URL
            .failureUrl("/loginDenied") // 로그인 실패 시 이동할 URL
            .permitAll() // 모든 사용자에게 로그인 페이지 허용
    	)
        .logout(logout -> logout
        		.logoutSuccessHandler(OAuth2LogoutHandler)
                .invalidateHttpSession(true) // 세션 무효화
                .deleteCookies("JSESSIONID", "YOUR_COOKIE_NAME", "REDIRECT_URI_PARAM_COOKIE_NAME", "MODE_PARAM_COOKIE_NAME") // 필요한 쿠키 삭제
                .permitAll()
        )
        .oauth2Login(configure -> // OAuth2 로그인 설정
        	configure
        		.loginPage("/user/loginForm") //커스텀로그인 페이지로 이동
    			.authorizationEndpoint(config -> // 인증 요청 엔드포인트 설정
    				config.authorizationRequestRepository(httpCookieOAuth2AuthorizationRequestRepository)) // OAuth2 요청 저장소 설정
    			.userInfoEndpoint(config -> // 사용자 정보 엔드포인트 설정
    				config.userService(customOAuth2UserService)) // 사용자 정보 처리 서비스 설정
				.successHandler(oAuth2AuthenticationSuccessHandler) // OAuth2 인증 성공 시 핸들러
				.failureHandler(oAuth2AuthenticationFailureHandler) // OAuth2 인증 실패 시 핸들러
        )
        // status code 핸들링
        .exceptionHandling(exception -> exception
                .accessDeniedPage("/loginCancel") // 접근 거부 시 이동할 페이지
        )
        //.sessionManagement(sessions -> // 세션 관리 설정
        //sessions.sessionCreationPolicy(SessionCreationPolicy.STATELESS) // 상태 없는 세션 관리
        //)
        .csrf(csrf -> csrf.disable()); // test를 위해 CSRF 보호 비활성화
    	//.cors(cors -> cors.disable()); // test를 위해 CORS 보호 비활성화
        // Content Security Policy 설정 추가
		
    	
    return http.build(); // SecurityFilterChain 빌드
}

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(); // 설정된 HttpSecurity 객체를 기반으로 SecurityFilterChain 생성
    }
}
