package com.example.entity;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
@Entity
@Table(name = "ORDER_MAIN")
@Getter
@Setter
public class OrderMain {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ORDER_MAIN_SEQ_GEN")
    @SequenceGenerator(name = "ORDER_MAIN_SEQ_GEN", sequenceName = "ORDER_MAIN_SEQ", allocationSize = 1)
    @Column(name = "ORDER_ID")
    private Long orderId;

    @Column(name = "USER_ID", length = 250) // VARCHAR2(250 BYTE)로 수정
    private String userId;

    @Column(name = "ORDER_DATE")
    private LocalDate orderDate;

    @Column(name = "CONTACT", length = 20)
    private String contact;

    @Column(name = "ZIPCODE", length = 10)
    private String zipcode;

    @Column(name = "ADDRESS", length = 255)
    private String address;

    @Column(name = "ADDRESS_DETAIL", length = 255)
    private String addressDetail;

    @Column(name = "PAYMENT_METHOD", length = 50)
    private String paymentMethod;

    @Column(name = "TOTAL_AMOUNT", precision = 10, scale = 2)
    private BigDecimal totalAmount;
}