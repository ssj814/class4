<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문완료</title>
<style>
    .main-title-container {
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
        margin-top: 10px;
    }
    .main-content-container {
        max-width: 1000px;
        padding: 20px;
        margin: 50px auto;
    }
    .section-box {
        padding: 20px;
        margin-bottom: 20px;
    }
    .section-header {
        font-weight: bold;
        font-size: 23px;
        margin-bottom: 10px;
    }
    .order-number {
        font-size: 25px;
        font-weight: bold;
        color: #333;
        background-color: #666;
        padding: 10px;
        border-radius: 5px;
        text-align: center;
        align-content:center;
        color: white;
        width: 70%;
        height: 70px;
        margin: 0 auto;
    }
    .table-summary {
        width: 100%;
        margin-top: 20px;
    }
    .table-summary th, .table-summary td {
        padding: 20px;
        text-align: left;
        font-size: 18px;
        border-top: 1px solid #333;
        border-bottom: 1px solid #333;
    }
    .table-summary th {
        font-weight: bold;
    }
    .table-summary .text-end {
        text-align: right;
    }
    .btn {
    	background-color: black;
		color: white;
		font-weight: bold;
		width: 20%;
    }
</style>
</head>
<body>

<div class="main-title-container">
    <span>주문완료</span>
    <span style="font-size: 18px;">
    	<span style="color:gray;">00 장바구니 &gt;</span>
    	<span style="color:gray;">01 주문/결제 &gt;</span>
    	02 주문완료
    </span>
</div>

<div class="main-content-container">
    <div class="text-center mt-4"">
        <div class="order-number">주문번호 : ${orderMain.orderId}</div>
    </div>
    <hr style="margin-top: 100px;">
    <div class="section-box mt-4">
        <div class="section-header">결제정보</div>
        <table class="table-summary">
            <tr>
                <th>총상품금액</th>
                <td class="text-end">
                	 <fmt:formatNumber value="${orderMain.totalAmount}" type="currency" currencySymbol="₩ " />
                </td>
            </tr>
            <tr>
                <th>결제수단</th>
                <td class="text-end">
                	 <c:choose>
                        <c:when test="${orderMain.paymentMethod == 'credit'}">신용카드</c:when>
                        <c:when test="${orderMain.paymentMethod == 'account'}">계좌이체</c:when>
                        <c:when test="${orderMain.paymentMethod == 'mobile'}">휴대폰결제</c:when>
                        <c:otherwise>알 수 없음</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <c:if test="${orderMain.paymentMethod == 'credit'}">
           	<tr>
			    <th>카드종류</th>
			    <td class="text-end">
			        <c:forEach var="cardInfo" items="${cardInfoList}">
			            <c:if test="${orderPay.cardType == cardInfo.cardId}">
			                ${cardInfo.cardName}
			            </c:if>
			        </c:forEach>
			    </td>
			</tr>
			<tr>
			    <th>할부종류</th>
			    <td class="text-end">
			        <c:choose>
			            <c:when test="${orderPay.installmentType == 'lump-sum'}">일시불</c:when>
			            <c:otherwise>
			                <c:set var="installmentMonths" value="${fn:substringBefore(orderPay.installmentType, 'months')}" />
			                ${installmentMonths}개월
			            </c:otherwise>
			        </c:choose>
			    </td>
			</tr>
			</c:if>
        </table>
    </div>
    <div class="text-center">
        <button type="button" class="btn btn-lg" onclick="location.href='/app/shopList'">계속 쇼핑하기</button>
    </div>  
</div>
</body>
</html>
