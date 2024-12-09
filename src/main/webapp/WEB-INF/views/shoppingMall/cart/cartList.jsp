<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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

.cart-item {
	border-bottom: 1px solid #333;
	padding: 0px 0;
}

.form-label-inline {
	width: 100px;
	display: inline-block;
	font-weight: bold;
}

.form-group-inline {
	/* display: flex; */
	align-items: center;
	margin-bottom: 10px;
}

.cart-button {
	background-color: black;
	color: white;
	font-weight: bold;
	border-radius: 4px;
	border: none;
}

img {
	object-fit: contain; 
	max-height: 70px; 
	width: 70px;
}

input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}


</style>



<div class="main-title-container">
	<span>장바구니</span> 
	<span style="font-size: 18px;">
		00 장바구니 &gt;
		<span style="color:gray;">01 주문/결제 &gt;</span> 
		<span style="color:gray;">02 주문완료</span>
	</span>
</div>

<form method="post" class="container d-block p-0">
	<div class="main-content-container">
		<div class="section-box">
			<div class="section-header row">
				<div class="col-1 text-center">
					<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
				</div>
				<span class="col-6">상품 정보</span>
				<span class="col-1 text-center">금액</span>				
				<span class="col-2 text-center">개수</span>
				<span class="col-2 text-center">총액</span>
			</div>
			<hr style="border: solid 1px black; opacity: inherit; ">
			<div class="form-group-inline">
				<div class="cart-items">
					<c:forEach var="product" varStatus="status" items="${ProductList}">
						<div class="row align-items-center cart-item"
							style="margin-bottom: 0.3px">
							<input type="hidden" class="product-id" value="${product.getProduct_id()}">
							<input type="hidden" class="cart-id" value="${product.getCart_id()}">
							<div class="col-1 text-center">
								<input class="btn-product form-check-input m-0 border border-dark"
									type="checkbox" value="${product.getCart_id()}">
							</div>
							<div class="col-1 p-2">
								<img
									src="<c:url value='/images/shoppingMall_product/${product.getProduct_imagename()}'/>"
									alt="Image">
							</div>
							<div class="col-5 text-start pb-2">
								<h2 class="mb-0">
									<a href="/app/shopDetail?productId=${product.getProduct_id()}"
										class="text-dark fw-bold text-decoration-none fs-6">${product.getProduct_name()}</a>
								</h2>
								<c:if test="${product.hasOptions}">
								<c:forEach var="entry" items="${product.groupedOptions}">
								    <div class="product-option-container">
								        <label>${entry.key}:</label>
								        <select name="${entry.key}">
								            <c:forEach var="option" items="${fn:split(entry.value, ',')}">
						                        <c:set var="optionName" value="${fn:split(option, '|')[0]}" />
						                        <c:set var="stock" value="${fn:split(option, '|')[1]}" />
								                
								                <c:set var="isSelected" value="false" />
								                <!-- 선택된 옵션에서 option_type과 option_name을 쉼표로 분리 -->
								                <c:forEach var="selectedOption" items="${product.selectedOptions}">
								                    <c:forEach var="selectedOptionType" items="${fn:split(selectedOption.option_type, ',')}">
								                        <c:forEach var="selectedOptionName" items="${fn:split(selectedOption.option_name, ',')}">
								                            <c:if test="${selectedOption.cart_id == product.cart_id 
								                                and selectedOptionType == entry.key
								                                and selectedOptionName == optionName}">
								                                <c:set var="isSelected" value="true" />
								                            </c:if>
								                        </c:forEach>
								                    </c:forEach>
								                </c:forEach>
								
								                <option value="${optionName}" <c:if test="${isSelected}">selected</c:if>>
								                ${optionName} [남은 수량: ${stock}]
								                </option>
								            </c:forEach>
								        </select>
								    </div>
								</c:forEach>
								</c:if>
								<!-- 옵션이 없는 경우 -->
								<c:if test="${!product.hasOptions}">
				                	<div class="product-option-container">남은 수량: <strong>${product.stock}</strong></div>
				            	</c:if>
							</div>
								 
				            
							<div class="col-1">
								<span id="price-${product.getCart_id()}" class="mb-1">
									<fmt:formatNumber value="${product.getProduct_price()}" type="currency" currencySymbol="₩" />
								</span>	
							</div>

							<div class="col-2">
								<div class="input-group">
						            <button class="btn btn-outline-dark decrease" type="button">-</button>
									<input name="product-count-${product.getCart_id()}"
										class="product-count form-control text-center"
										id="count-${product.getCart_id()}"
										data-id="${product.getCart_id()}" type="number" min="1"
										value="${product.getQuantity()}">
									<button class="btn btn-outline-dark increase" type="button">+</button>
								</div>	
							</div>
							
							<div class="col-2">
								<input name="product-totalPrice-${product.getCart_id()}"
									id="total-${product.getCart_id()}" class="total form-control"
									type="text" disabled
									value="${product.getProduct_price()*product.getQuantity()}">
							</div>
						</div>
					</c:forEach>
					
					<div class="row align-items-center pt-2" style="margin-bottom: 0.3px">
						<div class="col-2">
							<button id="btn-delete" class="btn cart-button">삭제</button>
						</div>
						<div class="col-6"></div>
						<div class="col-2">
							<input type="text" class="order-count form-control" disabled value="0">
						</div>
						<div class="col-2">
							<input class="order-total form-control" type="text" disabled value="0">
						</div>
					</div>
				</div>
			</div>
					
			<div class="text-center">
				<button id="btn-order" class="btn cart-button" style="margin: 10px 0; height: 40px; width: 150px;">주문하기</button>
			</div>
			
		</div>
	</div>
