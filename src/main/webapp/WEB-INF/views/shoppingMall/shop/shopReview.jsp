<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="container mt-5 mb-5">
	<input type="hidden" class="ProductId"
		value="${product.getProduct_id()}">

	<div class="d-flex justify-content-between align-items-center">
		<h3 class="align-items-center fw-bold">상품 리뷰</h3>
		<button id="Product-Review-openWindow"
			class="btn btn-link fst-italic text-dark mb-0">
			<i class="fa-solid fa-pen"></i>리뷰 등록하기
		</button>
	</div>
	
	<hr class="mt-0">
	
	<div class="container p-4">
	    <div class="text-center">
	        <h5 class="font-weight-bold" style="color: #333;">후기 총 평점</h5>
	        <span class="total-rating-star" style="font-size: 30px; color: #ffcc00;"></span>
	        <p class="mt-2" style="font-size: 18px; color: #555;">
	            <span class="total-rating" style="font-weight: bold; color: #333;"></span> / 5
	        </p>
	    </div>
	</div>
	
	<div class="card">
		<div class="list-group list-group-flush">
			<c:forEach var="productReview" items="${productReview}">
				<input type="hidden" class="review_id" value="${productReview.review_id}">
				<div class="list-group-item m-3">
					<div class="d-flex align-items-start">
						<img src="https://via.placeholder.com/50" alt="사용자1 이미지"
							class="rounded-circle me-3" style="width: 50px; height: 50px;">
						<div>
							<h6 class="mb-0 mt-1">${productReview.user_id}
								<small class="text-muted">${productReview.create_date}</small>
							</h6>
							<small class="text-muted">평점:<span class="rating-stars"
								data-rating="${productReview.rating}"></span></small>
						</div>
					</div>
					<hr>
					<div class="d-flex">
						<div>
							<c:if test="${not empty productReview.photos}">
								<c:set var="photoList"
									value="${fn:split(productReview.photos, ',')}" />
								<c:forEach var="photo" items="${photoList}">
									<img
										src="<c:url value='/images/shoppingMall_review/${photo}'/>"
										alt="사용자 사진" class="img-thumbnail me-2 mb-2"
										style="width: 100px; height: 100px; object-fit: cover;" />
								</c:forEach>
							</c:if>
							<p class="mb-3" style="white-space: pre-wrap;">${productReview.content}</p>
						</div>
						<div class="ms-auto">
							<button
								class="update-productReview btn btn-outline-dark me-2 btn-sm"
								data-reviewid="${productReview.review_id}">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
							<button
								class="del-productReview btn btn-outline-dark me-2 btn-sm"
								data-reviewid="${productReview.review_id}">
								<i class="fa-solid fa-trash"></i>
							</button>
							<button id="up-${productReview.review_id}" class="btn-feedback up btn btn-outline-dark me-2 btn-sm" data-reviewid="${productReview.review_id}">
								<i class="fa-regular fa-thumbs-up"></i>
								<span class="up-feedback-${productReview.review_id}"> ${productReview.feedback_up}</span> 
							</button>
							<button id="down-${productReview.review_id}" class="btn-feedback down btn btn-outline-dark btn-sm" data-reviewid="${productReview.review_id}">
								<i class="fa-regular fa-thumbs-down"></i>
								<span class="down-feedback-${productReview.review_id}"> ${productReview.feedback_down}</span>
							</button>
							
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<div id="tag"></div>
	<div class="btn-container text-center mt-3">
		<c:if test="${empty reviewPage || reviewPage<totalPage}">
			<button type="button" class="btn btn-dark" id="review-paging">
				<i class="fa-solid fa-chevron-down"></i>
			</button>
		</c:if>
	</div>

</div>

