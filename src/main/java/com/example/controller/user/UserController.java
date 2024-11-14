package com.example.controller.user;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.CartDTO;
import com.example.dto.CartProductDTO;
import com.example.dto.ProductDTO;
import com.example.dto.ProductOptionDTO;
import com.example.dto.ProductWishDTO;
import com.example.dto.user.UserDTO;
import com.example.dto.user.ValidationUserDTO;
import com.example.entity.User;
import com.example.entity.User.Role;
import com.example.repository.UserRepository;
import com.example.service.Mypage.MyPageServiceImpl;
import com.example.service.shoppingmall.CartService;
import com.example.service.shoppingmall.ProductService;
import com.example.service.shoppingmall.WishService;
import com.example.service.user.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CartService cartService;

    @Autowired
    private WishService wishService;

    @Autowired
    private ProductService productService;

    @Autowired
    private MyPageServiceImpl myPageService;

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
    private final String uploadPath = "C:/images/user/"; // 외부 파일 저장 경로

    @RequestMapping("/loginForm")
    public String loginForm() {
        return "user/loginForm";
    }

    // 회원가입
    @PostMapping("/register")
    public String register(@Valid ValidationUserDTO validationUserDTO, BindingResult bindingResult) {
        logger.info("회원가입 요청 받음");

        // 중복된 아이디 체크
        Optional<User> userOptional = userRepository.findByUserid(validationUserDTO.getUserid());
        if (userOptional.isPresent()) {
            bindingResult.rejectValue("userid", "error.userid", "이미 존재하는 아이디입니다.");
        }

        // 중복된 이메일 체크
        String email = validationUserDTO.getEmailUsername() + "@" + validationUserDTO.getEmailDomain();
        if (userRepository.findByEmail(email).isPresent()) {
            bindingResult.rejectValue("email", "error.email", "이미 존재하는 이메일입니다.");
        }

        if (bindingResult.hasErrors()) {
            logger.error("유효성 검사 실패");
            return "user/UserWriteForm";
        }

        userService.registerWithValidation(validationUserDTO);
        return "redirect:/loginForm";
    }

    // 마이페이지 수정 메소드
    @PostMapping("/Mypage/editInfo")
    public String updateProfile(@Valid ValidationUserDTO validationUserDTO, BindingResult bindingResult, Principal principal, Model model) {
        if (bindingResult.hasErrors()) {
            // 유효성 검사 실패 시 수정 페이지로 돌아갑니다.
            model.addAttribute("userInfo", validationUserDTO);
            return "Mypage/editInfo";
        }

        try {
            // 프로필 사진 업로드 및 저장
            MultipartFile profilePictureFile = validationUserDTO.getProfilePictureFile();
            if (profilePictureFile != null && !profilePictureFile.isEmpty()) {
                String fileName = UUID.randomUUID().toString() + "_" + profilePictureFile.getOriginalFilename();
                File directory = new File(uploadPath);
                if (!directory.exists()) {
                    directory.mkdirs(); // 디렉토리가 없는 경우 생성
                }
                Files.copy(profilePictureFile.getInputStream(), Paths.get(uploadPath + fileName), StandardCopyOption.REPLACE_EXISTING);
                validationUserDTO.setProfilePictureUrl("/images/user/" + fileName); // 저장된 URL 경로 설정
            }

            // 사용자 정보를 업데이트합니다.
            userService.updateUserWithValidation(validationUserDTO);
            model.addAttribute("message", "정보가 성공적으로 수정되었습니다.");
            return "redirect:/mypage?page=userInfo";
        } catch (Exception e) {
            logger.error("프로필 사진 업로드 중 오류 발생: ", e);
            model.addAttribute("errorMessage", "프로필 사진 업로드 중 오류가 발생했습니다.");
            return "Mypage/editInfo";
        }
    }
    
    // 마이페이지 조회
 // 마이페이지 조회
    @RequestMapping("/mypage")
    public String myPage(
            @RequestParam(value = "page", required = false) String page,
            Model model,
            Principal principal,
            @ModelAttribute ValidationUserDTO validationUserDTO,
            BindingResult bindingResult,
            HttpServletRequest request) {

        String userId = principal.getName();

        if (page == null || page.isEmpty()) {
            page = "userInfo";
        }

        if ("GET".equalsIgnoreCase(request.getMethod())) {
            if ("userInfo".equals(page)) {
                UserDTO userInfo = myPageService.getUserInfo(userId);
                model.addAttribute("userInfo", userInfo);

            } else if ("editInfo".equals(page)) {
                User user = userRepository.findByUserid(userId).orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));
                validationUserDTO.setUserid(user.getUserid());
                validationUserDTO.setRealusername(user.getRealusername());
                validationUserDTO.setEmailUsername(user.getEmailUsername());
                validationUserDTO.setEmailDomain(user.getEmailDomain());
                validationUserDTO.setPhone1(user.getPhone1());
                validationUserDTO.setPhone2(user.getPhone2());
                validationUserDTO.setPhone3(user.getPhone3());
                validationUserDTO.setStreetaddress(user.getStreetaddress());
                validationUserDTO.setDetailedaddress(user.getDetailedaddress());
                validationUserDTO.setPostalcode(user.getPostalcode());
                validationUserDTO.setTermsagreed(user.getTermsagreed());
                validationUserDTO.setGender(user.getGender());
                validationUserDTO.setProfilePictureUrl(user.getProfilepicture());

                model.addAttribute("validationUserDTO", validationUserDTO);

            } else {
                UserDTO userInfo = myPageService.getUserInfo(userId);
                model.addAttribute("userInfo", userInfo);
            }
        } else if ("POST".equalsIgnoreCase(request.getMethod()) && "editInfo".equals(page)) {
            if (bindingResult.hasErrors()) {
                return "Mypage/mypage";
            }

            try {
                MultipartFile profilePictureFile = validationUserDTO.getProfilePictureFile();
                if (profilePictureFile != null && !profilePictureFile.isEmpty()) {
                    String fileName = UUID.randomUUID().toString() + "_" + profilePictureFile.getOriginalFilename();
                    File directory = new File(uploadPath);
                    
                    if (!directory.exists()) {
                        boolean dirCreated = directory.mkdirs();
                        if (!dirCreated) {
                            logger.error("디렉토리 생성 실패: " + uploadPath);
                            model.addAttribute("errorMessage", "프로필 사진 저장 중 오류가 발생했습니다.");
                            return "Mypage/mypage";
                        }
                    }

                    Path filePath = Paths.get(uploadPath + fileName);
                    Files.copy(profilePictureFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                    validationUserDTO.setProfilePictureUrl("/images/user/" + fileName);
                    logger.info("프로필 사진이 성공적으로 업로드 되었습니다: " + filePath.toString());
                } else {
                    logger.warn("프로필 사진 파일이 비어 있습니다.");
                }

                userService.updateUserWithValidation(validationUserDTO);
                model.addAttribute("message", "정보가 성공적으로 수정되었습니다.");
                return "redirect:/mypage?page=userInfo";
            } catch (Exception e) {
                logger.error("프로필 사진 업로드 중 오류 발생: ", e);
                model.addAttribute("errorMessage", "프로필 사진 업로드 중 오류가 발생했습니다.");
                return "Mypage/mypage";
            }
        }
        return "Mypage/mypage";
    }

}
