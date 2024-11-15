package com.example.oauth2.user;

import java.util.Map;

//OAuth2 사용자 정보를 추상화하는 인터페이스
//이 인터페이스는 다양한 OAuth2 제공자로부터 받은 사용자 정보를 처리하기 위한 계약을 정의
public interface OAuth2UserInfo {

    OAuth2Provider getProvider();

    String getAccessToken();

    Map<String, Object> getAttributes();

    String getId();

    String getEmail();

    String getName();

    String getFirstName();

    String getLastName();

    String getNickname();

    String getProfileImageUrl();
    

}