package com.example.controller.faq;

import java.util.HashMap;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.FaqDTO;
import com.example.service.faq.FaqService;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
@RequiredArgsConstructor
public class FaqController {

	private final FaqService service;

	@GetMapping("/Faq_allList")
	public String list(Model m) {
		List<FaqDTO> allData = service.list();
		m.addAttribute("allData", allData);
		return "faq/faqHeader";
	}
	
	@GetMapping("/qna")
	public String qnaList(Model m, @RequestParam(value = "category", required = false) String category,
								@RequestParam(value = "searchKey", required = false) String searchKey,
								@RequestParam(value = "searchValue", required = false) String searchValue) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("category", category);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		List<FaqDTO> list = service.qnaList(map);
		
	    m.addAttribute("list", list);
	    m.addAttribute("category", category);
		return "qna/list";
	}
	
	@GetMapping("/qna_content")
    public String qnaContent(Model m,@RequestParam(value = "faq_qna_id") int faq_qna_id) {
		FaqDTO dto = service.selectBoardOne(faq_qna_id);
        m.addAttribute("BoardOne", dto);
        return "qna/content";
    }
	
	@GetMapping("/qna_write")
    public String qnaWrite() {
        return "qna/writing";
    }
	
	@PostMapping("qna_save")
	public String qnaSave(RedirectAttributes redirectAttributes, @ModelAttribute FaqDTO faqDTO) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String questioner = authentication.getName();
        faqDTO.setQuestioner(questioner);
        
		String message = service.saveQuestion(faqDTO);
		redirectAttributes.addFlashAttribute("message",message);
		return "redirect:/qna";
	}
	
	@ResponseBody
	@PatchMapping("qna_save")
	public String qnaAnswerSave(@RequestParam(value = "faq_qna_id") int faq_qna_id,
							@RequestParam(value = "answer") String answer) {
        FaqDTO faqDTO = new FaqDTO();
        faqDTO.setFaq_qna_id(faq_qna_id);
        faqDTO.setAnswer(answer);
        
		String message = service.saveAnswer(faqDTO);
		return message;
	}
	

}
