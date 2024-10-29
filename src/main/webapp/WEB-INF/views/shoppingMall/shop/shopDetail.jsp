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
					            <c:forEach var="name" items="${fn:split(option.option_name, ',')}">
					                <option value="${name}">${name}</option>
					            </c:forEach>
					        </select>
					    </div>
					</c:forEach>
					<!-- 수량 선택 -->
					<label>quantity</label>
					<input type="number" min="1" class="product-quantity form-control" value="1">
					
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
	            <button class="mt-3 w-100" onclick="#">구매하기</button>		
			</div>
		</div>
		<div class="col-0"></div>
	</div>
	
</div>

<script>
	
	$(function() {
		
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
			var productId = $(".ProductId").val();
		        $.ajax({
		            type: "GET",
		            url: "wish",
		            dataType: "json",
		            data: { productId: productId },
		            success: function(resData, status, xhr) {
		            	$("#mesg").html(resData.mesg);
		            	var messageModal = new bootstrap.Modal($('#messageModal')[0]);
		                messageModal.show();
		            },
		            error: function(xhr, status, error) {
		                alert("실패");
		                console.log(error);
		            }
		    });
		});
	
	
		// cart 이동버튼
		$(".btn-cart").on("click", function(){
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
		            url: "cart",
		            dataType: "json",
		            contentType: "application/json",
		            data: JSON.stringify({
	                    productId: productId,
	                    options: options,
	                    productQuantity: productQuantity
	                }),
		            success: function(resData, status, xhr) {
		            	console.log(resData);
		            	$("#mesg").html(resData.mesg);
		            	var messageModal = new bootstrap.Modal($('#messageModal')[0]);
		                messageModal.show();
		            },
		            error: function(xhr, status, error) {
		                alert("실패");
		                console.log(error);
		            }
		    });
		});
		
		const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
		const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
	
	});
	
</script>