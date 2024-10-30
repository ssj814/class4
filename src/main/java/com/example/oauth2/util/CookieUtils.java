package com.example.oauth2.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.util.SerializationUtils;

import java.util.Base64;
import java.util.Optional;

public class CookieUtils {

    /**
     * 주어진 요청에서 특정 이름의 쿠키를 검색합니다.
     *
     * @param request HTTP 요청 객체
     * @param name    검색할 쿠키의 이름
     * @return 쿠키가 존재하면 Optional로 감싸서 반환, 없으면 Optional.empty() 반환
     */
    public static Optional<Cookie> getCookie(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies(); // 요청의 모든 쿠키를 가져옴
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                // 쿠키의 이름이 일치하는 경우
                if (cookie.getName().equals(name)) {
                    return Optional.of(cookie); // 쿠키를 Optional로 반환
                }
            }
        }
        return Optional.empty(); // 쿠키가 없는 경우
    }

    /**
     * 새로운 쿠키를 추가합니다.
     *
     * @param response HTTP 응답 객체
     * @param name     추가할 쿠키의 이름
     * @param value    쿠키의 값
     * @param maxAge   쿠키의 유효 기간 (초 단위)
     */
    public static void addCookie(HttpServletResponse response, String name, String value, int maxAge) {
        Cookie cookie = new Cookie(name, value); // 새로운 쿠키 객체 생성
        cookie.setPath("/"); // 쿠키의 경로 설정
        cookie.setHttpOnly(true); // HTTP 전용 설정 (JavaScript에서 접근 불가)
        cookie.setMaxAge(maxAge); // 쿠키의 유효 기간 설정
        response.addCookie(cookie); // 응답에 쿠키 추가
    }

    /**
     * 지정된 이름의 쿠키를 삭제합니다.
     *
     * @param request  HTTP 요청 객체
     * @param response HTTP 응답 객체
     * @param name     삭제할 쿠키의 이름
     */
    public static void deleteCookie(HttpServletRequest request, HttpServletResponse response, String name) {
        Cookie[] cookies = request.getCookies(); // 요청의 모든 쿠키를 가져옴
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                // 쿠키의 이름이 일치하는 경우
                if (cookie.getName().equals(name)) {
                    cookie.setValue(""); // 쿠키 값을 비워서 삭제
                    cookie.setPath("/"); // 쿠키의 경로 설정
                    cookie.setMaxAge(0); // 쿠키의 유효 기간을 0으로 설정하여 삭제
                    response.addCookie(cookie); // 응답에 쿠키 추가
                }
            }
        }
    }

    /**
     * 주어진 객체를 직렬화하여 Base64 인코딩된 문자열로 변환합니다.
     *
     * @param object 직렬화할 객체
     * @return Base64로 인코딩된 문자열
     */
    public static String serialize(Object object) {
        return Base64.getUrlEncoder()
                .encodeToString(SerializationUtils.serialize(object)); // 객체를 직렬화하고 Base64 인코딩
    }

    /**
     * 주어진 쿠키의 값을 Base64 디코딩하고, 역직렬화하여 객체로 변환합니다.
     *
     * @param cookie 쿠키 객체
     * @param cls    변환할 객체의 클래스
     * @param <T>    반환할 객체의 타입
     * @return 역직렬화된 객체
     */
    public static <T> T deserialize(Cookie cookie, Class<T> cls) {
        return cls.cast(SerializationUtils.deserialize(
                Base64.getUrlDecoder().decode(cookie.getValue()))); // 쿠키 값을 디코딩하고 역직렬화
    }
}