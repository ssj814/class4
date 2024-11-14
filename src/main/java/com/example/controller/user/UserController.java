package com.example.controller.user;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.user.UserDTO;
import com.example.dto.user.ValidationUserDTO;
import com.example.entity.User;
import com.example.entity.User.Role;
import com.example.repository.UserRepository;
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
    
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
    
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
        return "user/UserWriteForm";
    }
    
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

    @GetMapping("/checkUserId")
    public ResponseEntity<String> checkUserId(@RequestParam String userid) {
        boolean isAvailable = userService.isUserIdAvailable(userid);
        if (isAvailable) {
            return ResponseEntity.ok("Available");
        } else {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 사용 중인 아이디입니다.");
        }
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "user/loginForm";
    }

    @PostMapping("/login")
    public String login(UserDTO userDto, Model model) {
        User user = userService.login(userDto);
        if (user != null) {
            model.addAttribute("login", user);
            return "redirect:/";
        } else {
            model.addAttribute("mesg", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "user/loginForm";
        }
    }
    
    @RequestMapping("/loginDenied")
    public String loginDenied() {
        return "error/403";
    }

    @RequestMapping("/loginCancel")
    public String loginCancel() {
        return "error/403";
    }

    @RequestMapping("/admin/view")
    @PreAuthorize("hasRole('ADMIN')")
    public String managerView(Model model) {
        List<User> users = userService.findAllSortedByUsernumber();
        model.addAttribute("users", users);
        return "user/adminView";
    }
    
    @RequestMapping("/admin/delete/{usernumber}")
    public String deleteUser(@PathVariable("usernumber") int usernumber) {
        userRepository.deleteById(usernumber);
        return "redirect:/admin/view";
    }
    
    @RequestMapping("/admin/changeRole/{usernumber}")
    public String changeRole(@PathVariable("usernumber") int usernumber, Role newRole) {
        userService.updateUserRole(usernumber, newRole);
        return "redirect:/admin/view";
    }

    @GetMapping("/user/updateProfile")
    public String showUpdateProfileForm(Principal principal, Model model) {
        String userid = principal.getName();
        User user = userRepository.findByUserid(userid)
                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));

        ValidationUserDTO validationUserDTO = new ValidationUserDTO();
        validationUserDTO.setUserid(user.getUserid());
        validationUserDTO.setRealusername(user.getRealusername()); // 실명 추가
        validationUserDTO.setEmailUsername(user.getEmailUsername());
        validationUserDTO.setEmailDomain(user.getEmailDomain());
        validationUserDTO.setPhone1(user.getPhone1());
        validationUserDTO.setPhone2(user.getPhone2());
        validationUserDTO.setPhone3(user.getPhone3());
        validationUserDTO.setStreetaddress(user.getStreetaddress());
        validationUserDTO.setDetailedaddress(user.getDetailedaddress());
        validationUserDTO.setPostalcode(user.getPostalcode()); // 우편번호 추가
        validationUserDTO.setTermsagreed(user.getTermsagreed()); // 약관 동의 추가
        validationUserDTO.setGender(user.getGender());

        model.addAttribute("validationUserDTO", validationUserDTO);
        return "user/member/updateuser";
    }

    @PostMapping("/user/updateProfile")
    public String updateProfile(@Valid ValidationUserDTO validationUserDTO, BindingResult bindingResult, Principal principal, Model model) {
        if (bindingResult.hasErrors()) {
            return "user/member/updateuser";
        }

        try {
            userService.updateUserWithValidation(validationUserDTO);
            model.addAttribute("message", "정보가 성공적으로 수정되었습니다.");
            return "redirect:/mypage";
        } catch (IllegalArgumentException e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "user/member/updateuser";
        }
    }

    @PostMapping("/user/withdraw")
    public String withdrawUser(@RequestParam("reason") String reason, Principal principal, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        String userid = principal.getName();
        logger.info("User {} has withdrawn. Reason: {}", userid, reason);
        
        userService.deactivateUser(userid);
        new SecurityContextLogoutHandler().logout(request, response, null);
        
        redirectAttributes.addFlashAttribute("message", "회원 탈퇴가 완료되었습니다.");
        return "redirect:/login?logout";
    }
}
