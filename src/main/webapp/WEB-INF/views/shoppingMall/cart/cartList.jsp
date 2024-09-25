<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
<h1 class="text-center mt-2">장바구니</h1>
	
	<form method="post" class="container text-center d-block p-0" >
		<c:forEach var="product" items="${ProductList}">
			<div class="row align-items-center border border-dark rounded" style="margin-bottom:0.3px">
				<div class="col-1">
					<input class="btn-product form-check-input m-0 border border-dark" type="checkbox" value="${product.getProduct_id()}">
				</div>
				<div class="col-2">
					<img src="<c:url value='/images/shoppingMall_product/${product.getProduct_imagename()}'/>"  alt="Image" class="w-75" style="object-fit: contain; max-height: 100px; width: 100%;">
				</div>
				<div class="col-5 text-start">
					<h2>
						<a href="shopDetail?productId=${product.getProduct_id()}" class="text-dark fw-bold text-decoration-none fs-6" >${product.getProduct_name()}</a>
					</h2>
					₩ <span id="price-${product.getProduct_id()}">${product.getProduct_price()}</span>
				</div>
				<div class="col-2">
					<p>개수</p>
					<input name="product-count-${product.getProduct_id()}" class="product-count" id="count-${product.getProduct_id()}" data-id="${product.getProduct_id()}" type="number" min="1" value="${product.getQuantity()}" >
				</div>
				<div class="col-2">
					<p>total</p>
					<input name="product-totalPrice-${product.getProduct_id()}" id="total-${product.getProduct_id()}" class="total" type="text" disabled value="${product.getProduct_price()*product.getQuantity()}">
				</div>
			</div>
		</c:forEach>
		<div class="row align-items-center">
			<div class="col-2">
       			<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
 		 		<label class="form-check-label" for="flexCheckDefault">전체선택</label><br> 
			</div>
			<div class="col-6"></div>
			<div class="col-2">
				<span>총 구매 상품개수</span> 
				<input type="text" class="order-count" disabled value="0" >
			</div>
			<div class="col-2">
				<span>총 구매 가격</span>
				<input class="order-total" type="text" disabled value="0">
			</div>
		</div>
		
		<button id="btn-order">결제화면으로 넘어가는 버튼</button>
	
	</form>
	
	

<script>
	
	$(document).ready(function() {
		
		// Quantity 업데이트 + total 계산
		$(".product-count").on("change",function(){
			var ProuctId = $(this).data("id");
			var Quantity = $(this).val();
	        $.ajax({
		        url : "cartQuantity",
		        type : "post",
		        data : {
		        	ProuctId:ProuctId,
		        	Quantity:Quantity
		        },
		        success: function (data,status,xhr){
		            console.log(status);
		        },
		        error:function(xhr,status,error){
		            console.log(error);
		        }
	        });
	    });
	    
		// 개수에 따른 개별 total 계산
		$(".product-count").on("change",function(){
			var ProuctId = $(this).data("id");
			var Quantity = $(this).val();
			var price = $("#price-"+ProuctId).text();
			$("#total-"+ProuctId).val(Quantity*price);
		})
		
		// 선택된 상품들, 총구매 개수, 금액 설정하기
		$(".btn-product").on("change",function(){
			var totalCount = $(this).val();
			var count = 0;
			var total = 0;
			$(".btn-product").each(function(idx,data) {
				if(data.checked){
					var ProductId = $(data).val();
					count += parseInt($("#count-"+ProductId).val());
					total += parseInt($("#total-"+ProductId).val());
				}
			});
			$(".order-count").val(count);
			$(".order-total").val(total);
		})
				
		// 전체선택 checkbox, 총구매 개수, 금액 설정하기
		$("#flexCheckDefault").on("click",function(){
			var ck = this.checked ;
			$(".form-check-input").each(function(idx,data) {
				data.checked = ck;
			})
			var count = 0;
			var total = 0;
			$(".btn-product").each(function(idx,data) {
				if(data.checked){
					var ProductId = $(data).val();
					count += parseInt($("#count-"+ProductId).val());
					total += parseInt($("#total-"+ProductId).val());
				}
			});
			$(".order-count").val(count);
			$(".order-total").val(total);
		})
		
		// 결제화면으로 넘어갈때 체크 데이터 가지고 넘어가기
		$("#btn-order").on("click",function(){
			var productIdList = [];
			$(".form-check-input").each(function(idx,data) {
				if(data.checked){
					productIdList.push($(data).val());
				}
			})
			$("form").attr("action", "orderList?productIdList="+productIdList);
		})
		
		
	})
	
</script>

