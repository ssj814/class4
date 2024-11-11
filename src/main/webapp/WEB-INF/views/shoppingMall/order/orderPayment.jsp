<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 / 결제</title>
<!-- Bootstrap CSS -->

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
	margin: 0px auto;
}

.section-box {
	padding: 20px;
	margin-bottom: 20px;
}

.section-header {
	font-weight: bold;
	font-size: 18px;
	margin-bottom: 10px;
}

.order-summary {
	background-color: #EEE;
	padding: 20px;
	border-radius: 20px;
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
		<span style="font-size: 18px;">
			<span style="color:gray;">00 장바구니 &gt;</span> 
			01 주문/결제 &gt; 
			<span style="color:gray;">02 주문완료</span>
		</span>
	</div>

	<!-- Main Content -->
	<div class="main-content-container">
		<div class="row">
			<!-- Left Column: 배송지 정보 및 결제 수단 선택 -->
			<div class="col-md-6">
				<!-- 배송지 정보 -->
				<div class="section-box">
					<div class="section-header">배송지 정보</div>
					<hr style="border: solid 1px black; opacity: inherit; ">
					<div class="form-group-inline">
						<span class="form-label-inline">배송지 선택</span>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="shippingType"
								id="existingAddress" value="existing" checked> <label
								class="form-check-label" for="existingAddress">기존배송지</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="shippingType"
								id="newAddress" value="new"> <label
								class="form-check-label" for="newAddress">신규배송지</label>
						</div>
					</div>

					<!-- 기존 배송지 입력 필드 -->
					<div id="existingAddressFields">
						<div class="form-group-inline">
							<span class="form-label-inline">이름:</span> <input type="text"
								class="form-control" name="existingRecipientName"
								value="${user.realusername}" style="flex: 1;">
						</div>
						<div class="form-group-inline">
							<span class="form-label-inline">연락처:</span> <input type="text"
								class="form-control" name="existingContact"
								value="${user.phone1}${user.phone2}${user.phone3}"
								style="flex: 1;">
						</div>
						<div class="form-group-inline">
							<span class="form-label-inline">우편번호:</span> <input type="text"
								class="form-control" name="existingZipcode" value="${user.postalcode}"
								style="flex: 1;">
						</div>
						<div class="form-group-inline">
							<span class="form-label-inline">기본 주소:</span> <input type="text"
								class="form-control" name="existingBasicAddress"
								value="${user.streetaddress}" style="flex: 1;">
						</div>
						<div class="form-group-inline">
							<span class="form-label-inline">상세 주소:</span> <input type="text"
								class="form-control" name="existingDetailAddress"
								value="${user.detailedaddress}" style="flex: 1;">
						</div>
					</div>

					<!-- 신규 배송지 입력 필드 -->
					<div id="newAddressFields">
						<div class="form-group-inline">
							<span class="form-label-inline">이름:</span> <input type="text"
								class="form-control" name="newRecipientName" placeholder="이름 입력"
								style="flex: 1;" required="required">
						</div>
						<div class="form-group-inline">
							<span class="form-label-inline">연락처:</span> <input type="text"
								class="form-control" name="newContact" placeholder="연락처 입력"
								style="flex: 1;">
						</div>
						<div class="form-group-inline">
							<span class="form-label-inline">우편번호:</span> <input type="text"
								class="form-control" name="newZipcode" id="zipcode" placeholder="우편번호 입력"
								style="flex: 1;">
							<button type="button" onclick="openPostcode()" class="btn btn-dark ms-2">주소 찾기</button>
						</div>
						<div class="form-group-inline">
							<span class="form-label-inline">기본 주소:</span> <input type="text"
								class="form-control" name="newBasicAddress" id="basicAddress" placeholder="기본 주소 입력"
								style="flex: 1;">
						</div>
						<div class="form-group-inline">
							<span class="form-label-inline">상세 주소:</span> <input type="text"
								class="form-control" name="newDetailAddress" placeholder="상세 주소 입력"
								style="flex: 1;">
						</div>
					</div>
					<hr style="border: solid 1px black; opacity: inherit; ">
				</div>
				
				

				<!-- 결제 수단 선택 -->
				<div class="section-box">
					<div class="section-header">결제 수단 선택</div>
					<hr style="border: solid 1px black; opacity: inherit; ">
					<div class="payment-options-box">
						<div class="mb-3">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="paymentMethod" id="creditCard" value="credit" checked>
								<label class="form-check-label" for="creditCard">신용카드</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="paymentMethod" id="bankTransfer" value="account">
								<label class="form-check-label" for="bankTransfer">계좌이체</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="paymentMethod" id="mobilePayment" value="mobile">
								<label class="form-check-label" for="mobilePayment">휴대폰결제</label>
							</div>
						</div>
						<div id="creditCardField">
							<div class="form-group-inline mb-2" >
								<span class="form-label-inline">카드 종류:</span> <select
									class="form-select" name="cardType" style="flex: 1;">
									<c:forEach var="card" items="${cardInfoList}">
										<option value="${card.cardId}">${card.cardName}</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group-inline">
								<span class="form-label-inline">할부 종류:</span> <select
									class="form-select" name="installmentType" style="flex: 1;">
									<option value="lump-sum">일시불</option>
									<c:forEach begin="1" end="12" var="num">
										<option value="${num}months">${num}개월</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="payInfo align-items-center" style="display: flex;">
							<span class="form-label-inline" style="width: 20%;">결제 안내:</span>
							<div style="width:80%; font-size: 11px; background-color: white; padding: 3px 8px">
								<span>계좌이체로 결제 완료시 본인 계좌에서 즉시 이체 처리됩니다.</span><br>
								<span>은행 별 시스템점검 시간이 다를수 있습니다.</span>
							</div>
						</div>
					</div>
					<hr style="border: solid 1px black; opacity: inherit; ">
				</div>
			</div>

			<!-- Right Column: 주문 정보 요약 -->
			<div class="col-md-6">
				<div class="order-summary">
					<div class="section-header">주문 정보</div>
					<hr style="border: solid 1px black; opacity: inherit; ">
					<!-- 여러 상품 주문 -->
				    <c:if test="${not empty cartList}">
					    <c:forEach var="item" varStatus="status" items="${cartList}">
					        <!-- 여러 상품 주문 -->
					        <c:set var="product" value="${productList[status.index]}" />
					        <div class="order-item d-flex justify-content-between align-items-center">
					            <div>
					                <strong>${product.product_name}</strong> <br>
					                <small>
					                    <c:forEach var="type" items="${fn:split(item.option_type, ',')}" varStatus="idx">
					                        <c:set var="name" value="${fn:split(item.option_name, ',')[idx.index]}" />
					                        ${type} : ${name}<c:if test="${!idx.last}"> || </c:if>
					                    </c:forEach>
					                </small> × ${item.quantity}
					            </div>
					            <span>
					                <fmt:formatNumber value="${product.product_price * item.quantity}" type="currency" currencySymbol="₩ " />
					            </span>
					        </div>
					    </c:forEach>
					</c:if>
					
					<!-- 단일 상품 주문, cartList가 비어있을 경우에만 출력 -->
					<c:if test="${empty cartList && not empty product}">
					    <div class="order-item d-flex justify-content-between align-items-center">
					        <div>
					            <strong>${product.product_name}</strong> <br>
					            <small>
					                <c:forEach var="option" items="${options}" varStatus="idx">
					                    ${option['type']} : ${option['name']}<c:if test="${!idx.last}"> || </c:if>
					                </c:forEach>
					            </small> × ${quantity}
					        </div>
					        <span>
					            <fmt:formatNumber value="${product.product_price * quantity}" type="currency" currencySymbol="₩ " />
					        </span>
					    </div>
					</c:if>
									
				    <!-- 총액 계산 -->
				    <div class="total-price text-end mt-3">
				        Total: 
				        <span> 
				            <c:set var="totalPrice" value="0" />
				            <c:if test="${not empty cartList}">
				                <!-- 여러 상품 총액 계산 -->
				                <c:forEach var="item" varStatus="status" items="${cartList}">
				                    <c:set var="product" value="${productList[status.index]}" />
				                    <c:set var="itemTotal" value="${product.product_price * item.quantity}" />
				                    <c:set var="totalPrice" value="${totalPrice + itemTotal}" />
				                </c:forEach>
				            </c:if>
				            <c:if test="${not empty product}">
				                <!-- 단일 상품 총액 계산 -->
				                <c:set var="totalPrice" value="${product.product_price * quantity}" />
				            </c:if>
				            <fmt:formatNumber value="${totalPrice}" type="currency" currencySymbol="₩ " />
				        </span>
				    </div>
					<!-- 결제 버튼 -->
					<button type="button" class="btn payment-button btn-lg"
						onclick="validateAndSubmitForm()">결제하기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS and dependencies -->

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
		$(document).ready(function() {
			// 신규 배송지 선택 시: 기존 배송지 숨기고 신규 배송지 입력 필드 보여줌
			$("#newAddress").on("click", function() {
				$("#existingAddressFields").hide();
				$("#newAddressFields").show();
			});

			// 기존 배송지 선택 시: 신규 배송지 숨기고 기존 배송지 필드 보여줌
			$("#existingAddress").on("click", function() {
				$("#existingAddressFields").show();
				$("#newAddressFields").hide();
			});

			// 페이지 로드 시 기본 설정: 기존 배송지 필드만 보이도록 설정
			$("#existingAddressFields").show();
			$("#newAddressFields").hide();
			
			
			
			// 계좌이체 선택 시: 카드선택,할부선택 숨기고 계좌이체 안내 필드 보여줌
			$("#bankTransfer").on("click", function() {
				$("#creditCardField").hide();
				$(".payInfo").show();
			});

			// 신용카드 선택 시: 계좌이체 안내 숨기고 카드선택, 할부선택 필드 보여줌
			$("#creditCard").on("click", function() {
				$("#creditCardField").show();
				$(".payInfo").hide();
			});

			// 페이지 로드 시 기본 설정: 카드선택, 할부선택 필드만 보이도록 설정
			$("#creditCardField").show();
			$(".payInfo").hide();
			
			// 휴대폰결제 선택 시: 전부 숨김
			$("#mobilePayment").on("click", function() {
				$("#creditCardField").hide();
				$(".payInfo").hide();
			});
		});

		function openPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    document.getElementById("zipcode").value = data.zonecode;
                    document.getElementById("basicAddress").value = data.roadAddress;
                }
            }).open();
        }
		function validateAndSubmitForm() {
		    // 현재 보여지는 배송지 필드 그룹
		    let isExistingAddress = $("#existingAddressFields").is(":visible");
		    let isValid = true;

		    // 필요한 필드들을 선택하여 값이 비어있는지 확인
		    let fieldsToCheck = isExistingAddress ? $("#existingAddressFields .form-control") : $("#newAddressFields .form-control");

		    fieldsToCheck.each(function() {
		        if ($(this).val().trim() === "") {
		            $(this).addClass("is-invalid"); // Bootstrap 클래스를 사용해 시각적으로 표시
		            isValid = false;
		        } else {
		            $(this).removeClass("is-invalid"); // 유효한 경우 클래스 제거
		        }
		    });

		    if (!isValid) {
		        alert("모든 필드를 입력해 주세요.");
		        return;
		    }

		    // 유효성 검사가 통과되면 데이터를 수집하고 AJAX 요청으로 전송
		    let data = collectFormData();
		    console.log(data);
		    sendAjaxRequest(data);
		}

		function collectFormData() {
		    // 배송지 정보 수집
		    let isExistingAddress = $("#existingAddressFields").is(":visible");
		    let recipientName = isExistingAddress ? $("input[name='existingRecipientName']").val() : $("input[name='newRecipientName']").val();
		    let contact = isExistingAddress ? $("input[name='existingContact']").val() : $("input[name='newContact']").val();
		    let zipcode = isExistingAddress ? $("input[name='existingZipcode']").val() : $("input[name='newZipcode']").val();
		    let basicAddress = isExistingAddress ? $("input[name='existingBasicAddress']").val() : $("input[name='newBasicAddress']").val();
		    let detailAddress = isExistingAddress ? $("input[name='existingDetailAddress']").val() : $("input[name='newDetailAddress']").val();

		    // 결제 수단 정보 수집
		    let paymentMethod = $("input[name='paymentMethod']:checked").val();
		    let cardType = $("select[name='cardType']").val();
		    let installmentType = $("select[name='installmentType']").val();

			 // 주문 상품 정보 수집
		    let productIds = [];
		    let quantities = [];
		    let individualPrices = [];
		    let optionTypes = [];
		    let optionNames = [];
		    let totalAmount = 0;
		    
		    if ($("input[name='productIds']").length > 0) {
		        // 여러 상품 주문일 경우
		        $("input[name='productIds']").each(function() {
		            productIds.push($(this).val());
		        });
		        $("input[name='quantities']").each(function() {
		            quantities.push($(this).val());
		        });
		        $("input[name='individualPrices']").each(function() {
		            let price = parseFloat($(this).val());
		            individualPrices.push(price);
		        });
		        $("input[name='optionTypes']").each(function() {
		            optionTypes.push($(this).val().split(",")); // 예: "color,size" -> ["color", "size"]
		        });
		        $("input[name='optionNames']").each(function() {
		            optionNames.push($(this).val().split(",")); // 예: "blue,L" -> ["blue", "L"]
		        });
		        totalAmount = individualPrices.reduce((sum, price, idx) => sum + (price * quantities[idx]), 0);
		    } else {
		        // 단일 상품 주문일 경우
		        productIds.push($("input[name='productId']").val());
		        quantities.push($("input[name='quantity']").val());
		        individualPrices.push(parseFloat($("input[name='individualPrice']").val()));

		        // 여러 옵션을 가진 단일 상품의 모든 옵션 타입과 옵션 이름을 배열로 수집
		        let singleOptionTypes = [];
		        let singleOptionNames = [];
		        $("input[name='optionType']").each(function() {
		            singleOptionTypes.push($(this).val());
		        });
		        $("input[name='optionName']").each(function() {
		            singleOptionNames.push($(this).val());
		        });
		        optionTypes.push(singleOptionTypes); // 옵션 타입 배열 추가
		        optionNames.push(singleOptionNames); // 옵션 이름 배열 추가

		        totalAmount = individualPrices[0] * quantities[0];
		    }
		    
		    // 수집된 데이터 반환
		    let data = {
		            recipientName,
		            contact,
		            zipcode,
		            basicAddress,
		            detailAddress,
		            paymentMethod,
		            cardType,
		            installmentType,
		            productIds,
		            quantities,
		            individualPrices,
		            totalAmount,
		            optionTypes,
		            optionNames
		        };
		    return data;
		}

		function sendAjaxRequest(data) {
		    $.ajax({
		        url: "order",
		        method: "POST",
		        contentType: "application/json",
		        data: JSON.stringify(data),
		        success: function(response) {
		        	console.log("Received orderId:", response.orderId); // 로그 추가
	        	    alert(response.message);
	        	    window.location.href = "/app/user/orderSuccess?orderId=" + response.orderId;
		        },
		        error: function(xhr, status, error) {
		            alert("결제에 실패했습니다. 다시 시도해 주세요.");
		        }
		    });
		}
	</script>

</body>
</html>
