package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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

	@GetMapping("/shop_productReview/{productId}") // 리뷰 등록페이지 이동
	public String getProductReview(@PathVariable int productId, Model m) {
		ProductDTO productDTO = productService.selectDetailproduct(productId);
		m.addAttribute("productDTO", productDTO);
		return "shoppingMall/shopReviewForm";
	}

	@Transactional
	@PostMapping("/shop_productReview") // 리뷰 insert
	public String postProductReview(ProductReviewDTO productReviewDTO, MultipartFile[] multipartFilePhotos,
			RedirectAttributes redirectAttributes) {
		System.out.println(productReviewDTO.getContent());
		String uploadDir = "C:/images/shoppingMall_review/";
		UUID uuid = UUID.randomUUID();
		InputStream inputStream = null;
		String imgNames = "";
		int num = 0;
		int user_id = 1; // 임시 유저
		try {
			if (!multipartFilePhotos[0].isEmpty()) {
				for (MultipartFile img : multipartFilePhotos) {
					inputStream = img.getInputStream();
					String imgName = uuid + img.getOriginalFilename();
					imgNames += imgName + ","; // DB저장용
					img.transferTo(new File(uploadDir + imgName));
				}
				productReviewDTO.setPhotos(imgNames.replaceAll(",$", ""));
			}
			productReviewDTO.setUser_id(user_id);
			num = productReviewService.insertReview(productReviewDTO);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (inputStream != null) inputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		String mesg = "";
		if (num == 1) {
			mesg = "리뷰가 등록되었습니다.";
		} else {
			mesg = "리뷰 등록 실패";
		}
		redirectAttributes.addFlashAttribute("mesg", mesg);
		redirectAttributes.addFlashAttribute("closeWindow", true);
		return "redirect:/shop_productReview/" + productReviewDTO.getProduct_id();
	}

	@Transactional
	@ResponseBody
	@DeleteMapping("/shop_productReview/{reviewId}") // 리뷰 delete
	public void delProductReview(@PathVariable int reviewId) {
		ProductReviewDTO productReviewDTO = productReviewService.selectReview(reviewId);
		if (productReviewDTO.getPhotos() != null) {
			String[] imgNames = productReviewDTO.getPhotos().split(",");
			String uploadDir = "C:/images/shoppingMall_review/";
			for (String imgName : imgNames) {
				File file = new File(uploadDir + imgName);
				file.delete(); // 파일이미지 삭제
			}
		}
		productReviewService.deleteReview(reviewId);
	}
	
	@GetMapping("/shop_productReview_update/{reviewid}") // 리뷰 수정페이지 이동
	public String getProductReview_update(@PathVariable int reviewid, Model m) {
		ProductReviewDTO productReviewDTO = productReviewService.selectReview(reviewid);
		ProductDTO productDTO = productService.selectDetailproduct(productReviewDTO.getProduct_id());
		m.addAttribute("productReviewDTO", productReviewDTO);
		m.addAttribute("productDTO", productDTO);
		return "shoppingMall/shopReviewForm";
	}
	
	@Transactional
	@PostMapping("/shop_productReview_update/{reviewid}") // 리뷰 update
	public String postProductReview_update(ProductReviewDTO productReviewDTO, MultipartFile[] multipartFilePhotos, 
			RedirectAttributes redirectAttributes) {
		String uploadDir = "C:/images/shoppingMall_review/";
		UUID uuid = UUID.randomUUID();
		InputStream inputStream = null;
		String imgNames = "";
		int num = 0;
		int user_id = 1; // 임시 유저
		try {
			if (!multipartFilePhotos[0].isEmpty()) {
				//기존 이미지 삭제
				ProductReviewDTO pre_productReviewDTO = productReviewService.selectReview(productReviewDTO.getReview_id());
				if (pre_productReviewDTO.getPhotos() != null) {
					String[] pre_imgNames = pre_productReviewDTO.getPhotos().split(",");
					String pre_uploadDir = "C:/images/shoppingMall_review/";
					for (String imgName : pre_imgNames) {
						File file = new File(pre_uploadDir + imgName);
						file.delete();
					}
				}
				//새로운 이미지 등록
				for (MultipartFile img : multipartFilePhotos) {
					inputStream = img.getInputStream();
					String imgName = uuid + img.getOriginalFilename();
					imgNames += imgName + ","; // DB저장용
					img.transferTo(new File(uploadDir + imgName));
				}
				productReviewDTO.setPhotos(imgNames.replaceAll(",$", ""));
			}
			productReviewDTO.setUser_id(user_id);
			num = productReviewService.updateReview(productReviewDTO);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (inputStream != null) inputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		String mesg = "";
		if (num == 1) {
			mesg = "리뷰가 수정되었습니다.";
		} else {
			mesg = "리뷰 수정 실패";
		}
		redirectAttributes.addFlashAttribute("mesg", mesg);
		redirectAttributes.addFlashAttribute("closeWindow", true);
		return "redirect:/shop_productReview/" + productReviewDTO.getProduct_id();
	}
	
	@Transactional
	@ResponseBody
	@PatchMapping("/shop_productReview_Feedback") //후기 평가
	public String patchProductReview_Feedback(@RequestParam String feedback, @RequestParam int reviewid) {
		int user_id = 1; // 임시 유저
		Map<String, Object> map = new HashMap<>();
		map.put("feedback", feedback);
		map.put("review_id", reviewid);
		map.put("user_id", user_id);
		String res = "";
		if(productReviewService.checkUserFeedback(map) == 0) {
			productReviewService.insertUserFeedback(map);
			productReviewService.addReviewFeedback(map);
			res = "insert";
		} else {
			productReviewService.updateUserFeedback(map);
			productReviewService.updateReviewFeedback(map);
			res = "update";
		}
		return res;
	}
	

}
