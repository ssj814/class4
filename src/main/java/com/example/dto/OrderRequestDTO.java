package com.example.dto;

import java.util.List;

import lombok.Data;

@Data
public class OrderRequestDTO {
    private String recipientName;
    private String contact;
    private String zipcode;
    private String basicAddress;
    private String detailAddress;
    private String paymentMethod;
    private String cardType;
    private String installmentType;
    private List<Long> productIds;
    private List<Integer> quantities;
    private List<Double> individualPrices;
    private List<List<String>> optionTypes;
    private List<List<String>> optionNames;
    private double totalAmount;
}
