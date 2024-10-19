package com.example.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;


@Configuration
@EnableWebSecurity
public class CustomSecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    	System.out.println("CustomSecurityConfig 로딩됨>>>>>>>>>");
    	http
    	//페이지 권한 설정
    	.authorizeHttpRequests(authorize -> authorize
    	.requestMatchers("/admin/**").hasRole("ADMIN")
    	//.requestMatchers("/trainer/**").hasRole("TRAINER")
    	//추후 트레이너 페이지 추가 시
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
        		.logoutSuccessUrl("/") // 로그아웃 성공 후 이동 url
        		.invalidateHttpSession(true) // 세션 무효화
        		.deleteCookies("JSESSIONID") // JSESSIONID 쿠키 삭제
		)
        // status code 핸들링
        .exceptionHandling(exception -> exception
                .accessDeniedPage("/loginCancel") // 접근 거부 시 이동할 페이지
        )
        .csrf(csrf -> csrf.disable()) // test를 위해 CSRF 보호 비활성화
    	.cors(cors -> cors.disable()); // test를 위해 CORS 보호 비활성화
		
    	
    return http.build(); // SecurityFilterChain 빌드
}

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(); // BCryptPasswordEncoder 빈 정의
    }
}
