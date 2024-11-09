package com.example.controller.user;

import java.security.Principal;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.user.UserDto;
import com.example.entity.User;
import com.example.repository.UserRepository;
import com.example.service.user.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

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
    public String login(UserDto userDto, Model model) {
        System.out.println(userDto);
        try {
            User user = userService.login(userDto); // DTO를 통해 로그인 처리
            System.out.println("login user" + user);

            if (user != null) {
                model.addAttribute("login", user);
                System.out.println("login user" + user);
                return "main"; // 로그인 성공 후 이동할 페이지
            }
        } catch (RuntimeException e) {
            // 로그인이 실패한 경우에 대한 예외 처리
            if (e.getMessage().equals("Account has been withdrawn")) {
                model.addAttribute("mesg", "탈퇴된 계정입니다. 로그인이 불가능합니다."); // 탈퇴된 계정 메시지
            } else {
                model.addAttribute("mesg", "아이디 또는 비밀번호가 잘못되었습니다."); // 일반적인 로그인 실패 메시지
            }
            System.out.println("Login failed: " + e.getMessage());
            return "user/loginForm"; // 로그인 실패 시 이동할 페이지
        }
		return "user/loginForm";
    }


    @RequestMapping("/loginDenied")
    public String loginDenied() {
        System.out.println("/loginDenied");
        return "error/403";
    }

    @RequestMapping("/loginCancel")
    public String loginCancel() {
        System.out.println("/loginCancel");
        return "error/403";
    }

    @RequestMapping("/admin/view")
    @PreAuthorize("hasRole('ADMIN')")
    public String managerView(Model m) {
        System.out.println("/admin/view");
        List<User> users = userRepository.findAll();
        System.out.println("users" + users);
        m.addAttribute("users", users);
        return "user/adminView";
    }

    @RequestMapping("/admin/delete/{usernumber}")
    public String deleteUser(@PathVariable("usernumber") int usernumber) {
        userRepository.deleteById(usernumber); // usernumber로 사용자 삭제
        return "redirect:/admin/view"; // 삭제 후 목록 페이지로 리다이렉트
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
}