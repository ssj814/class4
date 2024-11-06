package com.example.repository;

import java.math.BigDecimal;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.entity.CardInfo;

@Repository
public interface CardInfoRepository extends JpaRepository<CardInfo, BigDecimal> {

}