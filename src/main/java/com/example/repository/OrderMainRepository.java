package com.example.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.entity.OrderMain;

@Repository
public interface OrderMainRepository extends JpaRepository<OrderMain, Long> {
	
	List<OrderMain> findByUserId(String userId);
	
}
