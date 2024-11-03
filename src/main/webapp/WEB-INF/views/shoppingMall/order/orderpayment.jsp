<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 / 결제</title>
    <!-- Bootstrap CSS -->
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
            margin: 0 auto;
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
        .order-summary {
            background-color: #CCCCCC;
            border: 1px solid #333;
            padding: 20px;
        }
        .order-item {
            border-bottom: 1px solid #333;
            padding: 10px 0;
        }
        .payment-button {
            background-color: black;
            color: white;
            font-weight: bold;
            width: 100%;
            margin-top: 20px;
        }
        .form-label-inline {
            width: 100px;
            display: inline-block;
            font-weight: bold;
        }
        .form-group-inline {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .payment-options-box {
            background-color: #E5E5E5;
            padding: 10px;
            border-radius: 4px;
            color: black;
        }
    </style>
</head>
<body>

<!-- Page Title with Breadcrumb on Right -->
<div class="main-title-container">
    <span>주문 / 결제</span>
    <span style="font-size: 18px;">01 주문/결제 &gt; 02 주문완료</span>
</div>

<!-- Main Content -->
<div class="main-content-container">
    <div class="row">
        <!-- Left Column: 배송지 정보 및 결제 수단 선택 -->
        <div class="col-md-6">
            <!-- 배송지 정보 -->
            <div class="section-box">
                <div class="section-header">배송지 정보</div>
                <hr>
                <form>
                    <div class="form-group-inline">
                        <span class="form-label-inline">배송지 선택</span>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="shippingType" id="existingAddress" value="existing" checked>
                            <label class="form-check-label" for="existingAddress">기존배송지</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="shippingType" id="newAddress" value="new">
                            <label class="form-check-label" for="newAddress">신규배송지</label>
                        </div>
                    </div>
                    <div class="form-group-inline">
                        <span class="form-label-inline">이름:</span>
                        <input type="text" class="form-control" name="recipientName" style="flex: 1;">
                    </div>
                    <div class="form-group-inline">
                        <span class="form-label-inline">연락처:</span>
                        <input type="text" class="form-control" name="contact" style="flex: 1;">
                    </div>
                    <div class="form-group-inline">
                        <span class="form-label-inline">우편번호:</span>
                        <input type="text" class="form-control" name="zipcode" style="flex: 1;">
                    </div>
                    <div class="form-group-inline">
                        <span class="form-label-inline">기본 주소:</span>
                        <input type="text" class="form-control" name="basicAddress" style="flex: 1;">
                    </div>
                    <div class="form-group-inline">
                        <span class="form-label-inline">상세 주소:</span>
                        <input type="text" class="form-control" name="detailAddress" style="flex: 1;">
                    </div>
                </form>
            </div>

            <!-- 결제 수단 선택 -->
            <div class="section-box">
                <div class="section-header">결제 수단 선택</div>
                <hr>
                <div class="payment-options-box">
                    <div class="mb-3">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="creditCard" value="credit" checked>
                            <label class="form-check-label" for="creditCard">신용카드</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="bankTransfer" value="account">
                            <label class="form-check-label" for="bankTransfer">계좌이체</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="mobilePayment" value="mobile">
                            <label class="form-check-label" for="mobilePayment">휴대폰결제</label>
                        </div>
                    </div>
                    <div class="form-group-inline mb-2">
                        <span class="form-label-inline">카드 종류:</span>
                        <select class="form-select" name="cardType" style="flex: 1;">
                            <option value="KB">KB카드</option>
                            <option value="SHINHAN">신한카드</option>
                            <option value="WOORI">우리카드</option>
                        </select>
                    </div>
                    <div class="form-group-inline">
                        <span class="form-label-inline">할부 종류:</span>
                        <select class="form-select" name="installmentType" style="flex: 1;">
                            <option value="lump-sum">일시불</option>
                            <option value="3months">3개월</option>
                            <option value="6months">6개월</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column: 주문 정보 요약 -->
        <div class="col-md-6">
            <div class="order-summary">
                <div class="section-header">주문 정보</div>
                <hr>
                <div class="order-items">
                    <c:forEach var="item" items="${orderItems}">
                        <div class="order-item d-flex justify-content-between align-items-center">
                            <div>
                                <strong><!-- 상품 이름 --></strong> <br>
                                <small><!-- 상품 옵션 --></small> × <!-- 상품 개수 -->
                            </div>
                            <span>₩ <!-- 상품 가격 --></span>
                        </div>
                    </c:forEach>
                </div>
                <div class="total-price text-end mt-3">
                    Total: ₩<span><!-- 총액 --></span>
                </div>
                <!-- 결제 버튼 -->
                <button type="button" class="btn payment-button btn-lg" onclick="submitPayment()">결제하기</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function submitPayment() {
        // 결제 처리 로직
        alert("결제 진행");
    }
</script>

</body>
</html>
