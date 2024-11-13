package com.example.controller.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.dto.user.UserDto;
import com.example.entity.User;
import com.example.entity.User.Role;
import com.example.repository.UserRepository;
import com.example.service.user.UserService;

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

    @PostMapping("/register")
    public String register(UserDto userDto) { // UserDto를 사용
        userService.register(userDto); // DB에 사용자 저장
        return "redirect:loginForm"; // 회원가입 후 로그인 페이지로 리다이렉트
    }

    @GetMapping("/login")
    public String showLoginForm() {
    	System.out.println("get login 주소접근");
        return "user/loginForm"; // 로그인 폼 페이지
    }

    @PostMapping("/login")
    public String login(UserDto userDto, Model model) { // UserDto를 사용
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
    
    @RequestMapping("/admin/view")
    @PreAuthorize("hasRole('ADMIN')")
    public String managerView(Model m) {
        System.out.println("/admin/view");

        // 오름차순으로 정렬된 사용자 목록 가져오기
        List<User> users = userService.findAllSortedByUsernumber();
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

}