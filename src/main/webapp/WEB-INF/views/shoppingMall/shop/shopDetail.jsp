<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<link href="resources/css/shoppingMall/shopDetail.css" rel="stylesheet">

<!-- Modal -->
<div class="modal fade" id="messageModal" tabindex="-1"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div id="mesg" class="modal-body"></div>
			<div class="modal-footer border-top-0">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<div class="container">

	<input type="hidden" class="ProductId" value="${product.getProduct_id()}">

	<!-- product -->
	<div class="row productDetail-container">
		<div class="col-7 productDetail-middle">
			<img src="<c:url value='/images/shoppingMall_product/${product.getProduct_imagename()}'/>"  alt="Image"
				class="img-fluid" style="object-fit: contain; max-height: 500px;">
		</div>
		<div class="col-1"></div>
		<div class="col-4 productDetail-right">
			<h2 class="product-name card-title fw-bold">${product.getProduct_name()}</h2>
			<div class="card mb-1">
				<div class="card-body d-flex flex-column">
					<p class="product-category">
					    Category: 
					    <strong>
					        <c:forEach var="category" items="${CategoryList}">
					            <c:if test="${category.product_category_id == product.getProduct_category_id()}">
					                ${category.product_category_eng_name}
					            </c:if>
					        </c:forEach>
					    </strong>
					</p>
					<p class="product-price">
						Price: <strong><fmt:formatNumber value="${product.getProduct_price()}" type="currency" currencySymbol="₩ " /></strong>
					</p>
					<p class="product-inventory">
						In Stock: <strong>${product.getProduct_inventory()}</strong>
					</p>
					<p class="product-status">
						Status:
						<c:choose>
							<c:when test="${product.getProduct_isactive() == '1'}">
								<span class="badge bg-success">판매중</span>
							</c:when>
							<c:otherwise>
								<span class="badge bg-danger">품절</span>
							</c:otherwise>
						</c:choose>
					</p>
					<p class="product_like pb-1">
						View: <strong>${product.getProduct_view()}</strong>
					</p>
					<hr class="container pb-0">
					<!-- product_option 출력 -->
					<c:forEach var="option" items="${options}">
					    <div class="product-option-container">
					        <label>${option.option_type}</label>
					        <select class="form-select">
					            <c:forEach var="name" items="${fn:split(option.option_name, ',')}" varStatus="status">
						            <c:set var="stockValue" value="${fn:split(option.stock, ',')[status.index]}" />
					                <option value="${name}">${name} [수량 : ${stockValue}]</option>
					            </c:forEach>
					        </select>
					    </div>
					</c:forEach>
					<!-- 수량 선택 -->
					<label>quantity</label>
					<div class="input-group">
			            <input class="btn btn-dark decrease" type="button" value="-">
						<input class="product-quantity form-control text-center" type="number" min="1" value="1">
						<input class="btn btn-dark increase" type="button" value="+">
					</div>	
					<hr class="container pb-0">
					<p class="product_description">${product.getProduct_description()}</p>
				</div>
			</div>
			
			<div class="mt-4 mb-0 d-flex justify-content-between">
				<h2 class="fw-bold">TOTAL</h2>
				<h2 class="total-price me-3"><fmt:formatNumber value="${product.getProduct_price()}" type="currency" currencySymbol="₩ " /></h2>
			</div>
			
			<hr class="container pb-0 my-0 opacity-100 border border-dark border-3">
			
			<div class="d-flex">
				<button class="btn-wish mt-3 me-1" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="좋아요" style="cursor: pointer;">
	            	<i class="fa-solid fa-heart"></i>
	            </button>   
	            <button class="btn-cart mt-3 me-2" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="장바구니" style="cursor: pointer;">
	            	<i class="fa-solid fa-cart-shopping "></i>
	            </button>
	            
	            <form id="orderForm" action="user/singleOrderPayment" method="post">
				    <input type="hidden" name="productId" value="${product.getProduct_id()}">
				    <input type="hidden" name="quantity" class="product-quantity" value="1">
				    
				    <!-- 옵션 타입과 옵션 이름을 담을 hidden inputs -->
				    <c:forEach var="option" items="${options}">
				        <input type="hidden" name="optionType" value="${option.option_type}">
				        <input type="hidden" name="optionName_${option.option_type}" class="hidden-option-name">
				    </c:forEach>
				    
				    <button type="button" class="btn-buy mt-3 w-100">구매하기</button>
				</form>
				
			</div>
		</div>
	</div>
</div>

