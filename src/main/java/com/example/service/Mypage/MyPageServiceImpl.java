package com.example.service.Mypage;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.dto.CartProductDTO;
import com.example.dto.ProductReviewDTO;
import com.example.dto.user.UserDto;

@Service
public class MyPageServiceImpl {

    @Autowired
    private SqlSession sqlSession;

    // 사용자 정보 가져오기
    public UserDto getUserInfo(String userId) {
        return sqlSession.selectOne("UserMapper.selectUserInfo", userId);
    }

    // 장바구니 항목 가져오기
    public List<CartProductDTO> getCartItems(String userId) {
        return sqlSession.selectList("CartMapper.selectCart", userId);
    }

    // 사용자 리뷰 목록 가져오기
    public List<ProductReviewDTO> getUserReviews(String userId) {
        return sqlSession.selectList("ProductReviewMapper.selectReviewList", userId);
    }

    // 위시리스트 가져오기
    public List<String> getWishlist(String userId) {
        return sqlSession.selectList("WishMapper.selectWishList", userId);
    }
}
