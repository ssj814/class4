<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="container mt-3 mb-5">
	<input type="hidden" class="ProductId" value="${product.getProduct_id()}"> 
	<div class="d-flex justify-content-between align-items-center">
	    <h2 class="align-items-center">상품 리뷰</h2>
	    <button id="Product-Review-openWindow">리뷰 등록하기</button>
	</div>
    <div class="card">
        <div class="list-group list-group-flush">
        	<c:forEach var="productReview" items="${productReview}">
	            <div class="list-group-item m-3">
	            	<div class="d-flex align-items-start mb-3">
	                	<img src="https://via.placeholder.com/50" alt="사용자1 이미지" class="rounded-circle me-3" style="width: 50px; height: 50px;">            	
	                	<div>
		                	<h6 class="mb-0 mt-1">${productReview.user_id} <small class="text-muted">${productReview.create_date}</small></h6>
		                	<small class="text-muted">평점: ★★★☆☆ ${productReview.rating}</small>
	                	</div>
	                </div>
	                <hr>
					<div class="d-flex">
					    <div>
					    	<c:if test="${not empty productReview.photos}">
					    		<c:set var="photoList" value="${fn:split(productReview.photos, ',')}" />
					    		<c:forEach var="photo" items="${photoList}">
							    	<img src="<c:url value='/images/shoppingMall_review/${photo}'/>"  
							    		alt="사용자 사진" class="img-fluid mb-2" style="width: 100px; height: 100px; object-fit: cover;"/>
							   </c:forEach>
					    	</c:if>
					        <p class="mb-1">${productReview.content}</p>
					    </div>
					    <div class="ms-auto">
					        <button class="update-productReview btn btn-outline-dark me-2 btn-sm" data-reviewid="${productReview.review_id}">
					        	<i class="fa-solid fa-pen-to-square"></i>
					        </button>
					        <button class="del-productReview btn btn-outline-dark me-2 btn-sm" data-reviewid="${productReview.review_id}">
					        	<i class="fa-solid fa-trash"></i>
					        </button>
					        <button class="btn btn-outline-dark me-2 btn-sm"><i class="fa-regular fa-thumbs-up"></i></button>
					        <button class="btn btn-outline-dark btn-sm"><i class="fa-regular fa-thumbs-down"></i></button>
					    </div>
					</div>
	            </div>
            </c:forEach>
        </div>
    </div>
</div>

<script>

	$(function() {
		
		
		//review 새창열기 - 등록
        $('#Product-Review-openWindow').on('click', function() {
        	var productId = $(".ProductId").val();
        	var width = 600;   
            var height = 700; 
            var left = Math.ceil((window.screen.width - width) / 2);
            var top = Math.ceil((window.screen.height - height) / 2);
            window.open('/app/shop_productReview/'+productId, '_blank', "width="+width+", height="+height+", left="+left+",top="+top +"scrollbars=yes");
        });
		
		//review 새창열기 - 수정
        $('.update-productReview').on('click', function() {
        	var reviewid = $(this).data("reviewid");
        	var width = 600;   
            var height = 700; 
            var left = Math.ceil((window.screen.width - width) / 2);
            var top = Math.ceil((window.screen.height - height) / 2);
            window.open('/app/shop_productReview_update/'+reviewid, '_blank', "width="+width+", height="+height+", left="+left+",top="+top +"scrollbars=yes");
        });
		
		//리뷰 삭제 버튼 
		$(".del-productReview").on("click", function() {
			var delCheck = confirm("정말 삭제하시겠습니까?");
			var reviewId = $(this).data("reviewid");
			var parent = $(this).closest('.list-group-item');
			if (delCheck) {
				$.ajax({
					type : "DELETE",
					url : "shop_productReview/"+reviewId,
					dataType : "text",
					success : function(resData, status, xhr) {
						parent.remove();
					},
					error : function(xhr, status, error) {
						alert("실패");
						console.log(error);
					}
				});
			}
		});
		
		
		
	})

</script>

