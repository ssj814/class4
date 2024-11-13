package com.example.controller.sicdan;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.SicdanDTO;
import com.example.service.sicdan.SicdanService;

@Controller
public class SicdanController {

    @Autowired
    private SicdanService sicdanService;

    // 이미지가 저장될 기본 경로
    private final String uploadPath = "C:/images/sicdan/"; // 실제 파일이 저장될 경로

    /**
     * 게시물 목록 페이지
     * @param searchName 검색할 필드 이름 (예: 제목, 작성자)
     * @param searchValue 검색할 값 (예: 특정 제목 또는 작성자 이름)
     * @param currentPage 현재 페이지 번호 (페이징 처리용)
     * @param model 모델 객체 (뷰에 데이터를 전달하는 용도)
     * @return 게시물 목록 페이지 (sicdan/sicdanList.jsp)
     */
    @RequestMapping("/sicdan_list")
    public String listSicdan(@RequestParam(value = "searchName", required = false) String searchName,
                             @RequestParam(value = "searchValue", required = false) String searchValue,
                             @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
                             Model model) {

        int pageSize = 15; // 페이지당 표시할 게시물 수
        HashMap<String, Object> map = new HashMap<>();
        map.put("searchName", searchName); // 검색할 필드 설정
        map.put("searchValue", searchValue); // 검색할 값 설정
        map.put("startRow", (currentPage - 1) * pageSize + 1); // 현재 페이지의 시작 행
        map.put("endRow", currentPage * pageSize); // 현재 페이지의 마지막 행

        int totalCount = sicdanService.getTotalCount(map); // 총 게시물 수 가져오기
        int totalPages = (int) Math.ceil((double) totalCount / pageSize); // 총 페이지 수 계산
        totalPages = Math.max(totalPages, 1); // 최소 1페이지는 존재하도록 설정

        List<SicdanDTO> list = sicdanService.listAll(map); // 검색 조건에 맞는 게시물 목록 가져오기
        model.addAttribute("list", list); // 게시물 목록을 모델에 추가
        model.addAttribute("currentPage", currentPage); // 현재 페이지 번호를 모델에 추가
        model.addAttribute("totalPages", totalPages); // 총 페이지 수를 모델에 추가
        model.addAttribute("totalCount", totalCount); // 총 게시물 수를 모델에 추가

        return "sicdan/sicdanList"; // 게시물 목록 페이지 반환
    }

    /**
     * 게시물 작성 또는 수정 폼 페이지
     * @param sic_num 게시물 번호 (수정의 경우에 필요, 새 게시물의 경우 null)
     * @param currentPage 현재 페이지 번호
     * @param model 모델 객체
     * @return 게시물 작성 또는 수정 폼 페이지 (sicdan/sicdanForm.jsp)
     */
    @GetMapping("/sicdan_form")
    public String sicdanForm(@RequestParam(value = "num", required = false) Integer sic_num,
                             @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
                             Model model) {
        SicdanDTO dto = new SicdanDTO();
        if (sic_num != null) { // 수정하는 경우
            dto = sicdanService.selectByNum(sic_num); // 게시물 번호로 해당 게시물 조회
            model.addAttribute("isUpdate", true); // 수정 모드 설정
        } else { // 새로 작성하는 경우
            model.addAttribute("isUpdate", false); // 작성 모드 설정
        }
        model.addAttribute("dto", dto); // 게시물 데이터 모델에 추가
        model.addAttribute("currentPage", currentPage); // 현재 페이지 번호 모델에 추가
        return "sicdan/sicdanForm"; // 작성 또는 수정 폼 페이지 반환
    }