<script>

	$(function() {
		
		//리뷰 별점 표시
		var totalRating = 0;
		$('.rating-stars').each(function() {
           var rating = $(this).data('rating');
           totalRating += rating;

           var stars = ''; // 별을 저장할 변수
           for (var i = 0; i < rating; i++) {
               stars += '<i class="fa-solid fa-star text-warning"></i>'; // 가득 찬 별
           }
           for (var i = rating; i < 5; i++) {
               stars += '<i class="fa-regular fa-star text-warning"></i>'; // 빈 별
           }
           $(this).html(stars);
       	});
		
		//총 별점 표시
		totalRating = Math.round(totalRating/$('.rating-stars').length);
		var totalStars = '';
		for (var i = 0; i < totalRating; i++) {
			totalStars += '<i class="fa-solid fa-star text-warning"></i>'; // 가득 찬 별
        }
        for (var i = totalRating; i < 5; i++) {
        	totalStars += '<i class="fa-regular fa-star text-warning"></i>'; // 빈 별
        }
        if(totalRating){
        	$(".total-rating-star").html(totalStars);
        	$(".total-rating").text(totalRating);
        } else {
        	$(".total-rating").text(0);
        }
        
        //등록된 추천 비추천 표시
        var review_id = $(".review_id").map(function(){return $(this).val()}).get();
        if(review_id.length > 0){
	        $.ajax({
		        url: 'shop_Detail_productReviewFeedback',
		        type: 'GET',
		        data: {
		        	review_id: review_id
		        },
		        success: function(resData) {
		        	resData.forEach((data)=>{
						if(data.feedback=="up"){
							$("#up-"+data.review_id).attr('disabled', true).removeClass('btn-outline-dark').addClass('btn-dark');
						} else {
							$("#down-"+data.review_id).attr('disabled', true).removeClass('btn-outline-dark').addClass('btn-dark');
						}
		        	})
		        },
		        error: function(xhr, status, error) {
		            console.log(error);
		        }
	    	});
        }
        
        // 리뷰 페이징시 스크롤 위치 조정
        var reviewPage = parseInt(`${reviewPage}`);
        if (reviewPage > 1) {
        	window.scrollTo({
        		  top: document.body.scrollHeight,
        		  behavior: 'instant'
        		});
	    }
        
		//review 새창열기 - 등록
		$('#Product-Review-openWindow').on(
				'click',
				function() {
					var productId = $(".ProductId").val();
					var width = 600;
					var height = 700;
					var left = Math.ceil((window.screen.width - width) / 2);
					var top = Math.ceil((window.screen.height - height) / 2);
					window.open('/app/shop_productReview/' + productId,
							'_blank', "width=" + width + ", height=" + height
									+ ", left=" + left + ",top=" + top
									+ "scrollbars=yes");
				});

		//review 새창열기 - 수정
		$('.update-productReview').on(
				'click',
				function() {
					var reviewid = $(this).data("reviewid");
					var width = 600;
					var height = 700;
					var left = Math.ceil((window.screen.width - width) / 2);
					var top = Math.ceil((window.screen.height - height) / 2);
					window.open('/app/shop_productReview_update/' + reviewid,
							'_blank', "width=" + width + ", height=" + height
									+ ", left=" + left + ",top=" + top
									+ "scrollbars=yes");
				});

		//리뷰 삭제 버튼 
		$(".del-productReview").on("click", function() {
			var delCheck = confirm("정말 삭제하시겠습니까?");
			var reviewId = $(this).data("reviewid");
			var parent = $(this).closest('.list-group-item');
			if (delCheck) {
				$.ajax({
					type : "DELETE",
					url : "shop_productReview/" + reviewId,
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
		
		//추천 비추천
		$(".btn-feedback").on("click",function(){
			var feedback = $(this).hasClass('up') ? 'up' : 'down';
			var otherFeedback = $(this).hasClass('up') ? 'down' : 'up';
			var reviewId = $(this).data('reviewid');
			var thisCount = $("."+feedback+"-feedback-"+reviewId);
			var otherCount = $("."+otherFeedback+"-feedback-"+reviewId);
			
			$(this).attr('disabled', true).removeClass('btn-outline-dark').addClass('btn-dark');
			$("#"+otherFeedback+"-"+reviewId).attr('disabled', false).removeClass('btn-dark').addClass('btn-outline-dark');
			
			$.ajax({
				type : "patch",
				url : "shop_productReview_Feedback",
				data : {
					feedback : feedback,
					reviewid : reviewId
				},
				success : function(resData, status, xhr) {
					if(resData=="insert"){
						thisCount.text(parseInt(thisCount.text())+1);
					} else if(resData=="update"){
						thisCount.text(parseInt(thisCount.text())+1);
						otherCount.text(parseInt(otherCount.text())-1);
					}
				},
				error : function(xhr, status, error) {
					alert("실패");
					console.log(error);
				},
			});
		});
		
		//페이징
		$("#review-paging").on("click", function() {
		    var productId = `${product.getProduct_id()}`; 
		    var nextPage = parseInt(`${reviewPage}`) + 1; 
			location.href = 'shopDetail?productId=' + productId + '&reviewPage=' + nextPage + "#tag";	
		});
		
		

	})

</script>

