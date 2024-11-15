//package com.example.controller.Mypage;
//
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import com.example.dto.CartDTO;
//import com.example.dto.CartProductDTO;
//import com.example.dto.ProductDTO;
//import com.example.dto.ProductOptionDTO;
//import com.example.dto.ProductWishDTO;
//import com.example.dto.user.UserDTO;
//import com.example.service.Mypage.MyPageServiceImpl;
//import com.example.service.shoppingmall.CartService;
//import com.example.service.shoppingmall.ProductService;
//import com.example.service.shoppingmall.WishService;
//
//@Controller
//public class MyPageController {
//
//    @Autowired
//    private CartService cartService;
//
//    @Autowired
//    private WishService wishService;
//
//    @Autowired
//    private ProductService productService;
//
//    @Autowired
//    private MyPageServiceImpl myPageService;
//
//    /**
//     * 마이페이지를 렌더링하는 메서드입니다.
//     * 
//     * @param page 현재 페이지의 종류를 나타내는 파라미터입니다.
//     * @param model 뷰에 데이터를 전달하기 위한 모델 객체입니다.
//     * @return "Mypage/mypage" 뷰 이름을 반환하여 마이페이지를 렌더링합니다.
//     */
//    @GetMapping("/mypage")
//    public String myPage(@RequestParam(value = "page", required = false) String page, Model model) {
//        // 로그인된 사용자의 ID를 가져옵니다.
//        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//        String userId = authentication.getName();  // 로그인된 사용자 ID
//
//        // 페이지 파라미터가 없을 경우 기본 페이지를 "userInfo"로 설정합니다.
//        if (page == null || page.isEmpty()) {
//            page = "userInfo";
//        }
//
//        // 페이지 종류에 따라 필요한 데이터를 로드하고 모델에 추가합니다.
//        if ("userInfo".equals(page)) {
//            // 사용자 정보 페이지
//            UserDTO userInfo = myPageService.getUserInfo(userId);
//            model.addAttribute("userInfo", userInfo);
//
//        } else if ("editInfo".equals(page)) {
//            // 회원 정보 수정 페이지로 이동합니다.
//            // 필요 시 추가 로직을 작성합니다.
//
//        } else if ("deleteAccount".equals(page)) {
//            // 계정 삭제와 관련된 페이지로 이동합니다.
//            // 필요 시 추가 로직을 작성합니다.
//
//        } else if ("orderList".equals(page)) {
//            // 주문 목록 페이지
//            List<CartProductDTO> cartItems = myPageService.getCartItems(userId);
//
//            // 각 상품에 대해 옵션 정보를 로드하고 cartItems 리스트에 추가합니다.
//            for (CartProductDTO product : cartItems) {
//                // 모든 옵션을 가져와 설정합니다.
//                List<ProductOptionDTO> allOptions = productService.selectProductOptions(product.getProduct_id());
//                product.setAllOptions(allOptions);
//                
//                // 선택한 옵션을 가져와 설정합니다.
//                List<CartDTO> selectedOptions = cartService.selectProductOptions(product.getProduct_id(), userId);
//                product.setSelectedOptions(selectedOptions);
//            }
//            System.out.println("이거 카트임" + cartItems);
//            model.addAttribute("cartItems", cartItems);
//
//        } else if ("wishlist".equals(page)) {
//            // 위시리스트 페이지
//            List<ProductWishDTO> wishList = wishService.selectWishList(userId);
//            List<Map<String, Object>> wishProductList = new ArrayList<>();
//
//            // 위시리스트의 각 상품에 대해 상세 정보를 가져와 설정합니다.
//            for (ProductWishDTO wish : wishList) {
//                ProductDTO product = productService.selectDetailproduct(wish.getProduct_id());
//                
//                Map<String, Object> wishProductMap = new HashMap<>();
//                wishProductMap.put("wish", wish);
//                wishProductMap.put("product", product);
//                
//                wishProductList.add(wishProductMap);
//            }
//
//            System.out.println("wishlist : " + wishList);
//            model.addAttribute("wishProductList", wishProductList);
//
//        } else {
//            // 기본 마이페이지 설정 (userInfo 기본 설정)
//            UserDTO userInfo = myPageService.getUserInfo(userId);
//            model.addAttribute("userInfo", userInfo);
//        }
//
//        // 최종적으로 "Mypage/mypage" 뷰를 반환하여 해당 페이지를 렌더링합니다.
//        return "Mypage/mypage";
//    }
//}
