package com.example.controller.trainer;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
import com.example.entity.User;
import com.example.repository.UserRepository;
import com.example.service.trainer.TrainerBoardCommentService;
import com.example.service.trainer.TrainerBoardService;

import jakarta.servlet.http.HttpSession;

@Controller
public class TrainerBoardController {

	@Autowired
	TrainerBoardService service;
	@Autowired
	TrainerBoardCommentService coservice;
	@Autowired
	UserRepository UserRepository;

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
		System.out.println("111 "+dto);
		List<TrainerBoardCommentDTO> comments = coservice.getCommentsByPostId(postid);
		System.out.println("222 "+comments);
		m.addAttribute("comments", comments);

		
		return "trainerboard/retrieve"; // JSP 파일 이름 (retrieve.jsp)
	}
	
	//Write.jsp로 이동 - 글쓰기폼

	@RequestMapping(value = "/trainerboardWrite", method = RequestMethod.GET)
	public String writeForm(Model m, MultipartFile weightimage) {
		
		return "trainerboard/Write"; //
	}

	//글쓰고나면 제목, 내용을 세션에 저장시킴 이미지 여기에 저장하기
	@RequestMapping(value = "/trainer/write", method = RequestMethod.POST)
	public String write(@RequestParam("title") String title, @RequestParam("content") String content,
			HttpSession session,Model m, MultipartFile weightImage, TrainerBoardDTO dto) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userid = authentication.getName();
		User user = UserRepository.findByUserid(userid).orElse(null);
		//회원db에 있는 정보 전체 꺼내오기
		String realUsername=user.getRealusername();
		//회원db에있는 user 전체 가져와서 내 dto의 realUsername에 담기
		
		System.out.println("realusername"+realUsername);
		
		String uploadDir = "C:/images/trainerboard_image/";	 //이미지 저장 경로:C에 images폴더에 trainerboard_images에 저장
		File uploadDirectory = new File(uploadDir); // uploadDir로 지정된 경로에 대한 File 객체를 생성
        if (!uploadDirectory.exists()) {
            uploadDirectory.mkdirs(); //폴더없으면 생성
        }
        
		UUID uuid = UUID.randomUUID(); //Java에서 고유한 식별자인 UUID(Universally Unique Identifier)를 생성하는 코드
		InputStream inputStream = null; //InputStream:이미지 파일의 데이터를 읽는 데 사용

		try {
			if(!weightImage.isEmpty()) {
				inputStream = weightImage.getInputStream(); //업로드된 파일의 내용을 읽기 위한 InputStream을 반환
				String imgName = uuid + weightImage.getOriginalFilename(); //업로드된 파일의 원래 이름을 반환
				//String userid2 = authentication.getName();
				dto.setImagename(imgName);
				dto.setTitle(title);
				dto.setContent(content);
				dto.setUserid(userid);
				dto.setRealUsername(realUsername);
				
				System.out.println("realUsername: " + dto.getRealUsername());
				
				weightImage.transferTo(new File(uploadDir + imgName)); //파일의 내용을 지정된 위치로 직접 저장
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
		return "redirect:/TrainerBoard"; //저장되고나면 main페이지로 다시 이동
	}

	//update.jsp로 - 수정폼으로
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String showUpdateForm(@RequestParam("postid") int postid, Model m) {
		
		TrainerBoardDTO dto = service.retrieve(postid); // postid받아와서 상세내용 불러오고 
		m.addAttribute("dto", dto);
		return "trainerboard/update"; // update.jsp로
	}

	//수정 후 세션에 저장
	@RequestMapping(value = "/trainer/update", method = RequestMethod.POST)
	public String update(TrainerBoardDTO dto, HttpSession session, Model m, MultipartFile weightImage) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userid = authentication.getName();
		
	    String uploadDir = "C:/images/trainerboard_image/";
	    InputStream inputStream = null;

	    // 콘텐츠 줄 바꿈을 <br>로 변환
	    dto.setContent(dto.getContent().replace("\r\n", "<br>"));
	    
	 // 수정하려는 게시글의 작성자와 로그인된 사용자가 일치하는지 확인
        TrainerBoardDTO existingDto = service.retrieve(dto.getPostid());
        if (existingDto == null || !existingDto.getUserid().equals(userid)) {
            // 작성자가 다르면 수정 불가 처리
        	System.out.println(userid + "==="+existingDto);
            return "redirect:/TrainerBoard"; // 권한이 없으므로 메인 페이지로 리다이렉트
        }
        
	    try {
	        // 기존 이미지가 있을 경우
	        if (dto.getImagename() != null) { 
	            File oldImageFile = new File(uploadDir + dto.getImagename());
	           
	            if (oldImageFile.exists()) {
	                // 새 이미지가 있는 경우에만 기존 이미지 삭제
	                if (!weightImage.isEmpty()) {
	                    oldImageFile.delete(); // 기존 이미지 삭제
	                }
	            }
	        }

	        // 새 이미지가 있는 경우
	        if (!weightImage.isEmpty()) {
	            String newImageName = UUID.randomUUID() + weightImage.getOriginalFilename();
	            dto.setImagename(newImageName); // 새로운 이미지 이름 설정
	            weightImage.transferTo(new File(uploadDir + newImageName)); // 새로운 이미지 저장
	        }

	        // 게시글 업데이트
	        service.update(dto);

	    } catch (IOException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (inputStream != null) inputStream.close();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }

	    session.setAttribute("update", dto);
	    return "redirect:/retrieve/" + dto.getPostid(); // 수정 후 수정된 게시글 보기
	}


	
	//수정 후에는 게시글 단순조회
	@RequestMapping(value = "/retrieve/{postid}", method = RequestMethod.GET)
	public String retrievePost(@PathVariable("postid") int postid, Model m) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userid = authentication.getName();
		
		TrainerBoardDTO dto = service.retrieve(postid);
		String title = dto.getTitle();
		String content = dto.getContent();

		m.addAttribute("dto", dto);
		

		// 댓글 조회
		List<TrainerBoardCommentDTO> comments = coservice.getCommentsByPostId(postid);
		m.addAttribute("comments", comments);

		return "trainerboard/retrieve"; // 게시글 상세 조회 JSP (retrieve.jsp)
	}
	
	
	
	
