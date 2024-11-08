package com.example.entity;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "ORDER_PAYMENT")
public class OrderPayment {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "order_payment_seq")
    @SequenceGenerator(name = "order_payment_seq", sequenceName = "ORDER_PAYMENT_SEQ", allocationSize = 1)
    @Column(name = "PAYMENT_ID", nullable = false)
    private Long paymentId;

    @Column(name = "ORDER_ID")
    private Long orderId;

    @Column(name = "CARD_TYPE", length = 50)
    private String cardType;

    @Column(name = "INSTALLMENT_TYPE", length = 50)
    private String installmentType;

    @Temporal(TemporalType.DATE)
    @Column(name = "PAYMENT_DATE")
    private Date paymentDate;
}