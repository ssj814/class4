package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.service.TrainerService;
import com.example.dto.TrainerDTO;

@Controller
@RequestMapping
public class TrainerController {

	@Autowired
	TrainerService service;
	
	@GetMapping("/test")
	public String test() {
		return "/trainer/trainerAdd";
	}
	
	@RequestMapping("/trainer_list")
	public String trainerList(
			@RequestParam(required = false) String field,
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchVal,
			@RequestParam(required = false) Integer page,
			Model m
			) {
		/////////////////////////////페이징////////////////////////////////
		int listPerPage = 5; //한 페이지에 표시할 게시물 수
		int currentPage = 1; //현재 페이지 기본 세팅
		 
		if(page != null) currentPage = page;
		
		int startRow = (currentPage-1) * listPerPage + 1; //시작할 행 no.
		int endRow = currentPage * listPerPage; //마지막 뽑아올 행 no.
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("startRow", startRow);
		params.put("endRow", endRow);
		//
		params.put("field", field);
		params.put("searchType", searchType);
		params.put("searchVal", searchVal);
		
		System.out.println(startRow + " " + endRow);
		List<TrainerDTO> posts = service.getlistsByPage(params);//해당 페이지에 나올 리스트
		
		int totalLists = service.getTotalLists(params); //총 데이터 갯수
		System.out.println(totalLists);
		int totalPages = totalLists / listPerPage;
		if (totalLists % listPerPage != 0) { // 나머지 남을 때 페이지수 +
			totalPages++;
		}
		
		int pageBlock = 5;  // 한 번에 표시할 페이지 번호의 개수
        int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
        int endPage = startPage + pageBlock - 1;
        if (endPage > totalPages) {
            endPage = totalPages;
        }
        
        m.addAttribute("currentPage", currentPage);
        m.addAttribute("totalPages", totalPages);
        m.addAttribute("startPage", startPage);
        m.addAttribute("endPage", endPage);
        
        m.addAttribute("field", field);
        m.addAttribute("searchType", searchType);
        m.addAttribute("searchVal", searchVal);
        
        m.addAttribute("list", posts);
				
		return "/trainer/trainerList";
	}
	
	@GetMapping("/trainer_join")
	public String trainerJoin1() {
		return "/trainer/trainerAdd";
	}
	@PostMapping("/trainer_join")
	public String trainerJoin2(@ModelAttribute TrainerDTO trainer, RedirectAttributes ra) {
		//파일 저장////////////////////////////////////////
//		String savePath = "upload";
//		int uploadFileSizeLimit = 5 * 1024 * 1024;
//		String encType = "UTF-8";
//		ServletContext ctx = getServletContext();
//		String uploadFilePath = ctx.getRealPath(savePath);
//		
//		MultipartRequest multi = new MultipartRequest(request, uploadFilePath, 
//				uploadFileSizeLimit, encType, new DefaultFileRenamePolicy());
//		
//		String fileName = multi.getFilesystemName("trainer_img_url");
//		if (fileName == null) {
//			System.out.println("파일 업로드 없음");
//		}
		//////////////////////////////////////////
		//로그인 시 트레이너 등록 가능하도록 -> 세션에서 로그인아이디 존재여부 검사, 존재하면 트레이너아이디 존재유무 확인
		//session.getAttribute("user_id");
		//TrainerProfileDTO dto = service.checkIfTrainer(user_id);
		
		//if (userid != null && dto == null) {//로그인되어있고 트레이너 아이디없으면
			System.out.println(trainer);
			trainer.setImg_name("");
			trainer.setImg_url("");
			
			int n = service.insertTrainer(trainer);
			String mesg = "트레이너 등록 완료";
			if (n == 1) {
				ra.addFlashAttribute("mesg", mesg);
			} else {
				mesg = "트레이너 등록 실패";
				ra.addFlashAttribute("mesg", mesg);
			}
		return "redirect:/trainer_list";
	}
	
	@GetMapping("/trainer_info")
	public String info(@RequestParam Integer idx, Model m) {
		TrainerDTO dto = service.selectTrainer(idx);
		m.addAttribute("info", dto);
		return "/trainer/trainerInfo";
	}
	
	@GetMapping("/trainer_modify")
	public String modify(@RequestParam Integer idx, Model m) {
		TrainerDTO dto = service.selectTrainer(idx);
		m.addAttribute("info", dto);
		return "/trainer/trainerEdit";
	}
	
	@PostMapping("/trainer_modify")
	public String modify2(@ModelAttribute TrainerDTO trainer, RedirectAttributes ra) {
		System.out.println(trainer);
		trainer.setImg_name("");
		trainer.setImg_url("");
		
		int n = service.updateTrainer(trainer);
		
		String mesg = "트레이너 정보 수정 완료";
		if (n != 1) mesg = "트레이너 정보 수정 실패";
		
//		TrainerDTO newdto = service.selectTrainer(trainer.getTrainer_id());
		ra.addAttribute("idx", trainer.getTrainer_id());
		ra.addAttribute("mesg", mesg);
		return "redirect:/trainer_info";
	}
	
	@RequestMapping("/trainer_deletion")
	public String delete(@RequestParam Integer idx, RedirectAttributes ra) {
		int n = service.deleteTrainer(idx);
		
		String mesg = "트레이너 정보 삭제 완료";
		if (n == 1) {
			ra.addFlashAttribute("mesg", mesg);
		} else {
			mesg = "트레이너 정보 삭제 실패";
			ra.addFlashAttribute("mesg", mesg);
		}
		return "redirect:/trainer_list";
	}
	
}
