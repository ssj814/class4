package com.example.controller.faq;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.FaqDTO;
import com.example.service.faq.FaqService;

import lombok.RequiredArgsConstructor;


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
								@RequestParam(value = "searchValue", required = false) String searchValue,
								@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("category", category);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		int perPage = 15;
		RowBounds bounds = new RowBounds((currentPage-1)*perPage, perPage);
		
        int totalCount = service.getTotalCount(map);
        int totalPages = (int) Math.ceil((double) totalCount / perPage);
		
		List<FaqDTO> list = service.qnaList(map,bounds);
		
	    m.addAttribute("list", list);
	    m.addAttribute("category", category);
	    m.addAttribute("currentPage", currentPage);
	    m.addAttribute("totalCount", totalCount);
	    m.addAttribute("totalPages", totalPages);
	    m.addAttribute("perPage", perPage);
	    m.addAttribute("search", map);
	    
		return "qna/list";
	}
	
	@GetMapping("/qna_content")
    public String qnaContent(Model m,@RequestParam(value = "faq_qna_id") int faq_qna_id,
								@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {
		FaqDTO dto = service.selectBoardOne(faq_qna_id);
        m.addAttribute("BoardOne", dto);
        m.addAttribute("currentPage", currentPage);
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
	
	@GetMapping("/admin/qna_delete")
    public String qnaDelete(@RequestParam("faq_qna_id") int faq_qna_id, @RequestParam("currentPage") int currentPage,
                               RedirectAttributes redirectAttributes) {
		String message = service.deleteQuestion(faq_qna_id);
        redirectAttributes.addFlashAttribute("mesg", message);
        return "redirect:/qna?currentPage=" + currentPage;
    }
	

}
