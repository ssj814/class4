<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
		<div class="col-3 productDetail-right">
			<h2 class="product-name card-title fw-bold">${product.getProduct_name()}</h2>
			<div class="card mb-1">
				<div class="card-body d-flex flex-column">
					<p class="product-category">
						Category: <strong>${product.getProduct_category_id()}</strong>
					</p>
					<p class="product-price">
						Price: <strong>$${product.getProduct_price()}</strong>
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
					<p class="product_description">${product.getProduct_description()}</p>
				</div>
			</div>

			<span class="btn-wish fs-1" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="좋아요" style="cursor: pointer;">
                <i class="fa-solid fa-heart fs-3"></i>
            </span>
            <span class="btn-cart fs-1" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="장바구니" style="cursor: pointer;">
                <i class="fa-solid fa-cart-shopping fs-3 "></i>
            </span>
			<button class="mt-3" onclick="#">구매하기</button>
		</div>
		<div class="col-1"></div>
	</div>
	
	<!-- product_review -->
	<div class="container bg-light mt-5 mb-5">
		<p> 리뷰 보여질 공간 </p>
		<button id="Product-Review-openWindow">리뷰등록하기</button> <!-- 나중에 마이페이지로 이동 -->
	</div>
	
</div>

<script>
	
	$(function() {
		
		//review 새창열기
        $('#Product-Review-openWindow').on('click', function() {
        	var productId = $(".ProductId").val();
        	var width = 600;   
            var height = 700; 
            var left = Math.ceil((window.screen.width - width) / 2);
            var top = Math.ceil((window.screen.height - height) / 2);
            window.open('/app/shop_productReview/'+productId, '_blank', "width="+width+", height="+height+", left="+left+",top="+top +"scrollbars=yes");
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
	
	
		// cart 이동버튼
		$(".btn-cart").on("click", function(){
			var productId = $(".ProductId").val();
		        $.ajax({
		            type: "GET",
		            url: "cart",
		            dataType: "json",
		            data: { productId: productId },
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