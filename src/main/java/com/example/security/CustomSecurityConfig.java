package com.example.security;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import lombok.RequiredArgsConstructor;

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

    	.requestMatchers("/trainer/**").hasRole("TRAINER")
    	.requestMatchers("/user/**").authenticated() // /user/** 경로는 인증된 경우 접근 

    	//추후 트레이너 페이지 추가 시
    	.requestMatchers("/oracle/**").permitAll() // 오라클 콘솔 접근 허용
    	.anyRequest().permitAll() // 나머지 요청 허용
    	 )
        .formLogin(form -> form
            .loginPage("/user/loginForm") // 로그인 페이지 설정. UserController의 loginForm 경로로 변경
            .usernameParameter("userid") // submit할 아디이
            .passwordParameter("userpw") // submit할 비밀번호
            .defaultSuccessUrl("/", true) // 로그인 성공 후 이동할 URL
            .failureUrl("/loginDenied") // 로그인 실패 시 이동할 URL
            .permitAll() // 모든 사용자에게 로그인 페이지 허용
    	)
        .logout(logout -> logout
        		//.logoutSuccessHandler(OAuth2LogoutHandler) //오스관련 로그아웃핸들러
                .invalidateHttpSession(true) // 세션 무효화
                .deleteCookies("JSESSIONID") // 필요한 쿠키 삭제
                .logoutSuccessUrl("/") // 로그아웃 성공 후 리다이렉션할 페이지 설정
                .permitAll()
        )
        // status code 핸들링
        .exceptionHandling(exception -> exception
                .accessDeniedPage("/loginCancel") // 접근 거부 시 이동할 페이지
        )
        //.sessionManagement(sessions -> // 세션 관리 설정
        //sessions.sessionCreationPolicy(SessionCreationPolicy.STATELESS) // 상태 없는 세션 관리
        //)
        .csrf(csrf -> csrf.disable()) // test를 위해 CSRF 보호 비활성화
    	.cors(cors -> cors.disable()); // test를 위해 CORS 보호 비활성화
		
    	
    return http.build(); // SecurityFilterChain 빌드
}

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(); // 설정된 HttpSecurity 객체를 기반으로 SecurityFilterChain 생성
    }
}