    /**
     * 게시물 작성 또는 수정 처리
     * @param dto 게시물 데이터 DTO
     * @param isUpdate 수정 여부 플래그 (true: 수정, false: 새 글 작성)
     * @param redirectAttributes 리다이렉트 시 전달할 메시지를 저장하는 객체
     * @return 게시물 목록 페이지로 리다이렉트
     */
    @PostMapping("/sicdan_submit")
    public String submitSicdan(@ModelAttribute SicdanDTO dto,
                               @RequestParam(value = "isUpdate", defaultValue = "false") boolean isUpdate,
                               RedirectAttributes redirectAttributes) {
        try {
            if (isUpdate) { // 수정 모드일 경우
                sicdanService.updateByNum(dto); // 게시물 업데이트
                redirectAttributes.addFlashAttribute("mesg", "글이 수정되었습니다.");
            } else { // 새로 작성 모드일 경우
                sicdanService.write(dto); // 새 게시물 작성
                redirectAttributes.addFlashAttribute("mesg", "글이 작성되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "글 저장 실패");
        }

        return "redirect:/sicdan_list"; // 목록 페이지로 리다이렉트
    }

    /**
     * 게시물 삭제 처리
     * @param sic_num 삭제할 게시물 번호
     * @param currentPage 현재 페이지 번호
     * @param redirectAttributes 리다이렉트 시 전달할 메시지를 저장하는 객체
     * @return 게시물 목록 페이지로 리다이렉트
     */
    @GetMapping("/sicdan_delete")
    public String deleteSicdan(@RequestParam("num") int sic_num,
                               @RequestParam("currentPage") int currentPage,
                               RedirectAttributes redirectAttributes) {
        int result = sicdanService.deleteNum(sic_num); // 게시물 삭제
        if (result == 1) {
            redirectAttributes.addFlashAttribute("mesg", "글을 삭제하였습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "글을 삭제하지 못하였습니다.");
        }
        return "redirect:sicdan_list?currentPage=" + currentPage; // 목록 페이지로 리다이렉트
    }

    /**
     * 게시물 상세 조회 페이지
     * @param sic_num 조회할 게시물 번호
     * @param currentPage 현재 페이지 번호
     * @param model 모델 객체
     * @param redirectAttributes 리다이렉트 시 전달할 메시지를 저장하는 객체
     * @return 게시물 상세 페이지 (sicdan/sicdanRetrieve.jsp)
     */
    @GetMapping("/sicdan_retrieve")
    public String retrieveSicdan(@RequestParam("num") int sic_num,
                                 @RequestParam("currentPage") int currentPage,
                                 Model model, RedirectAttributes redirectAttributes) {
        SicdanDTO dto = sicdanService.selectByNum(sic_num); // 게시물 번호로 조회
        if (dto == null) { // 게시물이 존재하지 않을 경우
            redirectAttributes.addFlashAttribute("error", "해당 게시물이 존재하지 않습니다.");
            return "redirect:sicdan_list?currentPage=" + currentPage; // 목록 페이지로 리다이렉트
        }
        model.addAttribute("retrive", dto); // 조회한 게시물 데이터를 모델에 추가
        model.addAttribute("currentPage", currentPage); // 현재 페이지 번호 모델에 추가
        return "sicdan/sicdanRetrieve"; // 상세 조회 페이지 반환
    }

    /**
     * 이미지 업로드 처리
     * @param file 업로드할 이미지 파일 (MultipartFile)
     * @return 업로드된 이미지의 URL을 응답
     */
    @PostMapping("/sicdan/imageUpload")
    public ResponseEntity<String> imageUpload(@RequestParam("file") MultipartFile file) {
        try {
            // 업로드할 파일의 이름과 확장자 생성
            String originalFileName = file.getOriginalFilename(); // 원본 파일 이름
            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 확장자 추출
            String reFileName = UUID.randomUUID().toString() + fileExtension; // 고유한 파일명 생성

            // 파일을 저장할 경로 설정
            Path path = Paths.get(uploadPath + reFileName);
            Files.createDirectories(path.getParent()); // 필요한 경우 디렉토리 생성
            file.transferTo(path.toFile()); // 파일 저장

            // 업로드된 파일의 접근 가능한 URL 생성
            String fileUrl = "http://localhost:8090/app/images/sicdan/" + reFileName;
            return ResponseEntity.ok(fileUrl); // URL을 클라이언트에 반환
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body("이미지 업로드 실패");
        }
    }

    /**
     * 이미지 삭제 처리
     * @param fileUrl 삭제할 이미지 파일의 URL
     * @return 삭제 성공 여부 메시지
     */
    @PostMapping("/sicdan/imageDelete")
    public ResponseEntity<String> deleteImage(@RequestParam("fileUrl") String fileUrl) {
        try {
            // fileUrl에서 파일명만 추출하여 실제 파일 경로 생성
            String fileName = Paths.get(fileUrl).getFileName().toString();
            Path filePath = Paths.get("C:/images/sicdan/" + fileName);

            // 파일이 존재하는지 확인하고 삭제
            if (Files.exists(filePath)) {
                Files.delete(filePath); // 파일 삭제
                return ResponseEntity.ok("이미지 삭제 성공");
            } else {
                return ResponseEntity.badRequest().body("이미지를 찾을 수 없습니다.");
            }
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body("이미지 삭제 실패");
        }
    }
}
