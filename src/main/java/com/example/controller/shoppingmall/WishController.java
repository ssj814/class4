package com.example.controller.shoppingmall;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.ProductDTO;
import com.example.service.shoppingmall.ProductService;
import com.example.service.shoppingmall.WishService;

@Controller
public class WishController {
	
	@Autowired
	WishService service;
	@Autowired
	ProductService productService;
	
	@GetMapping(value="/wishList")
	public String wishList(Model m) {
		int user_id = 1; // 임시 유저
		List<Integer> list = service.selectWishList(user_id);
		List<ProductDTO> ProductList = new ArrayList<ProductDTO>();
		for(int i=0; i<list.size(); i++) {
			ProductDTO product = productService.selectDetailproduct(list.get(i));
			ProductList.add(product);
		}
		m.addAttribute("ProductList", ProductList);
		return "shoppingMall/wishList";
	}
	
	@GetMapping(value="/wish")
	@ResponseBody
	public Map<String,String> wishInsert(int productId, Model m) {
		int user_Id = 1; //임시 유저
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("user_id", user_Id);
		map.put("product_Id", productId);
		int check = service.checkWish(map); //wish에 존재? - wishCheck로 바꿔야지
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
	
	@DeleteMapping(value="/wish/productId/{productId}")
	@ResponseBody
	public void wishDelete(@PathVariable int productId, Model m) {
		int user_Id = 1; //임시 유저
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("user_id", user_Id);
		map.put("product_Id", productId);
		service.wishDelete(map);
	}
	
	@DeleteMapping(value="/wish/productIdList/{productIdList}")
	@ResponseBody
	public Map<String,String> AllwishDelete(@PathVariable List<String> productIdList, Model m) {
		int user_Id = 1; //임시 유저
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("user_id", user_Id);
		map.put("productIdList", productIdList);
		int del = service.AllwishDelete(map);
		Map<String,String> resMap = new HashMap<String,String>();
		resMap.put("mesg","삭제 실패");
		if(del>=1){
			resMap.put("mesg","선택 상품 삭제를 완료했습니다.");
		}
		return resMap;
	}
	

	
	
}
