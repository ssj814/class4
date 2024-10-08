<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<h1 class="text-center mt-2">장바구니</h1>

<form method="post" class="container text-center d-block p-0">
	<c:forEach var="product" items="${ProductList}">
		<div class="row align-items-center border border-dark rounded"
			style="margin-bottom: 0.3px">
			<div class="col-1">
				<input class="btn-product form-check-input m-0 border border-dark"
					type="checkbox" value="${product.getProduct_id()}">
			</div>
			<div class="col-2">
				<img
					src="<c:url value='/images/shoppingMall_product/${product.getProduct_imagename()}'/>"
					alt="Image" class="w-75"
					style="object-fit: contain; max-height: 100px; width: 100%;">
			</div>
			<div class="col-5 text-start">
				<h2>
					<a href="shopDetail?productId=${product.getProduct_id()}"
						class="text-dark fw-bold text-decoration-none fs-6">${product.getProduct_name()}</a>
				</h2>
				<c:forEach var="option" items="${product.allOptions}">
				    <div>
				        <label>${option.option_type}:</label>
				        <select name="${option.option_type}">
				            <c:forEach var="name" items="${fn:split(option.option_name, ',')}">
				                <c:set var="isSelected" value="false" />
				
				                <!-- 선택된 옵션에서 option_type과 option_name을 쉼표로 분리 -->
				                <c:forEach var="selectedOption" items="${product.selectedOptions}">
				                    <c:forEach var="selectedOptionType" items="${fn:split(selectedOption.option_type, ',')}">
				                        <c:forEach var="selectedOptionName" items="${fn:split(selectedOption.option_name, ',')}">
				                            <c:if test="${selectedOption.cart_id == product.cart_id 
				                                and selectedOptionType == option.option_type 
				                                and selectedOptionName == name}">
				                                <c:set var="isSelected" value="true" />
				                            </c:if>
				                        </c:forEach>
				                    </c:forEach>
				                </c:forEach>
				
				                <option value="${name}" <c:if test="${isSelected}">selected</c:if>>${name}</option>
				            </c:forEach>
				        </select>
				    </div>
				</c:forEach>
				₩ <span id="price-${product.getProduct_id()}">${product.getProduct_price()}</span>
			</div>
			<div class="col-2">
				<p>개수</p>
				<input name="product-count-${product.getProduct_id()}"
					class="product-count form-control"
					id="count-${product.getProduct_id()}"
					data-id="${product.getProduct_id()}" type="number" min="1"
					value="${product.getQuantity()}">
			</div>
			<div class="col-2">
				<p>total</p>
				<input name="product-totalPrice-${product.getProduct_id()}"
					id="total-${product.getProduct_id()}" class="total form-control"
					type="text" disabled
					value="${product.getProduct_price()*product.getQuantity()}">
			</div>
		</div>
	</c:forEach>
	<div class="row align-items-center">
		<div class="col-2">
			<input class="form-check-input" type="checkbox" value=""
				id="flexCheckDefault"> <label class="form-check-label"
				for="flexCheckDefault">전체선택</label>
		</div>
		<div class="col-1">
			<input type="button" id="btn-delete" value="삭제">
		</div>
		<div class="col-5"></div>
		<div class="col-2">
			<span>총 구매 상품개수</span> <input type="text"
				class="order-count form-control" disabled value="0">
		</div>
		<div class="col-2">
			<span>총 구매 가격</span> <input class="order-total form-control"
				type="text" disabled value="0">
		</div>
	</div>
	<button id="btn-order" style="margin: 20px 0">결제화면으로 넘어가는 버튼</button>
</form>



<script>
	$(document).ready(
			function() {
				// Quantity 업데이트 + 개별 total 계산 + 총 구매 개수 및 금액 업데이트
				$(".product-count").on(
						"change",
						function() {
							var productId = $(this).data("id");
							var quantity = $(this).val();
							var price = parseInt($("#price-" + productId)
									.text().replace(/,/g, ''));
							var total = quantity * price;

							// 개별 상품 총액 업데이트
							$("#total-" + productId).val(total);

							// 서버에 수량 업데이트 요청
							$.ajax({
								url : "cartQuantity",
								type : "post",
								data : {
									productId : productId,
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
				$("#btn-order")
						.on(
								"click",
								function() {
									var productIdList = [];
									$(".form-check-input").each(
											function(idx, data) {
												if (data.checked) {
													productIdList.push($(data)
															.val());
												}
											});
									$("form").attr(
											"action",
											"orderList?productIdList="
													+ productIdList);
								});

				// 총 구매 상품 개수와 금액 계산 함수
				function calculateTotal() {
					var count = 0;
					var total = 0;

					$(".btn-product").each(function(idx, data) {
						if (data.checked) {
							var productId = $(data).val();
							count += parseInt($("#count-" + productId).val());
							total += parseInt($("#total-" + productId).val());
						}
					});

					$(".order-count").val(count);
					$(".order-total").val(total.toLocaleString() + ' 원');
				}

				// 선택된 항목 삭제
				$("#btn-delete").on("click", function() {
					var selectedProductIds = [];
					$(".form-check-input:checked").each(function() {
						selectedProductIds.push($(this).val());
					});

					if (selectedProductIds.length === 0) {
						alert("삭제할 항목을 선택해 주세요.");
						return;
					}

					$.ajax({
						url : "cartDelete",
						type : "post",
						data : {
							productIds : selectedProductIds
						},
						traditional : true, // 배열 형태로 파라미터를 전달하기 위해 필요
						success : function() {
							// 선택된 항목 삭제 후 DOM에서 제거
							selectedProductIds.forEach(function(id) {
								$("#row-" + id).remove(); // 각 상품의 행 삭제
								location.reload();
							});

							// 총 구매 개수와 금액 업데이트
							calculateTotal();
						},
						error : function(xhr, status, error) {
							console.log("삭제 실패: " + error);
						}
					});
				});

				// 초기 총계 계산
				calculateTotal();
			});
</script>

