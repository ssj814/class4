<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Modal -->
<div class="modal fade" id="messageModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div id="mesg" class="modal-body"></div>
            <div class="modal-footer border-top-0">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<h1 class="text-center mt-2">위시리스트</h1>

    <div class="container text-center d-block p-0">
    	<c:forEach var="product" items="${ProductList}">
            <div id="wish-${product.getProduct_id()}" class="row align-items-center border border-dark rounded" style="margin-bottom:0.3px">
           		<div class="col-1">
					<input class="product-check form-check-input m-0 border border-dark" type="checkbox" value="${product.getProduct_id()}">
				</div>
                <div class="col-2">
                	<a href="shopDetail?productId=${product.getProduct_id()}">
                		<img src="<c:url value='/images/shoppingMall_product/${product.getProduct_imagename()}'/>"  alt="Image" class="w-75" style="object-fit: contain; max-height: 100px; width: 100%;">
                	</a>
                </div>
                <div class="col-5 text-start">
                	<h2>
                		<a href="shopDetail?productId=${product.getProduct_id()}" class="text-dark fw-bold text-decoration-none fs-6">${product.getProduct_name()}</a>
                	</h2>
                	<!-- 옵션 -->
                	
                	 <p><fmt:formatNumber value="${product.getProduct_price()}" type="currency" currencySymbol="₩" /></p>
                </div>
                <div class="col-1"></div>
                <div class="col-1"></div>
                <div class="col-1"> 
                	<button type="button" class="btn-cart btn btn-outline-dark mb-1" data-id="${product.getProduct_id()}" style="font-size:15px">장바구니</button>
                	<button type="button" class="btn-del btn btn-outline-dark" data-id="${product.getProduct_id()}" style="font-size:15px">삭제하기</button>
                </div>
            </div>
		</c:forEach>
		<div class="text-start mt-2">
       		<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
 		 	<label class="form-check-label" for="flexCheckDefault">전체선택</label>
 		 	<button type="button" class="btn-allDel btn btn-outline-dark">선택삭제</button>
		</div>
    </div>

<script>
	
	$(document).ready(function() {
		
		// 선택상품 전체삭제
		$(".btn-allDel").on("click", function(){
			var delCheck = confirm("선택된 상품을 삭제하시겠어요?");
			var productIdList = [];
			$(".product-check").each(function(idx,data) {
				if(data.checked){
					productIdList.push($(data).val());
				}
			})
			if(delCheck){
	            $.ajax({
	                type: "DELETE",
	                url: "wish/productIdList/"+productIdList,
	                dataType: "json",
	                success: function(resData, status, xhr) {
	                	console.log(resData);
		            	$("#mesg").html(resData.mesg);
		            	var messageModal = new bootstrap.Modal($('#messageModal')[0]);
		                messageModal.show();
		                productIdList.forEach(function(data,idx) {
							$("#wish-"+data).remove();
						})   
	                },
	                error: function(xhr, status, error) {
	                    alert("삭제 실패");
	                    console.log(error);
	                }
	           });
			}
	    });
		
		// 전체선택 checkbox
		$("#flexCheckDefault").on("click",function(){
			var ck = this.checked ;
			$(".form-check-input").each(function(idx,data) {
				data.checked = ck;
			})
		});
		
		// 장바구니 이동버튼
		$(".btn-cart").on("click", function(){
			var productId = $(this).data("id");
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
		
		// Wish에서 삭제
		$(".btn-del").on("click", function(){
			var productId = $(this).data("id");
            $.ajax({
                type: "DELETE",
                url: "wish/productId/"+productId,
                success: function(resData, status, xhr) {
	                $("#wish-"+productId).remove();
                },
                error: function(xhr, status, error) {
                    alert("실패");
                    console.log(error);
                }
           });
	    });
		
		
	})
	
</script>

