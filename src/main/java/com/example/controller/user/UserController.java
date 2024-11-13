package com.example.controller.user;

import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dto.user.UserDTO;
import com.example.dto.user.ValidationUserDTO;
import com.example.entity.User;
import com.example.repository.UserRepository;
import com.example.service.user.UserService;

import jakarta.validation.Valid;

@Controller
public class UserController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private UserRepository userRepository;
    
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
    
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
    
    @PostMapping("/register")
    public String register(@Valid ValidationUserDTO validationUserDTO, BindingResult bindingResult) {
        logger.info("회원가입 요청 받음"); // 로그 추가

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
        if (userRepository.findByEmail(email).isPresent()) {
            bindingResult.rejectValue("email", "error.email", "이미 존재하는 이메일입니다.");
        }

        // 유효성 검사 실패 시 폼으로 돌아가기
        if (bindingResult.hasErrors()) {
            logger.error("유효성 검사 실패, 오류들: ");
            bindingResult.getAllErrors().forEach(error -> {
                if (error instanceof FieldError) {
                    FieldError fieldError = (FieldError) error;
                    logger.error("오류 필드: " + fieldError.getField() + ", 메시지: " + fieldError.getDefaultMessage());
                } else {
                    logger.error("일반 오류 메시지: " + error.getDefaultMessage());
                }
            });
            return "user/UserWriteForm";
        }

        // 유효성 검사 통과 시 회원 등록 로직
        userService.registerWithValidation(validationUserDTO);
        return "redirect:/loginForm"; // 회원가입 후 로그인 페이지로 리다이렉트
    }

    
//    @GetMapping("/checkUserId")
//    public ResponseEntity<String> checkUserId(@RequestParam String userid) {
//    	System.out.println("아이디 중복 체크 요청: " + userid);  // 요청 받은 아이디 출력
//    	
//        boolean isAvailable = userService.isUserIdAvailable(userid);
//        System.out.println("아이디 사용 가능 여부: " + isAvailable);
//        
//        if (isAvailable) {
//        	System.out.println("아이디 사용 가능: " + userid);  // 아이디가 사용 가능한 경우 출력
//            return ResponseEntity.ok("Available");  // 사용 가능한 아이디
//        } else {
//        	System.out.println("아이디 중복: " + userid);  // 아이디가 이미 사용 중인 경우 출력
//            return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 사용 중인 아이디입니다.");  // 409 상태 코드와 함께 해당 메시지 반환
//        }
//    }

    @GetMapping("/checkUserId")
    public ResponseEntity<String> checkUserId(@RequestParam String userid) {
        boolean isAvailable = userService.isUserIdAvailable(userid);
        
        if (isAvailable) {
            return ResponseEntity.ok("Available");  // 사용 가능한 아이디
        } else {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 사용 중인 아이디입니다.");  // 409 상태 코드와 함께 해당 메시지 반환
        }
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
            return "main"; // 로그인 성공 후 이동할 페이지
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
    
	////////예외처리
	@RequestMapping("/admin/view")
	@PreAuthorize("hasRole('ADMIN')")
	public String managerView(Model m) { 
		System.out.println("/admin/view");
		List<User> users= userRepository.findAll();
		System.out.println("users" + users);
		m.addAttribute("users", users);
		return "user/adminView";
	}
	
	//삭제
	 @RequestMapping("/admin/delete/{usernumber}")
	    public String deleteUser(@PathVariable("usernumber") int usernumber) {
	        userRepository.deleteById(usernumber);  // usernumber로 사용자 삭제
	        return "redirect:/admin/view";  // 삭제 후 목록 페이지로 리다이렉트
	    }

}