package com.example.service.shoppingmall;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.entity.OrderMain;
import com.example.entity.OrderPayment;
import com.example.entity.OrderProduct;
import com.example.entity.OrderProductOption;
import com.example.repository.OrderMainRepository;
import com.example.repository.OrderPaymentRepository;
import com.example.repository.OrderProductOptionRepository;
import com.example.repository.OrderProductRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderMainRepository orderMainRepository;
    private final OrderPaymentRepository orderPaymentRepository;
    private final OrderProductRepository orderProductRepository;
    private final OrderProductOptionRepository orderProductOptionRepository;

    // OrderMain 저장
    @Transactional
    public OrderMain saveOrderMain(OrderMain orderMain) {
        return orderMainRepository.save(orderMain);
    }

    // OrderPayment 저장
    @Transactional
    public OrderPayment saveOrderPayment(OrderPayment orderPayment) {
        return orderPaymentRepository.save(orderPayment);
    }

    // OrderProduct 저장
    @Transactional
    public OrderProduct saveOrderProduct(OrderProduct orderProduct) {
        return orderProductRepository.save(orderProduct);
    }

    // OrderProductOption 저장
    @Transactional
    public OrderProductOption saveOrderProductOption(OrderProductOption orderProductOption) {
        return orderProductOptionRepository.save(orderProductOption);
    }

    // OrderMain 조회
    public OrderMain findOrderMainById(Long id) {
        return orderMainRepository.findById(id).orElse(null);
    }

    // OrderPayment 조회
    public OrderPayment findOrderPaymentById(Long id) {
        return orderPaymentRepository.findById(id).orElse(null);
    }

    // OrderProduct 조회
    public OrderProduct findOrderProductById(Long id) {
        return orderProductRepository.findById(id).orElse(null);
    }

    // OrderProductOption 조회
    public OrderProductOption findOrderProductOptionById(Long id) {
        return orderProductOptionRepository.findById(id).orElse(null);
    }
    
    // OrderMain 조회 : userId 기준
    public List<OrderMain> findOrderMainByUserId(String userId) {
        return orderMainRepository.findByUserId(userId);
    }
    
    // OrderProduct 조회 : orderId 기준
    public OrderProduct findOrderProductByOrderId(Long orderId) {
        return orderProductRepository.findFirstByOrderId(orderId).orElse(null);
    }
}
