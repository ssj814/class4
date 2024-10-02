package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dto.ProductDTO;
import com.example.dto.ProductReviewDTO;
import com.example.service.ProductReviewService;
import com.example.service.ProductService;

@Controller
public class ProductReviewController {

	@Autowired
	ProductService productService;
	
	@Autowired
	ProductReviewService productReviewService;

	@GetMapping("/shop_productReview/{productId}") // 리뷰등록페이지 이동
	public String getProductReview(@PathVariable int productId, Model m) {
		ProductDTO productDTO = productService.selectDetailproduct(productId);
		m.addAttribute("productDTO", productDTO);
		return "shoppingMall/shopReviewForm";
	}

	@PostMapping("/shop_productReview") // 리뷰 insert
	public String postProductReview(ProductReviewDTO productReviewDTO, MultipartFile[] multipartFilePhotos,
			RedirectAttributes redirectAttributes) {
		String uploadDir = "C:/images/shoppingMall_review/"; // 이미지 저장 경로
		UUID uuid = UUID.randomUUID();
		InputStream inputStream = null;
		List<String> imgs = new ArrayList<String>();
		String imgNames = "";
		int num = 0;
		int user_id = 1; // 임시 유저
		
		try {
			for (MultipartFile img : multipartFilePhotos) {
				inputStream = img.getInputStream();
				String imgName = uuid + img.getOriginalFilename();
				imgs.add(imgName);
				imgNames += imgName + ",";
			}
						
			productReviewDTO.setUser_id(user_id);
			productReviewDTO.setPhotos(imgNames.replaceAll(",$", "")); //맨 마지막 콤마 제거

			num = productReviewService.insertReview(productReviewDTO);
			
			for (MultipartFile img : multipartFilePhotos) {
				inputStream = img.getInputStream();
				String imgName = uuid + img.getOriginalFilename();
				img.transferTo(new File(uploadDir + imgName));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				if(inputStream!=null)inputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		String mesg = "";
		if (num == 1) {
			mesg = "리뷰가 등록되었습니다.";
		} else {
			mesg = "리뷰 등록 실패!";
		}
		redirectAttributes.addFlashAttribute("mesg", mesg);
		redirectAttributes.addFlashAttribute("closeWindow", true);
		return "redirect:/shop_productReview/" + productReviewDTO.getProduct_id();
	}

}
