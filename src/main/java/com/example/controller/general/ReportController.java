package com.example.controller.general;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dto.BoardPostsDTO;
import com.example.dto.CommentDTO;
import com.example.dto.ProductDTO;
import com.example.dto.ReportDTO;
import com.example.dto.TrainerBoardCommentDTO;
import com.example.entity.User;
import com.example.repository.UserRepository;
import com.example.service.general.ReportService;
import com.example.service.notice.CommentService;
import com.example.service.shoppingmall.ProductService;
import com.example.service.sicdan.SicdanService;
import com.example.service.trainer.TrainerBoardCommentService;
import com.example.service.trainer.TrainerBoardService;

@Controller
public class ReportController {
	
	@Autowired
	ReportService rService;
	@Autowired
	ProductService pService;
	@Autowired
	TrainerBoardService tbService;
	@Autowired
	TrainerBoardCommentService tbcService;
	@Autowired
	SicdanService sService;
	@Autowired
	CommentService cService;
	
	@Autowired
    UserRepository userRepository;
	
    @GetMapping("/user/reportWrite")
    public String reportWrite(@RequestParam("targetType") String targetType, 
    		@RequestParam(value = "category", required = false) String category,
    		@RequestParam(value = "id", required = false) Integer id,
    		@RequestParam(value = "previousUrl", required = false) String previousUrl,
    		Model m) {
    	System.out.println("previousUrl : "+previousUrl);
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String userid = authentication.getName();
        User user = userRepository.findByUserid(userid).orElse(null);
        
        Map<String, String> userinfo = new HashMap<>();
        userinfo.put("realname", user.getRealusername());
        userinfo.put("email", user.getEmail());
        userinfo.put("phone", user.getPhone1()+user.getPhone2()+user.getPhone3());
        
    	List<ReportDTO> reportTypes = rService.allReportType();
    	
    	// 신고 대상을 구분하여 모델에 추가
    	if ("PRODUCT".equals(targetType) && id != null) {
    	    ProductDTO pDTO = pService.selectDetailproduct(id);
    	    m.addAttribute("dto", pDTO);
    	} else if (("POST".equals(targetType) || "COMMENT".equals(targetType)) && id != null) {
    	    String content = getContentByCategoryAndTarget(category, targetType, id);
    	    if (content != null) {
    	        m.addAttribute("content", content);
    	        m.addAttribute("category", category);
    	    } else {
    	        throw new IllegalArgumentException("잘못된 카테고리 또는 ID : " + category + ", " + id);
    	    }
    	} else {
    	    throw new IllegalArgumentException("잘못된 신고 요청입니다.");
    	}
    	
        m.addAttribute("user", userinfo);
        m.addAttribute("previousUrl", previousUrl);
        m.addAttribute("targetId", id);
    	m.addAttribute("targetType", targetType);
    	m.addAttribute("reportTypes", reportTypes);
    	
        return "reports/reportWrite";
    }
    
    @PostMapping("/user/reportWrite")
    public String reportSave(ReportDTO dto, @RequestParam(value = "previousUrl", required = false) String previousUrl) {
    	System.out.println("reportDTO : "+dto);
    	rService.saveReport(dto);
    	System.out.println("저장완료");
    	
    	if (previousUrl != null && !previousUrl.isEmpty()) {
            return "redirect:" + previousUrl;
        }
    	
    	return "redirect:/";
    }

    private String getContentByCategoryAndTarget(String category, String targetType, Integer id) {
        switch (category) {
            case "TRAINER":
                if ("POST".equals(targetType)) {
                    BoardPostsDTO tbDTO = tbService.getPostById(id);
                    return tbDTO.getContent();
                } else if ("COMMENT".equals(targetType)) {
                    TrainerBoardCommentDTO tbcDTO = tbcService.getCommentByPostId(id);
                    return tbcDTO.getCommContent();
                }
                break;
            case "SICDAN":
                if ("POST".equals(targetType)) {
                    BoardPostsDTO sDTO = sService.selectByNum(id);
                    return sDTO.getContent();
                }
                break;
            case "NOTICE":
                if ("COMMENT".equals(targetType)) {
                    CommentDTO cDTO = cService.getCommentbyId(id);
                    return cDTO.getContent();
                }
                break;
            default:
                throw new IllegalArgumentException("잘못된 카테고리 : " + category);
        }
        return null;
    }
	
}
