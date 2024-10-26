package com.example.oauth2.exception;

import org.springframework.security.core.AuthenticationException;


//OAuth2 인증 처리 중 발생하는 예외를 정의하는 클래스
public class OAuth2AuthenticationProcessingException extends AuthenticationException {

    //생성자: 예외 메시지를 받아서 상위 클래스의 생성자를 호출합니다.
    //@param msg 예외에 대한 설명 메시지
    public OAuth2AuthenticationProcessingException(String msg) {
        super(msg); // 상위 클래스인 AuthenticationException의 생성자를 호출하여 메시지를 전달합니다.
    }
}