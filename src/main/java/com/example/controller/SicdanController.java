package com.example.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.SicdanDTO;
import com.example.service.SicdanService;

/**
 * 게시판 컨트롤러 클래스입니다.
 * '/sicdan' 경로로 들어오는 요청을 처리합니다.
 */
@Controller
@RequestMapping("/sicdan")  // '/sicdan' 경로에 매핑
public class SicdanController {

    @Autowired
    private SicdanService sicdanService; // 서비스 클래스 주입

    /**
     * 게시물 목록 조회 메서드입니다.
     *
     * @param searchName  검색할 컬럼 이름
     * @param searchValue 검색할 값
     * @param currentPage 현재 페이지 번호
     * @param model       모델에 데이터를 저장
     * @return 게시물 목록을 보여줄 JSP 페이지 이름
     */
    @GetMapping("/list")
    public String listSicdan(@RequestParam(value = "searchName", required = false) String searchName,
                             @RequestParam(value = "searchValue", required = false) String searchValue,
                             @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
                             Model model) {

        int pageSize = 15; // 페이지당 게시물 수
        HashMap<String, Object> map = new HashMap<>();
        map.put("searchName", searchName);
        map.put("searchValue", searchValue);
        map.put("startRow", (currentPage - 1) * pageSize + 1);
        map.put("endRow", currentPage * pageSize);

        // 전체 게시물 수 가져오기
        int totalCount = sicdanService.getTotalCount(map);
        // 전체 페이지 수 계산
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        // 게시물 목록 가져오기
        List<SicdanDTO> list = sicdanService.listAll(map);

        // 모델에 데이터 저장
        model.addAttribute("list", list);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);

        return "sicdan/sicdanList"; // sicdanList.jsp로 이동
    }

    /**
     * 게시물 작성 및 수정 폼을 보여주는 메서드입니다.
     *
     * @param sic_num     게시물 번호 (수정 시 사용)
     * @param currentPage 현재 페이지 번호
     * @param model       모델에 데이터를 저장
     * @return 게시물 작성/수정 폼을 보여줄 JSP 페이지 이름
     */
    @GetMapping("/form")
    public String sicdanForm(@RequestParam(value = "num", required = false) Integer sic_num,
                             @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
                             Model model) {
        SicdanDTO dto = new SicdanDTO();
        if (sic_num != null) {  // 수정인 경우 기존 데이터 로드
            dto = sicdanService.selectByNum(sic_num);
            model.addAttribute("isUpdate", true);  // 수정 여부 전달
        } else {
            model.addAttribute("isUpdate", false); // 신규 작성 여부 전달
        }
        model.addAttribute("dto", dto);
        model.addAttribute("currentPage", currentPage);
        return "sicdan/sicdanForm";  // 작성/수정 폼으로 이동
    }

    /**
     * 게시물 작성 및 수정 처리 메서드입니다.
     *
     * @param dto        게시물 데이터
     * @param isUpdate   수정 여부
     * @param currentPage 현재 페이지 번호
     * @return 게시물 목록으로 리디렉션
     */
    @PostMapping("/submit")
    public String submitSicdan(@ModelAttribute SicdanDTO dto,
                               @RequestParam(value = "isUpdate", defaultValue = "false") boolean isUpdate,
                               @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
                               RedirectAttributes redirectAttributes) {
        if (isUpdate) {
            sicdanService.updateByNum(dto);  // 수정 처리
            redirectAttributes.addFlashAttribute("mesg", "글이 수정되었습니다.");
        } else {
            sicdanService.write(dto);  // 작성 처리
            redirectAttributes.addFlashAttribute("mesg", "글이 작성되었습니다.");
        }
        return "redirect:/sicdan/list?currentPage=" + currentPage;  // 처리 후 목록으로 이동
    }


    /**
     * 게시물 삭제 메서드입니다.
     *
     * @param sic_num    게시물 번호
     * @param currentPage 현재 페이지 번호
     * @param model       모델에 데이터를 저장
     * @return 게시물 목록으로 리디렉션
     */
    @GetMapping("/delete")
    public String deleteSicdan(@RequestParam("num") int sic_num,
                               @RequestParam("currentPage") int currentPage,
                               RedirectAttributes redirectAttributes) {
        int result = sicdanService.deleteNum(sic_num);
        if (result == 1) {
            redirectAttributes.addFlashAttribute("mesg", "글을 삭제하였습니다.");
        } else {
            redirectAttributes.addFlashAttribute("mesg", "글을 삭제하지 못하였습니다.");
        }
        return "redirect:/sicdan/list?currentPage=" + currentPage;
    }

    /**
     * 게시물 상세 조회 메서드입니다.
     *
     * @param sic_num    게시물 번호
     * @param currentPage 현재 페이지 번호
     * @param model       모델에 데이터를 저장
     * @return 게시물 상세보기 페이지로 이동
     */
    @GetMapping("/retrieve")
    public String retrieveSicdan(@RequestParam("num") int sic_num,
                                 @RequestParam("currentPage") int currentPage,
                                 Model model) {
        SicdanDTO dto = sicdanService.selectByNum(sic_num);
        model.addAttribute("retrive", dto);
        model.addAttribute("currentPage", currentPage);
        return "sicdan/sicdanRetrieve"; // sicdanRetrieve.jsp로 이동
    }
}
