package com.example.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@SequenceGenerator(name = "order_seq_generator", sequenceName = "order_seq", initialValue = 1, allocationSize = 1)
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "order_seq_generator")
    private Long orderId;
    
    private LocalDateTime orderDate;
    private String contact;
    private String zipcode;
    private String address;
    private String addressDetail;
    private String paymentMethod;
    private BigDecimal totalAmount;
}

