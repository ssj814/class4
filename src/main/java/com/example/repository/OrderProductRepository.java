package com.example.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.entity.OrderProduct;

@Repository
public interface OrderProductRepository extends JpaRepository<OrderProduct, Long> {
	
	@Query(value = "SELECT * FROM order_product WHERE order_id = :orderId AND ROWNUM = 1", nativeQuery = true)
	Optional<OrderProduct> findFirstByOrderId(@Param("orderId") Long orderId);
	
}