<script>
	
	$(function() {
		
		// 로그인 유저 정보
		const loginUser = `${sessionScope.SPRING_SECURITY_CONTEXT.authentication.name }`;
		
		// 수량 입력 필드 변경 시 히든 태그 값 업데이트
	    $(".product-quantity").on("change", function () {
	        const quantity = $(this).val();
	        $("input[name='quantity']").val(quantity); // 히든 태그에 값 동기화
	    });
		
		// + 버튼 클릭 이벤트
		$('.increase').click(function() {
		    var input = $(this).closest('.input-group').find('.product-quantity'); // 클래스 이름 수정
		    console.log(input);
		    var value = parseInt(input.val()) || 0;
		    input.val(value + 1).trigger('change'); // 값 변경 후 change 이벤트 트리거
		});

		// - 버튼 클릭 이벤트
		$('.decrease').click(function() {
		    var input = $(this).closest('.input-group').find('.product-quantity'); // 클래스 이름 수정
		    var value = parseInt(input.val()) || 0;
		    if (value > 1) input.val(value - 1).trigger('change'); // 값 변경 후 change 이벤트 트리거
		});
		
		// total 계산
		$(".product-quantity").on("change", function(){
			var productPrice = `${product.getProduct_price()}`;
			var productQuantity = $(this).val();
			var totalPrice = Number(productPrice*productQuantity).toLocaleString();
			if(productQuantity <= 0){
				$(".product-quantity").val(1);
			} else {
				$(".total-price").html("₩ "+totalPrice);
			}
		});
		
		// wish 이동버튼
		$(".btn-wish").on("click", function(){
			
			if(!loginUser){
				return modalShow("로그인하세요.");
			}
			
			var productId = $(".ProductId").val();
			var options = [];

		    // 각 옵션의 타입과 선택된 값 가져오기
		    $(".product-option-container").each(function() {
		        var optionType = $(this).find("label").text().trim();  // 옵션 타입
		        var optionName = $(this).find("select").val();  // 옵션 이름
		        if (optionType && optionName) {
		            options.push({
		                type: optionType,
		                name: optionName
		            });
		        }
		    });
			
		        $.ajax({
		            type: "GET",
		            url: "wish",
		            dataType: "json",
		            data: { 
		                productId: productId,
		                options: JSON.stringify(options)
		            },
		            success: function(resData, status, xhr) {
		            	modalShow(resData.mesg);
		            },
		            error: function(xhr, status, error) {
		                alert("실패");
		                console.log(error);
		            }
		    });
		});
	
	
		// cart 이동버튼
		$(".btn-cart").on("click", function(){
			
			if(!loginUser){
				return modalShow("로그인하세요.");
			}
			
			var productId = parseInt($(".ProductId").val());
			var options = [];
			 // 각 옵션의 타입과 선택된 값 가져오기
             $(".product-option-container").each(function() {
                var optionType = $(this).find("label").text().trim();  // 옵션 타입
                var optionName = $(this).find("select").val();  // 옵션 이름
                if (optionType && optionName) {
                    options.push({
                        type: optionType,
                        name: optionName
                    });
                }
            });
			//상품 수량 
			var productQuantity = parseInt($(".product-quantity").val());
			if(productQuantity<1){
				productQuantity = 1;
				$(".product-quantity").val(1);
			}
		        $.ajax({
		            type: "POST",
		            url: "user/cart",
		            dataType: "json",
		            contentType: "application/json",
		            data: JSON.stringify({
	                    productId: productId,
	                    options: options,
	                    productQuantity: productQuantity
	                }),
		            success: function(resData, status, xhr) {
		                modalShow(resData.mesg);
		            },
		            error: function(xhr, status, error) {
		                alert("실패");
		                console.log(error);
		            }
		    });
		});
		
		//모달창 함수
		function modalShow(mesg) {
			$("#mesg").html(mesg);
        	var messageModal = new bootstrap.Modal($('#messageModal')[0]);
            messageModal.show();
		}
		
		const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
		const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
		
	});
	
	$(document).ready(function() {
		// 구매하기 버튼 클릭 시, 선택된 옵션 값을 hidden inputs에 설정
		$(".btn-buy").on("click", function() {
			$(".product-option-container").each(function() {
	            // 옵션 타입과 선택된 옵션 이름을 가져옵니다.
	            let optionType = $(this).find("label").text().trim();
	            const optionName = $(this).find("select").val();

	            const selector = "input[name='optionName_" + optionType + "']";
	            console.log("Selector:", selector);

	            const hiddenInput = $(selector);
	            console.log("hidden input : ", hiddenInput);
	            if (hiddenInput.length > 0) {
	                // hidden input에 옵션 이름 설정 (attr와 val 모두 사용)
	                hiddenInput.attr('value', optionName);
	                hiddenInput.val(optionName);
	                
	                console.log(`Successfully set hidden input value for ${optionType}: ${hiddenInput.val()}`);
	                console.log(`Hidden input attr value for ${optionType}: ${hiddenInput.attr('value')}`);
	            } else {
	                console.error(`Hidden input not found for option type: ${optionType}`);
	            }
	        });
            /* event.preventDefault(); */
            // 폼 전송
             $("#orderForm").submit(); 
        });
    });
</script>