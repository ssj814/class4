<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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

.wish-item {
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

img {
	object-fit: contain; 
	max-height: 100px; 
	width: 100px;
}
</style>

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

<div class="main-title-container">
	<span>위시리스트</span> 
</div>

<div class="main-content-container">
	<div class="section-box">
		<div class="section-header d-flex align-items-center pe-2">
			<span>상품 정보</span>
			<button type="button" class="btn-allDel btn btn-outline-dark text-end ms-auto" >전체삭제</button>
		</div>
		<hr style="border: solid 1px black; opacity: inherit; ">
		<div class="form-group-inline">
			<div class="wish-items">
				<c:forEach var="item" varStatus="status" items="${wishProductList}">
					<div id="wish-${item.wish.wish_id}" class="wish-item row justify-content-between align-items-center" data-wishid="${item.wish.wish_id}">						
						<div class="col-2" style="width:100px; padding:10px;">
							<a href="/app/shopDetail?productId=${item.wish.product_id}"  style="text-decoration: none;">
			                	<img src="<c:url value='/images/shoppingMall_product/${item.product.product_imagename}'/>" alt="Image">
			              	</a>
			            </div>	
						<div class="col-6 text-start pb-3">
			                <h2 class="mb-1">
			                    <a href="/app/shopDetail?productId=${item.wish.product_id}" class="text-dark fw-bold text-decoration-none fs-6">
			                        ${item.product.product_name}
			                    </a>
			                </h2>
			                <!-- 옵션 표시 구역 -->
			                <c:if test="${not empty item.wish.option_type and not empty item.wish.option_name}">
		                    <c:forEach var="type" items="${fn:split(item.wish.option_type, ',')}" varStatus="status">
		                        <div class="option-info" data-type="${type}" data-name="${fn:split(item.wish.option_name, ',')[status.index]}">
		                            ${type}&nbsp;:&nbsp;<c:out value="${fn:split(item.wish.option_name, ',')[status.index]}" />
		                        </div>
		                    </c:forEach>
		                    </c:if>
			            </div>
			            <div class="col-2">
			            	<p class="mb-0"><fmt:formatNumber value="${item.product.product_price}" type="currency" currencySymbol="₩ " /></p>
			            </div>
						<div class="col-2 text-end pe-4">
						    <!-- 장바구니 버튼에 wish_id와 product_id 함께 전달 -->
						    <button type="button" class="btn-cart btn btn-outline-dark mb-1" data-id="${item.wish.wish_id}" data-product-id="${item.wish.product_id}" style="font-size:15px">장바구니</button><br>
						    <button type="button" class="btn-del btn btn-outline-dark" data-id="${item.wish.wish_id}" style="font-size:15px">삭제하기</button>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

</div>

<script>
	
	$(document).ready(function() {
		console.log("Document is ready");
	
		// 전체삭제
		$(".btn-allDel").on("click", function(){
			var delCheck = confirm("전체상품 삭제하시겠습니까?");
			var wishIdList = [];
			$(".wish-item").each(function(idx,data) {
				wishIdList.push($(this).data('wishid'));
			})
			console.log(wishIdList);
			if(delCheck){
	            $.ajax({
	                type: "DELETE",
	                url: "/app/wish/wishIdList/"+wishIdList,
	                dataType: "json",
	                success: function(resData, status, xhr) {
	                	console.log(resData);
		            	$("#mesg").html(resData.mesg);
		            	var messageModal = new bootstrap.Modal($('#messageModal')[0]);
		                messageModal.show();
		                wishIdList.forEach(function(data,idx) {
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
		
		// 장바구니 이동버튼
		 $(".btn-cart").on("click", function() {
        var wishId = $(this).data("id");           // wish_id
        var productId = $(this).data("product-id"); // product_id
        var productQuantity = 1;  // 수량을 무조건 1로 설정

        // 옵션 정보 수집
        var options = [];
        $("#wish-" + wishId).find(".option-info").each(function() {
            var optionType = $(this).data("type");
            var optionName = $(this).data("name");

            if (optionType && optionName) {
                options.push({
                    type: optionType,
                    name: optionName
                });
            }
        });

        // 서버에 전송할 데이터
        var requestData = {
            productId: productId,          // product_id 전송
            productQuantity: productQuantity,
            options: options
        };

        $.ajax({
            type: "POST",
            url: "/app/user/cart",
            contentType: "application/json",
            data: JSON.stringify(requestData),
            dataType: "json",
            success: function(resData) {
                console.log(resData);
                $("#mesg").html(resData.mesg);
                var messageModal = new bootstrap.Modal($('#messageModal')[0]);
                messageModal.show();
            },
            error: function(xhr, status, error) {
                alert("장바구니 추가 실패");
                console.log(error);
            }
        });
	});
		
		// Wish에서 삭제
		$(".btn-del").on("click", function(){
			var wishId = $(this).data("id");
            $.ajax({
                type: "DELETE",
                url: "/app/wish/wishId/"+wishId,
                success: function(resData, status, xhr) {
	                $("#wish-"+wishId).remove();
                },
                error: function(xhr, status, error) {
                    alert("실패");
                    console.log(error);
                }
           });
	    });
		
		
	});
	
</script>