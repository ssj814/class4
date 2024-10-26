package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.TrainerDTO;
import com.example.service.TrainerDBOracleService;

@Controller
@RequestMapping
public class TrainerController {

    @Autowired
    TrainerDBOracleService service;
    
    @RequestMapping("/trainer_list")
    public String trainerList(
            @RequestParam(required = false) String field,
            @RequestParam(required = false) String searchType,
            @RequestParam(required = false) String searchVal,
            @RequestParam(required = false) Integer page,
            Model m
            ) {
        int listPerPage = 5;
        int currentPage = 1;
         
        if(page != null) currentPage = page;
        
        int startRow = (currentPage-1) * listPerPage + 1;
        int endRow = currentPage * listPerPage;
        
        Map<String, Object> params = new HashMap<>();
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        params.put("field", field);
        params.put("searchType", searchType);
        params.put("searchVal", searchVal);
        
        List<TrainerDTO> posts = service.getlistsByPage(params);
        
        int totalLists = service.getTotalLists(params);
        int totalPages = totalLists / listPerPage;
        if (totalLists % listPerPage != 0) {
            totalPages++;
        }
        
        int pageBlock = 5;
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
                
        return "trainer/trainerList";
    }
    
    @GetMapping("/trainer_join")
    public String trainerJoin1() {
        return "trainer/trainerAdd";
    }

    @PostMapping("/trainer_join")
    public String trainerJoin2(@RequestParam("trainer_img_url") MultipartFile trainer_img_url, @ModelAttribute TrainerDTO trainer, RedirectAttributes ra) {
        String uploadDir = "C:/images/trainer_images/"; // 이미지 저장 경로
        InputStream inputStream = null;
        
        try {
            inputStream = trainer_img_url.getInputStream();
            String fileName = trainer_img_url.getOriginalFilename();
            trainer.setImg_name(fileName);
            trainer.setImg_url(uploadDir + fileName);
            service.insertTrainer(trainer); // 데이터베이스에 트레이너 정보 저장
            trainer_img_url.transferTo(new File(uploadDir + fileName)); // 이미지 파일 저장
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (inputStream != null) inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        ra.addFlashAttribute("mesg", "트레이너 등록 완료");
        return "redirect:/trainer_list";
    }
    
    @GetMapping("/trainer_info")
    public String info(@RequestParam Integer idx, Model m) {
        TrainerDTO dto = service.selectTrainer(idx);
        m.addAttribute("info", dto);
        return "trainer/trainerInfo";
    }
    
    @GetMapping("/trainer_modify")
    public String modify(@RequestParam Integer idx, Model m) {
        TrainerDTO dto = service.selectTrainer(idx);
        m.addAttribute("info", dto);
        return "trainer/trainerEdit";
    }
    
    @PostMapping("/trainer_modify")
    public String modify2(@RequestParam("trainer_img_url") MultipartFile trainer_img_url, 
                          @ModelAttribute TrainerDTO trainer, RedirectAttributes ra) {
        String uploadDir = "C:/images/trainer_images/";

        // 트레이너의 기존 이미지 정보를 가져옴
        TrainerDTO existingTrainer = service.selectTrainer(trainer.getTrainer_id());

        try {
            // 이미지 파일이 업로드된 경우에만 이미지 변경
            if (!trainer_img_url.isEmpty()) {
                String fileName = trainer_img_url.getOriginalFilename();
                trainer.setImg_name(fileName); // DTO에 파일 이름을 설정
                trainer.setImg_url(uploadDir + fileName); // DTO에 파일 경로 설정
                trainer_img_url.transferTo(new File(uploadDir + fileName)); // 파일 저장
            } else {
                // 이미지 파일이 없으면 기존 이미지를 유지
                trainer.setImg_name(existingTrainer.getImg_name());
                trainer.setImg_url(existingTrainer.getImg_url());
            }

            // 트레이너 정보 업데이트
            service.updateTrainer(trainer);
            
        } catch (IOException e) {
            e.printStackTrace();
        }

        ra.addAttribute("idx", trainer.getTrainer_id());
        ra.addFlashAttribute("mesg", "트레이너 정보 수정 완료");
        return "redirect:/trainer_info";
    }


    
    @RequestMapping("/trainer_deletion")
    public String delete(@RequestParam Integer idx, RedirectAttributes ra) {
        // 먼저 트레이너 정보를 가져옴
        TrainerDTO dto = service.selectTrainer(idx);	

        // 트레이너 정보가 없으면 삭제 실패 메시지를 전송하고 반환
        if (dto == null) {
            ra.addFlashAttribute("mesg", "트레이너 정보를 찾을 수 없습니다.");
            return "redirect:/trainer_list";
        }

        // 트레이너 정보 삭제 처리
        int n = service.deleteTrainer(idx);

        // 트레이너 정보가 삭제되면 이미지 파일도 삭제
        String imgName = dto.getImg_name();
        if (imgName != null) {
            String uploadDir = "C:/images/trainer_images/";
            File file = new File(uploadDir + imgName);
            if (file.exists()) {
                file.delete(); // 파일 삭제
            }
        }

        String mesg = (n == 1) ? "트레이너 정보 삭제 완료" : "트레이너 정보 삭제 실패";
        ra.addFlashAttribute("mesg", mesg);

        return "redirect:/trainer_list";
    }
}
