package com.example.oauth2.user;

import java.util.Map;

/**
 * Google OAuth2 사용자 정보를 담고 있는 클래스
 * OAuth2UserInfo 인터페이스를 구현하여 Google에서 반환된 사용자 정보를 처리
 */
public class GoogleOAuth2UserInfo implements OAuth2UserInfo {

    // Google에서 받은 사용자 정보를 저장하는 맵
    private final Map<String, Object> attributes;
    
    // OAuth2 액세스 토큰
    private final String accessToken;
    
    // 사용자 ID
    private final String id;
    
    // 사용자 이메일
    private final String email;
    
    // 사용자 전체 이름
    private final String name;
    
    // 사용자 이름
    private final String firstName;
    
    // 사용자 성
    private final String lastName;
    
    // 사용자 별명 (현재는 null로 설정)
    private final String nickName;
    
    // 사용자 프로필 이미지 URL
    private final String profileImageUrl;

    /**
     * 생성자
     *
     * @param accessToken OAuth2 액세스 토큰
     * @param attributes Google에서 반환된 사용자 정보
     */
    public GoogleOAuth2UserInfo(String accessToken, Map<String, Object> attributes) {
        this.accessToken = accessToken; // 액세스 토큰을 필드에 저장
        this.attributes = attributes; // 사용자 정보를 필드에 저장
        this.id = (String) attributes.get("sub"); // 사용자 ID
        this.email = (String) attributes.get("email"); // 사용자 이메일
        this.name = (String) attributes.get("name"); // 사용자 전체 이름
        this.firstName = (String) attributes.get("given_name"); // 사용자 이름
        this.lastName = (String) attributes.get("family_name"); // 사용자 성
        this.nickName = null; // 별명은 현재 null로 설정
        this.profileImageUrl = (String) attributes.get("picture"); // 프로필 이미지 URL
    }

    /**
     * OAuth2 제공자를 반환합니다.
     *
     * @return OAuth2Provider.GOOGLE
     */
    @Override
    public OAuth2Provider getProvider() {
        return OAuth2Provider.GOOGLE; // Google을 제공자로 설정
    }

    /**
     * 액세스 토큰을 반환
     *
     * @return OAuth2 액세스 토큰
     */
    @Override
    public String getAccessToken() {
        return accessToken; // 액세스 토큰 반환
    }

    /**
     * 사용자 속성을 반환
     *
     * @return 사용자 속성을 담고 있는 맵
     */
    @Override
    public Map<String, Object> getAttributes() {
        return attributes; // 사용자 속성 반환
    }

    /**
     * 사용자 ID를 반환
     *
     * @return 사용자 ID
     */
    @Override
    public String getId() {
        return id; // 사용자 ID 반환
    }

    /**
     * 사용자 이메일을 반환
     *
     * @return 사용자 이메일
     */
    @Override
    public String getEmail() {
        return email; // 사용자 이메일 반환
    }

    /**
     * 사용자 이름을 반환
     *
     * @return 사용자 전체 이름
     */
    @Override
    public String getName() {
        return name; // 사용자 전체 이름 반환
    }

    /**
     * 사용자 이름(이름)을 반환
     *
     * @return 사용자 이름
     */
    @Override
    public String getFirstName() {
        return firstName; // 사용자 이름 반환
    }

    /**
     * 사용자 성을 반환
     *
     * @return 사용자 성
     */
    @Override
    public String getLastName() {
        return lastName; // 사용자 성 반환
    }

    /**
     * 사용자 별명을 반환
     *
     * @return 사용자 별명 (현재는 null)
     */
    @Override
    public String getNickname() {
        return nickName; // 별명 반환 (현재 null)
    }

    /**
     * 사용자 프로필 이미지 URL을 반환
     *
     * @return 프로필 이미지 URL
     */
    @Override
    public String getProfileImageUrl() {
        return profileImageUrl; // 프로필 이미지 URL 반환
    }
}
