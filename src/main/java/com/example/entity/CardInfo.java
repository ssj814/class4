package com.example.entity;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;

@Entity
@Table(name = "CARD_INFO")
@Getter
public class CardInfo {

	@Id
	@Column(name = "CARD_ID") // 데이터베이스 컬럼 이름과 정확히 맞추기
//	private int cardId;
	private BigDecimal cardId;

	@Column(name = "CARD_NAME") // 데이터베이스 컬럼 이름과 정확히 맞추기
	private String cardName;
}
