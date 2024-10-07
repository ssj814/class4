package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.dto.ContestCommentDTO;
import com.example.dto.ContestPost;
import com.example.dto.ContestReplyDTO;
import com.example.service.ContestCommentService;
import com.example.service.ContestPostService;
import com.example.service.ContestReplyService;

import jakarta.servlet.http.HttpSession;



@Controller
public class FitnessContestMain {
@Autowired
ContestPostService service;
@Autowired
ContestCommentService service2;
@Autowired
ContestReplyService service3;
	@RequestMapping("/FitnessContest")// 운동대회 시작 => main
	public ModelAndView FitnessContestPage(HttpSession session, String page) {
		System.out.println("접속");
		session.setAttribute("userid", "1");//임시로  로그인정보 입력
		int postsPerPage = 20;  // 한 페이지에 표시할 게시물 수
        int currentPage = 1;    // 기본 현재 페이지
        if (page != null) {
            currentPage = Integer.parseInt(page);
        }
        int startRow = (currentPage - 1) * postsPerPage + 1; // 시작행
        int endRow = currentPage * postsPerPage; //끝행
        Map<String, Integer> params = new HashMap<String, Integer>();// 시작과 끝행  map에 저장
        params.put("startRow", startRow);
        params.put("endRow", endRow);
      
        
        
        List<ContestPost> posts = service.getPostsByPage(params); //게시글 조회
        int totalPosts = service.getTotalPosts(); // 전체 게시글 수 카운팅
        int totalPages = totalPosts / postsPerPage; //전체 게시글 /20 페이지 수 
        if (totalPosts % postsPerPage != 0) {// /20 에서 나머지 발생 시 페이지 수 ++
            totalPages++;
        }

        int pageBlock = 4;  // 한 번에 표시할 페이지 번호의 개수
        int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1; //시작페이지
        int endPage = startPage + pageBlock - 1; //마지막 페이지
        if (endPage > totalPages) {//끝페이지가 전체페이지를 초과하지 않도록
            endPage = totalPages;
        }
        ModelAndView mav = new ModelAndView();
        mav.addObject("posts", posts);
        mav.addObject("currentPage", currentPage);
        mav.addObject("totalPages", totalPages);
        mav.addObject("startPage", startPage);
        mav.addObject("endPage", endPage);
        mav.setViewName("contest/fitnessContest");// jsp 이름
		return mav;
		}
	@RequestMapping("/FitnessContent")// 글내용
	public ModelAndView FitnessContent(@RequestParam("postid") String postid) {
		ContestPost content= service.Content(postid); //글제목 postid에 해당하는 글내용불러오기
		List<ContestCommentDTO> comments =service2.commtSelect(postid);//글제목에 해당 postid 댓글 불러오기
		List<ContestReplyDTO> replys = service3.getRepliesByCommentId(postid);//글제목에 해당 postid 대댓글 불러오기
		ModelAndView mav = new ModelAndView();
		mav.addObject("content",content);
		mav.addObject("comments",comments);
		mav.addObject("replys",replys);
		mav.setViewName("contest/content");
		return mav;
	}
	@RequestMapping("/DeletePost")
	public String DeletePost(ContestPost dto ) {
		service.deltContent(dto);
		return"redirect:FitnessContest";
	}
	@RequestMapping("/UpdatePost")
	public String UpdatePost(ContestPost dto){
		service.UpdatePost(dto);
		return"redirect:FitnessContent?postid="+dto.getPostid();
	}
	@RequestMapping("/ContentInsert")
	public String ContentInsert(ContestPost dto) {
		service.contentInsert(dto);
		return"redirect:FitnessContest";
	}
	@RequestMapping("/SearchContent")
	public ModelAndView SearchContent(@RequestParam(value = "page", required = false, defaultValue = "1") String pageParam, @RequestParam("select") String select
			, @RequestParam("text") String text) {
		 int currentPage=0;
		 // 검색 조건이 있다면 검색을 새로 시작한 것이므로 무조건 1페이지부터 시작
 	    if (select != null && !select.isEmpty() && text != null && !text.isEmpty()) {
 	        currentPage = 1;
 	    } else {
 	        // 페이지 이동일 경우 페이지 번호를 받아서 처리
 	        currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;
 	    }

 	    int postsPerPage = 20;

 	    int startRow = (currentPage - 1) * postsPerPage + 1;
 	    int endRow = currentPage * postsPerPage;

 	    
 	    List<ContestPost> posts = null;
 	    int totalPosts = 0;
 	    HashMap<String, Object> params = new HashMap<String, Object>();
 	    params.put("startRow", startRow);
 	    params.put("endRow", endRow);

 	    if ("작성자".equals(select)) {
 	        params.put("writer", text);
 	        posts = service.writerSearch(params);
 	        totalPosts = service.getWriterSearchCount(text);
 	    } else {
 	        params.put("content", text);
 	        posts = service.ContentSearch(params);
 	        totalPosts = service.getContentSearchCount(text);
 	    }

 	    int totalPages = (int) Math.ceil((double) totalPosts / postsPerPage);

 	    int pageBlock = 4;
 	    int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
 	    int endPage = startPage + pageBlock - 1;
 	    if (endPage > totalPages) {
 	        endPage = totalPages;
 	    }
 	    ModelAndView mav = new ModelAndView();
 	    mav.addObject("posts", posts);
 	    mav.addObject("currentPage", currentPage);
 	    mav.addObject("totalPages", totalPages);
 	    mav.addObject("startPage", startPage);
 	    mav.addObject("endPage", endPage);
 	    mav.setViewName("contest/searchresult");
 	    return mav;
	}
	@RequestMapping(value = "UpdatePostUI")
	public String UpdatePostUI(ContestPost dto, Model m) {
		m.addAttribute("content", dto);
		return "contest/updatePostUI";
	}
	@RequestMapping(value = "Write")
	public String insert() {
		
		return "insert";
	}
	
}
