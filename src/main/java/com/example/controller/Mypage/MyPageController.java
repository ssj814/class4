package com.example.controller.Mypage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dto.CartDTO;
import com.example.dto.CartProductDTO;
import com.example.dto.ProductDTO;
import com.example.dto.ProductOptionDTO;
import com.example.dto.ProductReviewDTO;
import com.example.dto.ProductWishDTO;
import com.example.dto.user.UserDto;
import com.example.service.Mypage.MyPageServiceImpl;
import com.example.service.shoppingmall.CartService;
import com.example.service.shoppingmall.ProductService;
import com.example.service.shoppingmall.WishService;

@Controller
public class MyPageController {

    @Autowired
    private CartService cartService;

    @Autowired
    private WishService wishService;

    @Autowired
    private ProductService productService;

    @Autowired
    private MyPageServiceImpl myPageService;

    @GetMapping("/mypage")
    public String myPage(@RequestParam(value = "page", required = false) String page, Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String userId = authentication.getName();  // 로그인된 사용자 ID

        // 기본 페이지가 설정되지 않았을 경우 기본 페이지로 userInfo 설정
        if (page == null || page.isEmpty()) {
            page = "userInfo";
        }

        // 페이지별 데이터 처리
        if ("userInfo".equals(page)) {
            UserDto userInfo = myPageService.getUserInfo(userId);
            model.addAttribute("userInfo", userInfo);

        } else if ("editInfo".equals(page)) {
            // 필요 시 회원 수정 정보 로딩

        } else if ("deleteAccount".equals(page)) {
            // 계정 삭제 관련 데이터 로딩

        } else if ("orderList".equals(page)) {
            List<CartProductDTO> cartItems = myPageService.getCartItems(userId);
            
            // 옵션 정보를 로드하여 cartItems에 추가
            for (CartProductDTO product : cartItems) {
                List<ProductOptionDTO> allOptions = productService.selectProductOptions(product.getProduct_id());
                product.setAllOptions(allOptions);
                
                List<CartDTO> selectedOptions = cartService.selectProductOptions(product.getProduct_id(), userId);
                product.setSelectedOptions(selectedOptions);
              
            }
            System.out.println("이거 카트임" + cartItems);
            model.addAttribute("cartItems", cartItems);

        } else if ("wishlist".equals(page)) {
            List<ProductWishDTO> wishList = wishService.selectWishList(userId);
            List<Map<String, Object>> wishProductList = new ArrayList<>();

            for (ProductWishDTO wish : wishList) {
                ProductDTO product = productService.selectDetailproduct(wish.getProduct_id());
                
                Map<String, Object> wishProductMap = new HashMap<>();
                wishProductMap.put("wish", wish);
                wishProductMap.put("product", product);
                
                wishProductList.add(wishProductMap);
            }

            System.out.println("wishlist : " + wishList);
            model.addAttribute("wishProductList", wishProductList);

        } else {
            // 기본 마이페이지 설정 (userInfo 기본 설정)
            UserDto userInfo = myPageService.getUserInfo(userId);
            model.addAttribute("userInfo", userInfo);
        }

        return "Mypage/mypage";
    }
}