</form>


<script>
	$(document).ready(
			function() {
				
				//+,- 버튼
				$('.increase').click(function() {
				    var input = $(this).closest('.input-group').find('.product-count'); 
				    console.log(input);
				    var value = parseInt(input.val()) || 0; 
				    input.val(value + 1).trigger('change');;
				});
				
				$('.decrease').click(function() {
				    var input = $(this).closest('.input-group').find('.product-count');
				    var value = parseInt(input.val()) || 0;
				    if (value > 1) input.val(value - 1).trigger('change');; 
				});
				
				//개별 상품 total 통화기호 표시
				$('.total').each(function() {
		            let value = $(this).val();
		            $(this).val(value ? Number(value).toLocaleString() : '');
		        });
				
				// 총 구매 상품 개수와 금액 계산 함수
				function calculateTotal() {
					var count = 0;
					var total = 0;

					$(".btn-product").each(function(idx, data) {
						if (data.checked) {
							var cartId = $(data).val();
							count += parseInt($("#count-" + cartId).val());
				            total += parseInt($("#total-" + cartId).val().replace(/,/g, ''));
						}
					});

					$(".order-count").val(count);
					$(".order-total").val(total.toLocaleString() + ' 원');
				}
				
				// Quantity 업데이트 + 개별 total 계산 + 총 구매 개수 및 금액 업데이트
				$(".product-count").on(
						"change",
						function() {
							var cartId = $(this).data("id");
						    var quantity = $(this).val();
						    var price = parseInt($("#price-" + cartId).text().replace(/,/g, '').replace(/₩/g, ''));
							var total = quantity * price;
						
							// 개별 상품 총액 업데이트
							$("#total-" + cartId).val(total.toLocaleString());
							
							if(quantity<1){
								quantity = 1;
								$(this).val(1);
								$("#total-" + cartId).val(price);
							}

							// 서버에 수량 업데이트 요청
							$.ajax({
								url : "/app/cartQuantity",
								type : "post",
								data : {
									cartId: cartId, 
									quantity : quantity
								},
								success : function(data, status, xhr) {
									console.log(status);
								},
								error : function(xhr, status, error) {
									console.log(error);
								}
							});

							// 총 구매 개수와 금액 업데이트
							calculateTotal();
						});

				// 선택된 상품들, 총 구매 개수, 금액 설정하기 (체크박스 변경 시)
				$(".btn-product").on("change", function() {
					calculateTotal();
				});

				// 전체선택 checkbox, 총 구매 개수, 금액 설정하기
				$("#flexCheckDefault").on("click", function() {
					var ck = this.checked;
					$(".form-check-input").each(function(idx, data) {
						data.checked = ck;
					});

					// 총 구매 개수와 금액 업데이트
					calculateTotal();
				});

				// 결제화면으로 넘어갈때 체크 데이터 가지고 넘어가기
				$("#btn-order").on("click",	function() {
					var cartIdList = [];
						
					$(".form-check-input").each(function(idx, data) {
				        if (data.checked) {
				            cartIdList.push($(data).val());
				        }
				    });

				    // 체크된 상품이 하나도 없으면 경고창 띄우고 이동 막기
				    if (cartIdList.length === 0) {
				        alert("결제할 상품을 선택해 주세요.");
				        event.preventDefault(); // 폼 제출 막기
				        return;
				    }
						    
					$("form").attr("action","orderpayment?cartIdList="+ cartIdList);
				});



				// 선택된 항목 삭제
				$("#btn-delete").on("click", function() {
					var selectedCartIds = [];
				    $(".form-check-input:checked").each(function() {
				        selectedCartIds.push($(this).closest(".row").find(".cart-id").val());
				    });

				    if (selectedCartIds.length === 0) {
				        alert("삭제할 항목을 선택해 주세요.");
				        return;
				    }

					$.ajax({
						url : "/app/cartDelete",
						type : "post",
						data : {
							cartIds: selectedCartIds
						},
						traditional : true, // 배열 형태로 파라미터를 전달하기 위해 필요
						success : function() {
							location.reload();

							// 총 구매 개수와 금액 업데이트
							calculateTotal();
						},
						error : function(xhr, status, error) {
							console.log("삭제 실패: " + error);
						}
					});
				});

				$(".product-option-container select").on("change", function () {
					var productId = $(this).closest(".row").find(".product-id").val();
				    var cartId = $(this).closest(".row").find(".cart-id").val();
				    var Qty = $(this).closest(".row").find(".product-count").val();
				    var options = [];
				    $(this).closest(".row").find(".product-option-container select").each(function() {
				        options.push({
				            type: $(this).attr("name"),
				            name: $(this).val()
				        });
				    });

				    $.ajax({
				        url: "/app/updateCartOption",
				        type: "POST",
				        dataType: "json",
				        contentType: "application/json",
				        data: JSON.stringify({
				            productId: productId,
				            cartId: cartId,
				            options: options,
				            Qty: Qty
				        }),
				        success: function (resData) {
				            console.log("옵션 변경 성공: " + resData.mesg);
				            location.reload();
				        },
				        error: function (xhr, status, error) {
				            console.log("옵션 변경 실패: " + error);
				        }
				    });
				});
				
				// 초기 총계 계산
				calculateTotal();
			});
</script>

