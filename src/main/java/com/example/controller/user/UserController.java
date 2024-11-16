package com.example.controller.user;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

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
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.ProductDTO;
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
    
    private static Logger logger = LoggerFactory.getLogger(UserController.class);
    private final String uploadPath = "C:/images/user/"; // 외부 파일 저장 경로
    
//    @RequestMapping("/")
//    public String main() {
//    	return "main";
//    }
    
    @RequestMapping("/loginForm")
    public String loginForm() {
    	return "user/loginForm";
    }
    
    @RequestMapping("/UserWriteForm")
    public String UserWriteForm() {
    	return "user/UserWriteForm";
    }
    

    @GetMapping("/register")
    public String showRegistrationForm() {
        return "user/UserWriteForm"; // 회원가입 폼 페이지
    }
    
    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("validationUserDTO") ValidationUserDTO validationUserDTO,
                           BindingResult bindingResult, Model model) {
        logger.info("회원가입 요청 받음");

        // 중복된 아이디 체크
        System.out.println("중복 아이디 체크 시작: " + validationUserDTO.getUserid());
        Optional<User> userOptional = userRepository.findByUserid(validationUserDTO.getUserid());
        System.out.println("findByUserid 결과: " + userOptional);

        if (userOptional.isPresent()) {
            bindingResult.rejectValue("userid", "error.userid", "이미 존재하는 아이디입니다.");
            System.out.println("아이디 중복됨");
        } else {
            System.out.println("아이디 중복 아님");
        }

        // 중복된 이메일 체크
        String email = validationUserDTO.getEmailUsername() + "@" + validationUserDTO.getEmailDomain();
        System.out.println("중복 이메일 체크 시작: " + email);
        if (userRepository.findByEmail(email).isPresent()) {
            bindingResult.rejectValue("emailUsername", "error.email", "이미 존재하는 이메일입니다.");
            System.out.println("이메일 중복됨");
        } else {
            System.out.println("이메일 중복 아님");
        }

     // 유효성 검사 실패 시 다시 폼으로 이동
        if (bindingResult.hasErrors()) {
            logger.error("유효성 검사 실패, 오류들: ");
            
            
         // 약관 동의 여부 체크 (약관 동의하지 않으면 0으로 설정)
//            if (validationUserDTO.getTermsagreed() == null) {
//                validationUserDTO.setTermsagreed("0"); // 약관 동의를 하지 않으면 0으로 설정
//            }
            
            // 유효성 검사 실패 시 validationUserDTO를 모델에 추가
            model.addAttribute("validationUserDTO", validationUserDTO);
            
            // 오류들 로그로 출력
            bindingResult.getAllErrors().forEach(error -> {
                if (error instanceof FieldError) {
                    FieldError fieldError = (FieldError) error;
                    String fieldName = fieldError.getField();
                    String errorMessage = fieldError.getDefaultMessage();
                    
                    // 오류 필드에 맞게 validationUserDTO의 오류 필드를 설정
                    switch (fieldName) {
                        case "userid":
                            validationUserDTO.setUseridError(errorMessage);  // useridError 필드에 메시지 할당
                            break;
                        case "userpw":
                            validationUserDTO.setUserpwError(errorMessage);  // userpwError 필드에 메시지 할당
                            break;
                        case "userpwConfirm":
                            validationUserDTO.setUserpwConfirmError(errorMessage);  // userpwConfirmError 필드에 메시지 할당
                            break;
                        case "emailUsername":
                            validationUserDTO.setEmailUsernameError(errorMessage);  // emailUsernameError 필드에 메시지 할당
                            break;
                        case "phone1":
                            validationUserDTO.setPhone1Error(errorMessage);  // phone1Error 필드에 메시지 할당
                            break;
                        case "phone2":
                            validationUserDTO.setPhone2Error(errorMessage);  // phone2Error 필드에 메시지 할당
                            break;
                        case "phone3":
                            validationUserDTO.setPhone3Error(errorMessage);  // phone3Error 필드에 메시지 할당
                            break;
                        case "realusername":
                            validationUserDTO.setRealusernameError(errorMessage);  // realusernameError 필드에 메시지 할당
                            break;
                        case "postalcode":
                            validationUserDTO.setPostalcodeError(errorMessage);  // postalcodeError 필드에 메시지 할당
                            break;
                        case "streetaddress":
                            validationUserDTO.setStreetaddressError(errorMessage);  // streetaddressError 필드에 메시지 할당
                            break;
                        case "detailedaddress":
                            validationUserDTO.setDetailedaddressError(errorMessage);  // detailedaddressError 필드에 메시지 할당
                            break;
                        case "termsagreed":
                            validationUserDTO.setTermsagreedError(errorMessage);  // termsagreedError 필드에 메시지 할당
                            break;
                        default:
                            break;
                    }
                } else {
                    logger.error("일반 오류 메시지: " + error.getDefaultMessage());
                }
            });

            System.out.println("유효성 검사 실패, 다시 폼으로 이동");
            return "user/UserWriteForm";
        }

        // 유효성 검사 통과 시 회원 등록 로직
        userService.registerWithValidation(validationUserDTO);
        System.out.println("회원가입 성공, 로그인 페이지로 리다이렉트");
        return "redirect:/loginForm";
    }


    @GetMapping("/checkUserId")
    public ResponseEntity<String> checkUserId(@RequestParam String userid) {
    	System.out.println("아이디 중복 체크 요청: " + userid);  // 요청 받은 아이디 출력
        boolean isAvailable = userService.isUserIdAvailable(userid);
        
        if (isAvailable) {
        	System.out.println("아이디 사용 가능: " + userid);  // 아이디가 사용 가능한 경우 출력
            return ResponseEntity.ok("Available");  // 사용 가능한 아이디
        } else {
        	System.out.println("아이디 중복: " + userid);  // 아이디가 이미 사용 중인 경우 출력
            return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 사용 중인 아이디입니다.");  // 409 상태 코드와 함께 해당 메시지 반환
        }
    }
    
    @GetMapping("/checkEmail")
    public ResponseEntity<String> checkEmail(@RequestParam String emailUsername, @RequestParam String emailDomain) {
        String email = emailUsername + "@" + emailDomain;
        System.out.println("이메일 중복 체크 요청: " + email);
        
        boolean isAvailable = userService.isEmailAvailable(email);
        
        if (isAvailable) {
            System.out.println("이메일 사용 가능: " + email);
            return ResponseEntity.ok("Available");
        } else {
            System.out.println("이메일 중복: " + email);
            return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 존재하는 이메일입니다.");
        }
    }

    

    @ModelAttribute("validationUserDTO")
    public ValidationUserDTO createValidationUserDTO() {
        return new ValidationUserDTO();
    }
    
    @GetMapping("/termsAgreed")
    public String showTerms() {
        return "user/member/termsAgreed";  // "termsAgreed.jsp"를 반환
    }

    @GetMapping("/login")
    public String showLoginForm() {
    	System.out.println("get login 주소접근");
        return "user/loginForm"; // 로그인 폼 페이지
    }

    @PostMapping("/login")
    public String login(UserDTO userDto, Model model) { // UserDto를 사용
        System.out.println(userDto);
        User user = userService.login(userDto); // DTO를 통해 로그인 처리
        System.out.println("login user"+user);
        if (user != null) {
            model.addAttribute("login", user);
            System.out.println("login user"+user);
            return "redirect:/"; // 로그인 성공 후 이동할 페이지
        } else {
            model.addAttribute("mesg", "아이디 또는 비밀번호가 잘못되었습니다."); // 오류 메시지
            return "user/loginForm"; // 로그인 실패 시 이동할 페이지
        }
    }
    
    @RequestMapping("/loginDenied")
	public String loginDenied() {
		System.out.println("/loginDenied");
		//return "user/loginDenied";
		return "error/403";
	}
    
    @RequestMapping("/loginCancel")
	public String loginCancel() {
		System.out.println("/loginCancel");
		//return "user/loginCancel";
		return "error/403";
	}

    @RequestMapping("/admin/view")
    @PreAuthorize("hasRole('ADMIN')")
    public String managerView(Model m) {
        System.out.println("/admin/view");

        // 오름차순으로 정렬된 사용자 목록 가져오기
        List<User> users = userService.findAllSortedByUsernumber();
        //List<User> users = userRepository.findAll();
        System.out.println("users: " + users);

        // 정렬된 사용자 목록을 모델에 추가하여 JSP로 전달
        m.addAttribute("users", users);

        return "user/adminView"; // 사용자 목록 페이지
    }
	
	//삭제
	 @RequestMapping("/admin/delete/{usernumber}")
	    public String deleteUser(@PathVariable("usernumber") int usernumber) {
	        userRepository.deleteById(usernumber);  // usernumber로 사용자 삭제
	        return "redirect:/admin/view";  // 삭제 후 목록 페이지로 리다이렉트
	    }
	 
	 // 역할 변경 처리
	    @RequestMapping("/admin/changeRole/{usernumber}")
	    public String changeRole(@PathVariable("usernumber") int usernumber, Role newRole) {
	        userService.updateUserRole(usernumber, newRole);  // 역할 변경 서비스 호출
	        return "redirect:/admin/view";  // 변경 후 목록 페이지로 리다이렉트
	    }

    @PostMapping("/user/withdraw")
    public String withdrawUser(@RequestParam("reason") String reason, Principal principal, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        String userid = principal.getName(); // 현재 로그인한 사용자의 ID
        
        // 탈퇴 사유를 로그에 기록
        logger.info("User {} has withdrawn. Reason: {}", userid, reason);
        
        // 사용자 비활성화 처리
        userService.deactivateUser(userid);
        
        // 세션 종료 및 로그아웃 처리
        new SecurityContextLogoutHandler().logout(request, response, null);
        
        // 메시지를 추가하여 사용자에게 알림
        redirectAttributes.addFlashAttribute("message", "회원 탈퇴가 완료되었습니다.");

        return "redirect:/login?logout"; // 로그아웃 후 로그인 페이지로 리다이렉트
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
        System.out.println("page : "+page);
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

            } else if ("wishlist".equals(page)) {
            	System.out.println("wishlist else if 옴");
                // 위시리스트 페이지
                List<ProductWishDTO> wishList = wishService.selectWishList(userId);
                List<Map<String, Object>> wishProductList = new ArrayList<>();

                // 위시리스트의 각 상품에 대해 상세 정보를 가져와 설정합니다.
                for (ProductWishDTO wish : wishList) {
                    ProductDTO product = productService.selectDetailproduct(wish.getProduct_id());
                    
                    Map<String, Object> wishProductMap = new HashMap<>();
                    wishProductMap.put("wish", wish);
                    wishProductMap.put("product", product);
                    
                    wishProductList.add(wishProductMap);
                }

                System.out.println("wishlist : " + wishList);
                model.addAttribute("wishProductList", wishProductList);
            }
            else {
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
    
    // 특정 회원 정보 수정 페이지로 이동
    @GetMapping("/admin/updateUser/{usernumber}")
    public String getUserForUpdate(@PathVariable("usernumber") int usernumber, Model model) {
        User user = userService.getUserById(usernumber);  // 특정 회원 정보 조회
        model.addAttribute("user", user);  // 회원 정보 모델에 추가
        return "user/adminUpdateuser";  // 회원 정보 수정 페이지 JSP (예: adminUpdateUser.jsp)
    }

    // 회원 정보 수정 처리
    @PostMapping("/admin/updateUser/{usernumber}")
    public String updateUser(@PathVariable("usernumber") int usernumber, 
                             @ModelAttribute("user") ValidationUserDTO validationUserDTO, 
                             Model model) {
    	System.out.println("서비스 전 ");
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
        }
    	} catch (Exception e) {
		}
        User user = userService.updateUser(usernumber, validationUserDTO);  // 회원 정보 수정 처리
        System.out.println("서비스 후 ");
        model.addAttribute("user", user);  // 수정된 회원 정보 모델에 추가
        return "redirect:/admin/view";  // 수정 후 회원 목록 페이지로 리다이렉트
    }
}