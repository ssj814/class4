package com.example.controller.trainer;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.PageDTO;
import com.example.dto.TrainerBoardCommentDTO;
import com.example.dto.TrainerBoardDTO;
import com.example.service.trainer.TrainerBoardCommentService;
import com.example.service.trainer.TrainerBoardService;

import jakarta.servlet.http.HttpSession;

@Controller
public class TrainerBoardController {

	@Autowired
	TrainerBoardService service;
	@Autowired
	TrainerBoardCommentService coservice;

	//메인화면출력
	
	//PageDTO 따로 있음
	@RequestMapping("/TrainerBoard")
	public String main(Model m, @RequestParam(value = "curPage", defaultValue = "1") int curPage,
			@RequestParam(value = "searchName", required = false) String searchName,
			@RequestParam(value = "searchValue", required = false) String searchValue) {
		//페이지가 지정되지않으면 고정값 1
		//검색필드 전달값으로 작성자, 제목, 내용 으로 검색할 수 있게 함
		PageDTO pDTO = service.select(searchName, searchValue, curPage);
		System.out.println(pDTO);
		
		// 상위 5개 게시글 조회
	    List<TrainerBoardDTO> topPosts = service.selectTopPosts();
		
		List<TrainerBoardDTO> list = pDTO.getList(); //
		System.out.println("list출력" + list);
		m.addAttribute("topPosts", topPosts);
		m.addAttribute("pDTO", pDTO);
		m.addAttribute("searchName", searchName);
		m.addAttribute("searchValue", searchValue);

		return "trainerboard/main"; //main.jsp로
	}

	//페이지상태 유지용 retrieve
	//메인에서 글내용 클릭시 postid랑 curPage 함께 넘겨서 2p에서 글 조회 후 목록보기 누르면 2p로 보이게 함-기존에는 무조건 1로감
	@RequestMapping(value = "/Retrieve/{postid}/{curPage}", method = RequestMethod.GET)
	public String retrieve(@PathVariable("postid") int postid, @PathVariable("curPage") int curPage, Model m) {
		// DTO 조회
		TrainerBoardDTO dto = service.retrieve(postid);

		m.addAttribute("dto", dto);
		m.addAttribute("curPage", curPage);

		// 댓글 조회
		System.out.println("1"+dto);
		List<TrainerBoardCommentDTO> comments = coservice.getCommentsByPostId(postid);
		System.out.println(comments);
		m.addAttribute("comments", comments);

		
		return "trainerboard/retrieve"; // JSP 파일 이름 (retrieve.jsp)
	}
	
	//Write.jsp로 이동 - 글쓰기폼

	@RequestMapping(value = "/trainerboardWrite", method = RequestMethod.GET)
	public String writeForm(Model m, MultipartFile weightimage) {
		
		return "trainerboard/Write"; //
	}

