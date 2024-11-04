package com.example.service.shoppingmall;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.entity.CardInfo;
import com.example.repository.CardInfoRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CardInfoService {

	private final CardInfoRepository cardInfoRepository;
    
 // 모든 카드 정보 조회
    @Transactional(readOnly = true)
    public List<CardInfo> getAllCardInfo() {
        List<CardInfo> cardInfoList = cardInfoRepository.findAll();
        System.out.println("CardInfoRepository.findAll() 결과: " + cardInfoList); // 디버깅 출력
        return cardInfoList;
    }

}
