package com.example.controller.shoppingmall;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.ProductDTO;
import com.example.dto.ProductWishDTO;
import com.example.service.shoppingmall.ProductService;
import com.example.service.shoppingmall.WishService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class WishController {
	
	@Autowired
	WishService service;
	@Autowired
	ProductService productService;
	
	@GetMapping(value="/user/wishList")
	public String wishList(Model m) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = authentication.getName();
		List<ProductWishDTO> wishList = service.selectWishList(userId);
		List<Map<String, Object>> wishProductList = new ArrayList<>();

	    for (ProductWishDTO wish : wishList) {
	        ProductDTO product = productService.selectDetailproduct(wish.getProduct_id());
	        
	        Map<String, Object> wishProductMap = new HashMap<>();
	        wishProductMap.put("wish", wish);
	        wishProductMap.put("product", product);
	        
	        wishProductList.add(wishProductMap);
	    }

	    m.addAttribute("wishProductList", wishProductList);
		return "shoppingMall/wishList";
	}
	
	@GetMapping(value="/wish")
	@ResponseBody
	public Map<String,String> wishInsert(int productId, String options,Model m) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = authentication.getName();
		
		StringBuilder optionTypes = new StringBuilder();
	    StringBuilder optionNames = new StringBuilder();

	    List<Map<String, String>> optionList = new ArrayList<>();
	    try {
	        optionList = new ObjectMapper().readValue(options, new TypeReference<List<Map<String, String>>>() {});
	    } catch (JsonProcessingException e) {
	        e.printStackTrace();
	    }
	    for (Map<String, String> option : optionList) {
	        if (optionTypes.length() > 0) {
	            optionTypes.append(",");
	            optionNames.append(",");
	        }
	        optionTypes.append(option.get("type"));
	        optionNames.append(option.get("name"));
	    }
	    
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("user_id", userId);
		map.put("product_Id", productId);
		map.put("option_type", optionTypes.toString());
	    map.put("option_name", optionNames.toString());
		System.out.println("map : "+map);
		int check = service.checkWish(map); //wish에 존재? - wishCheck로 바꿔야지
		System.out.println("위시 중복체크 : "+check);
		Map<String,String> responseMap = new HashMap<String,String>();
		String mesg = "이미 위시리스트에 존재하는 상품입니다";
		if(check!=1) {
			int n = service.wishInsert(map);
			if(n==1) {
				mesg = "위시리스트 추가 완료";
			}
		}
		responseMap.put("mesg",mesg);
		return responseMap;
	}
	
	@DeleteMapping(value="/wish/wishId/{wishId}")
	@ResponseBody
	public void wishDelete(@PathVariable int wishId, Model m) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = authentication.getName();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("user_id", userId);
		map.put("wish_id", wishId);
		service.wishDelete(map);
	}
	
	@DeleteMapping(value="/wish/wishIdList/{wishIdList}")
	@ResponseBody
	public Map<String,String> AllwishDelete(@PathVariable List<String> wishIdList, Model m) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = authentication.getName();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("user_id", userId);
		map.put("wishIdList", wishIdList);
		int del = service.AllwishDelete(map);
		Map<String,String> resMap = new HashMap<String,String>();
		resMap.put("mesg","삭제 실패");
		if(del>=1){
			resMap.put("mesg","선택 상품 삭제를 완료했습니다.");
		}
		return resMap;
	}
	

	
	
}
