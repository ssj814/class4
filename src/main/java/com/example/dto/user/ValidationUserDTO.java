package com.example.dto.user;

import com.example.entity.User.Role;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class ValidationUserDTO {

    private String useridError;
    private String userpwError;
    private String userpwConfirmError;
    private String emailUsernameError;
    private String phone1Error;
    private String phone2Error;
    private String phone3Error;
    private String realusernameError;
    private String postalcodeError;
    private String streetaddressError;
    private String detailedaddressError;
    private String termsagreedError;
    private String confirmPasswordError;
    
    @NotBlank(message = "아이디를 입력하세요.")
    @Pattern(regexp = "^[a-z0-9]{4,20}$", message = "아이디는 영문 소문자와 숫자 4~20자리여야 합니다.")
    private String userid;
    
    @NotBlank(message = "비밀번호를 입력하세요.")
    @Pattern(regexp="(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\\\\W)(?=\\\\S+$).{8,20}", 
            message = "비밀번호는 영문 대소문자, 숫자, 특수기호가 포함된 8~20자여야 합니다.")
    private String userpw;
    
    @NotBlank(message = "비밀번호를 입력하세요.")
    private String userpwConfirm;

    @NotBlank(message = "이메일을 입력하세요.")
    private String emailUsername;

    @NotBlank(message = "도메인을 선택하세요.")
    private String emailDomain;

    @NotBlank(message = "전화번호를 입력하세요.")
    private String phone1;

    @NotBlank(message = "전화번호를 입력하세요.")
    @Pattern(regexp = "^\\d{4}$", message = "전화번호 가운데 자리는 숫자 4자리여야 합니다.")
    private String phone2;

    @NotBlank(message = "전화번호를 입력하세요.")
    @Pattern(regexp = "^\\d{4}$", message = "전화번호 끝자리는 숫자 4자리여야 합니다.")
    private String phone3;

    @NotBlank(message = "이름을 입력하세요.")
    @Pattern(regexp = "^[가-힣]+$", message = "실명은 한글로만 입력해야 합니다.")
    private String realusername;

    @NotBlank(message = "주소를 입력하세요.")
    private String postalcode;

    @NotBlank(message = "주소를 입력하세요.")
    private String streetaddress;

    @NotBlank(message = "상세 주소를 입력하세요.")
    private String detailedaddress;

    @NotNull(message = "약관 동의 필수")
    @Pattern(regexp = "^(1)$", message = "약관 동의는 반드시 체크해야 합니다.")
    private String termsagreed;
    
    @NotBlank(message = "성별은 필수 입력값입니다.")
    private String gender;

    private Role role;

    // 프로필 사진 필드 추가
    private String profilePictureUrl; // 프로필 사진 URL
    private MultipartFile profilePictureFile; // 프로필 사진 파일

}
