<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문완료</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .main-title-container {
        background-color: #ddd;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-weight: bold;
        font-size: 24px;
        border-bottom: 4px solid black;
        width: 100%;
        max-width: 1000px;
        margin: 0px auto;
    }
    .main-content-container {
        max-width: 1000px;
        background-color: #E5E5E5;
        padding: 20px;
        border: 1px solid #333;
        margin: 0px auto;
    }
    .section-box {
        background-color: #ccc;
        border: 1px solid #333;
        padding: 20px;
        margin-bottom: 20px;
    }
    .section-header {
        font-weight: bold;
        font-size: 18px;
        margin-bottom: 10px;
    }
    .order-number {
        font-size: 20px;
        font-weight: bold;
        color: #333;
        background-color: #666;
        padding: 10px;
        border-radius: 5px;
        text-align: center;
        color: white;
    }
    .table-summary {
        width: 100%;
        margin-top: 20px;
    }
    .table-summary th, .table-summary td {
        padding: 10px;
        text-align: left;
        border-top: 1px solid #333;
    }
    .table-summary th {
        font-weight: bold;
    }
    .table-summary .text-end {
        text-align: right;
    }
</style>
</head>
<body>

<div class="main-title-container">
    <span>주문완료</span>
    <span style="font-size: 18px;">01 주문/결제 &gt; 02 주문완료</span>
</div>

<div class="main-content-container">
    <div class="text-center mt-4">
        <div class="order-number">주문번호 : ${orderNumber}</div>
    </div>
    <hr>
    <div class="section-box mt-4">
        <div class="section-header">결제정보</div>
        <table class="table-summary">
            <tr>
                <th>총상품금액</th>
                <td class="text-end">₩${totalAmount}</td>
            </tr>
            <tr>
                <th>결제수단</th>
                <td class="text-end">${paymentMethod}</td>
            </tr>
            <tr>
                <th>카드종류</th>
                <td class="text-end">${cardType}</td>
            </tr>
            <tr>
                <th>할부종류</th>
                <td class="text-end">${installmentType}</td>
            </tr>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