	//글쓰고나면 제목, 내용을 세션에 저장시킴 이미지 여기에 저장하기
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String write(@RequestParam("title") String title, @RequestParam("content") String content,
			HttpSession session,Model m, MultipartFile weightImage) {
		String uploadDir = "C:/images/trainerboard_image/";
		InputStream inputStream = null;
		TrainerBoardDTO dto=null;
		

		try {
			if(!weightImage.isEmpty()) {
				inputStream = weightImage.getInputStream();
				dto = new TrainerBoardDTO();
				dto.setImagename(weightImage.getOriginalFilename());
				// DTO 객체 생성 및 데이터 설정
				
				dto.setTitle(title);
				dto.setContent(content);
				
				// 서비스 호출
				
				weightImage.transferTo(new File(uploadDir +weightImage.getOriginalFilename()));
			}
			
			// 서비스 호출
			service.insert(dto);
			
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				if(inputStream!=null)inputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// 메인 페이지로 리다이렉트
		return "redirect:TrainerBoard"; //저장되고나면 main페이지로 다시 이동
	}

	//update.jsp로 - 수정폼으로
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String showUpdateForm(@RequestParam("postid") int postid, Model m) {
		System.out.println("수정클릭");
		TrainerBoardDTO dto = service.retrieve(postid); // postid받아와서 상세내용 불러오고 
		m.addAttribute("dto", dto);
		return "trainerboard/update"; // update.jsp로
	}

	//수정 후 세션에 저장
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(TrainerBoardDTO dto, HttpSession session,Model m, MultipartFile weightImage ) {
		System.out.println("확인----"+weightImage);
		
		String uploadDir = "C:/images/trainerboard_image/";
		InputStream inputStream = null;
		

		dto.setContent(dto.getContent().replace("\r\n", "<br>"));
		
		try {
			if(!weightImage.isEmpty()) {		
		
		dto.setImagename(weightImage.getOriginalFilename());
		weightImage.transferTo(new File(uploadDir +weightImage.getOriginalFilename()));
		}

			service.update(dto);
		
		}catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				if(inputStream!=null)inputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		session.setAttribute("update", dto);
		return "redirect:retrieve/" + dto.getPostid(); // 수정 후 수정된 게시글 보게
	}

	
	//수정 후에는 게시글 단순조회
	@RequestMapping(value = "/retrieve/{postid}", method = RequestMethod.GET)
	public String retrievePost(@PathVariable("postid") int postid, Model m) {
		TrainerBoardDTO dto = service.retrieve(postid);
		int userid = dto.getUserid();
		String title = dto.getTitle();
		String content = dto.getContent();

		m.addAttribute("dto", dto);
		

		// 댓글 조회
		List<TrainerBoardCommentDTO> comments = coservice.getCommentsByPostId(postid);
		m.addAttribute("comments", comments);

		return "trainerboard/retrieve"; // 게시글 상세 조회 JSP (retrieve.jsp)
	}
	
	
	
	
//삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(@RequestParam(value = "postid", required = false) Integer postid,
			RedirectAttributes redirectAttributes) {
		if (postid == null) {
			redirectAttributes.addFlashAttribute("message", "삭제할 게시글 번호가 유효하지 않습니다.");
			return "redirect:/app/TrainerBoard"; // 유효하지 않은 경우 메인 페이지로 리다이렉트
		}

		try {
			service.delete(postid);
			redirectAttributes.addFlashAttribute("message", "삭제가 완료되었습니다.");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("message", "삭제 중 오류가 발생했습니다.");
			e.printStackTrace();
		}
		return "redirect:TrainerBoard"; // 삭제 후 메인 페이지로 리다이렉트
	}

	
	// 댓글 작성 (일반 댓글 및 대댓글 모두 처리)
    @PostMapping("/writeTrainerboardComment")
    @ResponseBody
    public String writeTrainerboardComment (@ModelAttribute TrainerBoardCommentDTO commentDTO,
            @RequestParam(value = "postid", required = false) Integer postid) {
        System.out.println("commentDTO 전: "+commentDTO);
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
        System.out.println("commentDTO 후: "+commentDTO);
        // 댓글 저장 로직 호출 (서비스 계층으로 위임)
        coservice.addComment(commentDTO);
        System.out.println("comment 추가 완료=============");
        // 성공적으로 저장 후 응답
        return "success";
    }
    
    //댓글 수정
    @PostMapping("/updateTrainerboardComment")
    @ResponseBody
    public String updateTrainerboardComment (@RequestParam("commId") int commId, @RequestParam("commContent") String commContent) {
    	TrainerBoardCommentDTO commentDTO = new TrainerBoardCommentDTO();
        commentDTO.setCommId(commId);
        commentDTO.setCommContent(commContent);
        
        // 댓글 수정 서비스 호출
        coservice.updateTrainerboardComment(commentDTO);
        
        return "success";
    }

    //댓글 삭제 (대댓글도 함께 삭제됨)
    @PostMapping("/deleteTrainerboardComment")
    @ResponseBody
    public String deleteTrainerboardComment (@RequestParam("commId") int commId) {
        // 댓글 삭제 서비스 호출
    	coservice.deleteTrainerboardComment (commId);
        
        return "success";
    }

	

}// main
