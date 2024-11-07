package com.example.dto.user;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ValidationUserDTO {
    
    @NotBlank(message = "아이디는 필수 입력값입니다.")
    @Pattern(regexp = "^[a-z0-9]{4,20}$", message = "아이디는 영문 소문자와 숫자 4~20자리여야 합니다.")
    private String userid;
    
    @NotBlank(message = "비밀번호는 필수 입력값입니다.")
    @Pattern(regexp="(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\\W)(?=\\S+$).{8,20}", 
            message = "비밀번호는 영문 대소문자, 숫자, 특수기호가 포함된 8~20자여야 합니다.")
    private String userpw;
    
    @NotBlank(message = "비밀번호 확인은 필수 입력값입니다.")
    private String passwordconfirm;

    @NotBlank(message = "이메일 아이디는 필수 입력값입니다.")
    private String emailUsername;

    @NotBlank(message = "이메일 도메인은 필수 입력값입니다.")
    private String emailDomain;

    @NotBlank(message = "전화번호는 필수 입력값입니다.")
    private String phone1;

    @NotBlank(message = "전화번호는 필수 입력값입니다.")
    private String phone2;

    @NotBlank(message = "전화번호는 필수 입력값입니다.")
    private String phone3;

    @NotBlank(message = "실명은 필수 입력값입니다.")
    private String realusername;

    @NotBlank(message = "우편번호는 필수 입력값입니다.")
    private String postalcode;

    @NotBlank(message = "도로명 주소는 필수 입력값입니다.")
    private String streetaddress;

    @NotBlank(message = "상세 주소는 필수 입력값입니다.")
    private String detailedaddress;

    @NotNull(message = "약관에 동의해야 합니다.")
    private Integer termsagreed;
}
