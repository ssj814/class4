package com.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.entity.OrderMain;

@Repository
public interface OrderMainRepository extends JpaRepository<OrderMain, Long> {
	
}
