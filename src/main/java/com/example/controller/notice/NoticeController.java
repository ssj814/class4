package com.example.controller.notice;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.CommentDTO;
import com.example.dto.NoticeDTO;
import com.example.service.notice.CommentService;
import com.example.service.notice.NoticeService;

import jakarta.servlet.http.HttpSession;

@Controller
public class NoticeController {

	@Autowired
	NoticeService service;

	@Autowired
	CommentService cService;

	@RequestMapping("/notice")
	public String BoardList(Model m, @RequestParam(value = "searchKey", required = false) String searchKey,
			@RequestParam(value = "searchValue", required = false) String searchValue,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {
		int pageSize = 15; // 페이지당 보여줄 게시글 수

		// 파라미터를 HashMap에 저장
		HashMap<String, Object> map = new HashMap<>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("startRow", (currentPage - 1) * pageSize + 1);
		map.put("endRow", currentPage * pageSize);

		int totalCount = service.getTotalCount(map);
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		List<NoticeDTO> list = service.selectBoardList(map);

		// 데이터를 Model에 담아 뷰로 전달
		m.addAttribute("BoardList", list);
		m.addAttribute("category", "notice");
		m.addAttribute("currentPage", currentPage);
		m.addAttribute("totalPages", totalPages);
		m.addAttribute("totalCount", totalCount);
		m.addAttribute("pageSize", pageSize);
		m.addAttribute("search", map);

		return "notice/list";
	}

	@RequestMapping("/notice_content")
	public String BoardContent(Model m,
			@RequestParam(value = "postid", defaultValue = "0") int postid,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {

		// 원본 게시글 가져오기
		NoticeDTO dto = service.selectBoardOne(postid);
		// 댓글 목록 가져오기
		List<CommentDTO> comments = cService.getCommentsByPostId(postid);

		// JSP 페이지에 필요한 데이터 설정
		m.addAttribute("BoardOne", dto);
		m.addAttribute("comments", comments); // 댓글 목록 추가
		m.addAttribute("currentPage", currentPage);

		return "notice/content";
	}

	@RequestMapping("/admin/notice_write")
	public String BoardWrite() {
		return "notice/BoardWriting";
	}

	@RequestMapping("/admin/notice_update")
	public String BoardUpdate(@RequestParam("postid") int postid, Model m) {
		NoticeDTO dto = service.selectBoardOne(postid);
		m.addAttribute("post", dto);
		return "notice/BoardWriting";
	}

	@RequestMapping("/admin/notice_delete")
	public String BoardDelete(@RequestParam("postid") int postid, @RequestParam("currentPage") int currentPage,
			RedirectAttributes redirectAttributes) {

		int num = service.boardDelete(postid);
		String message = "";
		if (num == 1) {
			message = "글을 삭제하였습니다.";
		} else {
			message = "글 삭제 실패.";
		}
		redirectAttributes.addFlashAttribute("mesg", message);
		return "redirect:/notice?currentPage=" + currentPage;
	}

	@RequestMapping("/admin/notice_save")
	public String BoardSave(HttpSession session, @RequestParam("title") String title,
			@RequestParam("content") String content, @RequestParam(value = "postid", required = false) Integer postid,
			@RequestParam(value = "popup", required = false) String popup, RedirectAttributes redirectAttributes) {
		
		String category = (String) session.getAttribute("category");
		if (category == null) {
			category = ""; // 혹은 적절한 기본 카테고리 설정
		}
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String user_id = authentication.getName();
		
		NoticeDTO dto = new NoticeDTO();
		dto.setTitle(title);
		dto.setContent(content);
		dto.setCategory(category);
		dto.setWriter(user_id);
		
		// 팝업 표시 여부 확인
        if ("Y".equals(popup)) {
        	dto.setPopup("Y");
        } else {
        	dto.setPopup("N");
        }

		String message = "";
		int count;
		if (postid != null) {
			dto.setPostid(postid);
			count = service.updateContent(dto);
			message = "글을 수정하였습니다";
			
		} else {
			count = service.insertContent(dto);
			message = "글을 저장하였습니다";
		}
		
	    // popup 값이 "Y"일 때, 최대 3개 유지 로직 처리
	    if ("Y".equals(popup)) {
	        List<NoticeDTO> popupNotices = service.getPopupNotices();  // "Y"인 공지사항 목록 가져오기
	        System.out.println("popupNotices : "+popupNotices);
	        if (popupNotices.size() > 3) {
	            for (int i = 0; i < popupNotices.size()-3; i++) {
	                NoticeDTO notice = popupNotices.get(i);
	                System.out.println("Y인 게시글 : "+notice);
	                service.updatePopupToN(notice);  // 오래된 공지사항 popup 값을 "N"으로 업데이트
	            }
	        }
	    }
		
		redirectAttributes.addFlashAttribute("mesg", message);
		return "redirect:/notice";
	}
	
	
	// 댓글
	
	
	// 댓글 작성 (일반 댓글 및 대댓글 모두 처리)
    @PostMapping("/saveComment")
    @ResponseBody
    public String saveComment(@ModelAttribute CommentDTO commentDTO,
            @RequestParam(value = "postid", required = false) Integer postid) {
        // 부모 댓글 ID가 없으면 일반 댓글, 있으면 대댓글로 처리
        if (commentDTO.getParentId() == null || commentDTO.getParentId() == 0) {
            // 일반 댓글인 경우
            commentDTO.setRepIndent(0);  // 일반 댓글은 들여쓰기 없음
            commentDTO.setPostId(postid);  // 일반 댓글은 postid를 따로 설정해줌
        } else {
            // 대댓글의 경우, commentDTO에 이미 postid가 포함되어 있을 가능성이 있음
            if (commentDTO.getPostId() == 0) {
                commentDTO.setPostId(postid);  // 만약 postid가 없으면 추가 설정
            }
            // repIndent는 JSP에서 받아온 값을 그대로 사용
        }
        // 댓글 저장 로직 호출 (서비스 계층으로 위임)
        cService.addComment(commentDTO);
        // 성공적으로 저장 후 응답
        return "success";
    }
    
    //댓글 수정
    @PostMapping("/editComment")
    @ResponseBody
    public String editComment(@RequestParam("id") int id, @RequestParam("content") String content) {
        CommentDTO commentDTO = new CommentDTO();
        commentDTO.setId(id);
        commentDTO.setContent(content);
        
        // 댓글 수정 서비스 호출
        cService.updateComment(commentDTO);
        
        return "success";
    }

    //댓글 삭제 (대댓글도 함께 삭제됨)
    @PostMapping("/deleteComment")
    @ResponseBody
    public String deleteComment(@RequestParam("id") int id) {
        // 댓글 삭제 서비스 호출
        cService.deleteComment(id);
        
        return "success";
    }
    
}
