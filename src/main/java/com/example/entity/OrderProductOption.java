package com.example.entity;

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
@Getter
@Setter
@Table(name = "ORDER_PRODUCT_OPTION")
public class OrderProductOption {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "order_product_option_seq")
    @SequenceGenerator(name = "order_product_option_seq", sequenceName = "ORDER_PRODUCT_OPTION_SEQ", allocationSize = 1)
    @Column(name = "ORDER_PRODUCT_OPTION_ID", nullable = false)
    private Long orderProductOptionId;

    @Column(name = "ORDER_PRODUCT_ID")
    private Long orderProductId;

    @Column(name = "OPTION_TYPE", length = 50)
    private String optionType;

    @Column(name = "OPTION_NAME", length = 50)
    private String optionName;
}