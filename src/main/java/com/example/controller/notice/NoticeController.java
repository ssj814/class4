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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.BoardPostsDTO;
import com.example.dto.CommentDTO;
import com.example.service.image.ImageService;
import com.example.service.notice.CommentService;
import com.example.service.notice.NoticeService;

@Controller
public class NoticeController {

	@Autowired
	NoticeService service;

	@Autowired
	CommentService cService;
	
	@Autowired
	ImageService imageService;

	@RequestMapping("/notice")
    public String BoardList(Model m, @RequestParam(value = "searchKey", required = false) String searchKey,
                             @RequestParam(value = "searchValue", required = false) String searchValue,
                             @RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {
        int pageSize = 15;

        HashMap<String, Object> map = new HashMap<>();
        map.put("searchKey", searchKey);
        map.put("searchValue", searchValue);
        map.put("startRow", (currentPage - 1) * pageSize + 1);
        map.put("endRow", currentPage * pageSize);
        map.put("categoryId", 1);

        int totalCount = service.getTotalCount(map);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        List<BoardPostsDTO> list = service.selectBoardList(map);

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

        BoardPostsDTO dto = service.selectBoardOne(postid);
        List<CommentDTO> comments = cService.getCommentsByPostId(postid);

        m.addAttribute("BoardOne", dto);
        m.addAttribute("comments", comments);
        m.addAttribute("currentPage", currentPage);

        return "notice/content";
    }

    @RequestMapping("/admin/notice_write")
    public String BoardWrite() {
        return "notice/BoardWriting";
    }

    @RequestMapping("/admin/notice_update")
    public String BoardUpdate(@RequestParam("postid") int postid, Model m) {
        BoardPostsDTO dto = service.selectBoardOne(postid);
        m.addAttribute("post", dto);
        return "notice/BoardWriting";
    }

    @RequestMapping("/admin/notice_delete")
    public String BoardDelete(@RequestParam("postid") int postid, @RequestParam("currentPage") int currentPage,
                               RedirectAttributes redirectAttributes) {

    	BoardPostsDTO dto = service.selectBoardOne(postid);
    	String imgName = dto.getImageName();
		imageService.deleteImg(imgName,"notice");
    	
        int num = service.boardDelete(postid);
        
        String message = num == 1 ? "글을 삭제하였습니다." : "글 삭제 실패.";
        redirectAttributes.addFlashAttribute("mesg", message);
        return "redirect:/notice?currentPage=" + currentPage;
    }

    @RequestMapping("/admin/notice_save")
    public String BoardSave(@RequestParam("title") String title,
                             @RequestParam("content") String content,
                             @RequestParam(value = "postid", required = false) Integer postid,
                             @RequestParam(value = "popup", required = false, defaultValue = "N") String popup,
                             RedirectAttributes redirectAttributes, MultipartFile notice_image) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String writer = authentication.getName();
        
        System.out.println("이미지 : "+notice_image);
        
        String imgName = imageService.saveImg(notice_image, "notice");

        BoardPostsDTO dto = new BoardPostsDTO();
        dto.setTitle(title);
        dto.setContent(content);
        dto.setCategoryId(1); // NOTICE 게시판은 CATEGORY_ID = 1
        dto.setWriter(writer);
        dto.setPopup(popup); // 팝업 여부 설정
        dto.setImageName(imgName);

        String message;
        if (postid != null) {
            dto.setPostId(postid);
            service.updateContent(dto);
            message = "글을 수정하였습니다.";
        } else {
            service.insertContent(dto);
            message = "글을 저장하였습니다.";
        }

        // 팝업 게시글 유지 제한 로직
        if ("Y".equals(popup)) {
            List<BoardPostsDTO> popupPosts = service.getPopupPosts();
            if (popupPosts.size() > 3) {
                for (int i = 0; i < popupPosts.size() - 3; i++) {
                    BoardPostsDTO oldPost = popupPosts.get(i);
                    oldPost.setPopup("N");
                    service.updateContent(oldPost); // 오래된 팝업 게시글 업데이트
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