//삭제
	@RequestMapping(value = "/trainer/delete", method = RequestMethod.POST)
	public String delete(@RequestParam(value = "postid", required = false) Integer postid,
	                     RedirectAttributes redirectAttributes) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userid = authentication.getName();
		
	    if (postid == null) {
	        redirectAttributes.addFlashAttribute("message", "삭제할 게시글 번호가 유효하지 않습니다.");
	        return "redirect:/app/TrainerBoard";
	    }

	    try {
            // 게시글 정보 조회
            TrainerBoardDTO dto = service.retrieve(postid);
            if (dto == null || !dto.getUserid().equals(userid)) {
                // 작성자가 다르면 삭제 불가 처리
                redirectAttributes.addFlashAttribute("message", "권한이 없습니다.");
                return "redirect:/TrainerBoard";
            }
	        String imgName = dto.getImagename();
	        
	        // 이미지 파일 삭제
	        if (imgName != null) {
	            String uploadDir = "C:/images/trainerboard_image/";
	            File imageFile = new File(uploadDir + imgName);
	            if (imageFile.exists()) {
	                imageFile.delete(); // 이미지 파일 삭제
	            }
	        }

	        // 게시글 삭제
	        service.delete(postid);
	        redirectAttributes.addFlashAttribute("message", "삭제가 완료되었습니다.");
	    } catch (Exception e) {
	        redirectAttributes.addFlashAttribute("message", "삭제 중 오류가 발생했습니다.");
	        e.printStackTrace();
	    }
	    return "redirect:/TrainerBoard";
	}

	
	// 댓글 작성 (일반 댓글 및 대댓글 모두 처리)
    @PostMapping("/writeTrainerboardComment")
    @ResponseBody
    public String writeTrainerboardComment (@ModelAttribute TrainerBoardCommentDTO commentDTO,
            @RequestParam(value = "postid", required = false) Integer postid) {
    	
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = authentication.getName();
		
		User user = UserRepository.findByUserid(userId).orElse(null);
		//회원db에 있는 정보 전체 꺼내오기
		String realUsername=user.getRealusername();
		//회원db에있는 user 전체 가져와서 내 dto의 realUsername에 담기

		System.out.println("=====댓글확인====="+userId);
		System.out.println("=====댓글username확인======"+realUsername);
		
	    // 로그인하지 않은 경우 (익명 사용자)
	    if (userId.equals("anonymousUser")) {
	        return "로그인이 필요합니다.";  // 익명 사용자 (로그인하지 않은 경우)
	    }
		
		if (userId == null || userId.isEmpty()) {
	        return "로그인이 필요합니다.";  // 로그인하지 않은 경우
	    }
		
        System.out.println("commentDTO 전: "+commentDTO);
        // 부모 댓글 ID가 없으면 일반 댓글, 있으면 대댓글로 처리
        if (commentDTO.getTr_ParentId() == null || commentDTO.getTr_ParentId() == 0) {
            // 일반 댓글인 경우
            commentDTO.setTr_RepIndent(0); // 일반 댓글은 들여쓰기 없음
            commentDTO.setPostid(postid);  // 일반 댓글은 postid를 따로 설정해줌
        } else {
            // 대댓글의 경우, commentDTO에 이미 postid가 포함되어 있을 가능성이 있음
            if (commentDTO.getPostid() == 0) {
                commentDTO.setPostid(postid);  // 만약 postid가 없으면 추가 설정
                System.out.println(commentDTO);
            }
            // repIndent는 JSP에서 받아온 값을 그대로 사용
        }
       
        // 로그인된 사용자 ID를 댓글 DTO에 설정
        commentDTO.setUserId(userId);
        commentDTO.setRealUsername(realUsername);
        System.out.println("commentDTO에 담겼나 확인 ======"+realUsername);
        
        System.out.println("TrainerBoardCommentDTO 후: "+commentDTO);
        // 댓글 저장 로직 호출 (서비스 계층으로 위임)
        coservice.addComment(commentDTO);
        System.out.println("TrainerBoardCommentDTO 추가 완료=============");
        // 성공적으로 저장 후 응답
        return "success";
    }
    
    //댓글 수정
    @PostMapping("/updateTrainerboardComment")
    @ResponseBody
    public String updateTrainerboardComment (@RequestParam("commId") int commId, @RequestParam("commContent") String commContent) {
    	
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userid = authentication.getName();
    	
    	System.out.println("111"+commId + commContent);
    	TrainerBoardCommentDTO commentDTO = new TrainerBoardCommentDTO();
        commentDTO.setCommId(commId);
        commentDTO.setCommContent(commContent);
        
        // 댓글 수정 서비스 호출
        coservice.updateTrainerboardComment(commentDTO);
        
     // 댓글 작성자와 로그인된 사용자가 일치하는지 확인
        if (commentDTO != null && commentDTO.getUserId() != null && commentDTO.getUserId().equals(userid)) {
            commentDTO.setCommContent(commContent);  // 수정된 댓글 내용 설정
            coservice.updateTrainerboardComment(commentDTO);  // 댓글 수정

            return "success";
        } else {
            return "권한이 없습니다.";  // 작성자만 수정 가능
        }
    }
    

    //댓글 삭제 (대댓글도 함께 삭제됨)
    @PostMapping("/deleteTrainerboardComment")
    @ResponseBody
    public String deleteTrainerboardComment (@RequestParam("commId") int commId) {
    	
    	 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	    String userId = authentication.getName(); // 현재 로그인된 사용자 ID

    	    // 해당 댓글을 가져옵니다.
    	    TrainerBoardCommentDTO commentDTO = coservice.getCommentByPostId(commId); // commId로 댓글 조회

    	    // 댓글이 존재하고 작성자와 로그인된 사용자가 일치하는지 확인
    	    if (commentDTO != null && commentDTO.getUserId().equals(userId)) {
    	        // 댓글 및 대댓글 삭제
    	        coservice.deleteTrainerboardComment(commId); // 댓글 삭제
    	        return "success"; // 삭제 성공
    	    } else {
    	        return "권한이 없습니다."; // 작성자만 삭제 가능
    	    }
    	}
    


}// main
