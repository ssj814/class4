package com.example.util.jwt;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

// JWT 토큰을 생성하고 검증하는 유틸리티 클래스
@Component
public class JwtUtil {
    private final String SECRET_KEY = "your_secret_key"; // JWT 비밀 키
    private final long EXPIRATION_TIME = 1000 * 60 * 60; // 1시간 유효한 토큰

    // 사용자 이름으로 JWT 토큰 생성
    public String generateToken(String userid) {
        Map<String, Object> claims = new HashMap<>();
        return createToken(claims, userid);
    }

    // JWT 토큰 생성
    private String createToken(Map<String, Object> claims, String subject) {
        return Jwts.builder()
                .setClaims(claims)
                .setSubject(subject) // 주제 (사용자 이름)
                .setIssuedAt(new Date(System.currentTimeMillis())) // 발급 일자
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME)) // 만료 일자
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY) // 서명 알고리즘
                .compact(); // 토큰 생성
    }

    // JWT 토큰 유효성 검증
    public boolean validateToken(String token, String userid) {
        final String extractedUserid = extractUserid(token); // 토큰에서 사용자 이름 추출
        return (extractedUserid.equals(userid) && !isTokenExpired(token)); // 유효성 체크
    }

    // 토큰에서 사용자 이름 추출
    public String extractUserid(String token) {
        return extractAllClaims(token).getSubject(); // 주제 반환
    }

    // 모든 클레임 추출
    private Claims extractAllClaims(String token) {
        return Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(token).getBody(); // 클레임 파싱
    }

    // 토큰 만료 여부 체크
    private boolean isTokenExpired(String token) {
        return extractAllClaims(token).getExpiration().before(new Date()); // 만료 확인
    }
}
