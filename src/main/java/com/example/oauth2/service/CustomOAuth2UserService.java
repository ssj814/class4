package com.example.oauth2.service;

import com.example.oauth2.exception.OAuth2AuthenticationProcessingException;
import com.example.oauth2.user.OAuth2UserInfo;
import com.example.oauth2.user.OAuth2UserInfoFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

//커스텀 OAuth2 사용자 서비스 클래스
//기본 OAuth2 사용자 서비스를 확장하여 사용자 정보를 처리
@RequiredArgsConstructor // final 필드를 가진 생성자를 자동 생성
@Service // 이 클래스를 Spring의 서비스로 등록
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    //OAuth2 사용자 정보를 로드하는 메서드입니다.
    //@param oAuth2UserRequest OAuth2 사용자 요청 객체
    //@return OAuth2User 객체
    //@throws OAuth2AuthenticationException 인증 예외 발생 가능
    @Override
    public OAuth2User loadUser(OAuth2UserRequest oAuth2UserRequest) throws OAuth2AuthenticationException {

        // 기본 사용자 정보 로드
        OAuth2User oAuth2User = super.loadUser(oAuth2UserRequest);

        try {
            // 사용자 정보를 추가로 처리
            return processOAuth2User(oAuth2UserRequest, oAuth2User);
        } catch (AuthenticationException ex) {
            // 인증 예외가 발생하면 그대로 던짐
            throw ex;
        } catch (Exception ex) {
            // 기타 예외는 InternalAuthenticationServiceException으로 변환하여 던짐
            // 이 예외는 OAuth2AuthenticationFailureHandler를 트리거
            throw new InternalAuthenticationServiceException(ex.getMessage(), ex.getCause());
        }
    }

    //OAuth2 사용자 정보를 추가로 처리하는 메서드입니다.
    //@param userRequest OAuth2 사용자 요청 객체
    //@param oAuth2User OAuth2User 객체
    //@return 처리된 OAuth2User 객체
    private OAuth2User processOAuth2User(OAuth2UserRequest userRequest, OAuth2User oAuth2User) {

        // OAuth2 클라이언트 등록 ID 가져오기
        String registrationId = userRequest.getClientRegistration()
                .getRegistrationId();

        // 액세스 토큰 값 가져오기
        String accessToken = userRequest.getAccessToken().getTokenValue();

        // OAuth2UserInfoFactory를 통해 사용자 정보 객체 생성
        OAuth2UserInfo oAuth2UserInfo = OAuth2UserInfoFactory.getOAuth2UserInfo(registrationId,
                accessToken,
                oAuth2User.getAttributes());

        // 사용자 정보 필드 값 검증
        if (!StringUtils.hasText(oAuth2UserInfo.getEmail())) {
            // 이메일 정보가 없으면 예외 발생
            throw new OAuth2AuthenticationProcessingException("Email not found from OAuth2 provider");
        }

        // 검증된 사용자 정보를 기반으로 OAuth2UserPrincipal 객체 생성
        return new OAuth2UserPrincipal(oAuth2UserInfo);
    }
}