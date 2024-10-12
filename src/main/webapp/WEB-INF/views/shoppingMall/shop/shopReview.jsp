<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!-- 상품 리뷰사진용 모달 -->
<div class="modal fade" id="imageModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body p-0 d-flex justify-content-center align-items-center">
        <div id="carouselImages" class="carousel slide">
		    <div class="carousel-inner">
		        <!-- 이미지 항목들 -->
		    </div>
		    <button class="carousel-control-prev" type="button" data-bs-target="#carouselImages" data-bs-slide="prev">
		        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		        <span class="visually-hidden">이전</span>
		    </button>
		    <button class="carousel-control-next" type="button" data-bs-target="#carouselImages" data-bs-slide="next">
		        <span class="carousel-control-next-icon" aria-hidden="true"></span>
		        <span class="visually-hidden">다음</span>
		    </button>
		</div>
      </div>
    </div>
  </div>
</div>

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
	
	<div>
	    <c:if test="${not empty productReview}">
	        <div class="d-flex fst-italic">
	            <button class="btn btn-link text-decoration-none text-dark mb-0 btn-up" data-sort="newest">최신순</button>
	            <button class="btn btn-link text-decoration-none text-dark mb-0 btn-up" data-sort="oldest">오래된순</button>
	            <button class="btn btn-link text-decoration-none text-dark mb-0 btn-up" data-sort="useful">유용한순</button>
	            <button class="btn btn-link text-decoration-none text-dark mb-0 btn-up" data-sort="rating">평점순</button>
	            <button class="btn btn-link text-decoration-none text-dark mb-0 btn-up" data-sort="onlyPhoto">
	            	<i class="fa-regular fa-image"></i> 포토리뷰
	           	</button>
	        </div>
	    </c:if>
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
						<div class="review-content" data-photos="${productReview.photos}">
							<c:if test="${not empty productReview.photos}">
								<c:set var="photoList" value="${fn:split(productReview.photos, ',')}" />
								<c:forEach var="photo" items="${photoList}">
									<img
										src="<c:url value='/images/shoppingMall_review/${photo}'/>"
										alt="사용자 사진" class="img-thumbnail me-2 mb-2 review-img"
										style="width: 100px; height: 100px; object-fit: cover;" />
								</c:forEach>
							</c:if>
							<p class="mb-3" style="white-space: pre-wrap;">${productReview.content}</p>
						</div>
						<!-- 버튼 부분 -->
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
		totalRating = `${averageRating}`;
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
		        url: 'shop_Detail_productReview_Feedback',
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
        
        //정렬 기준 bold 처리
        if (`${sortType}`) {
	        $(".btn-up").each(function() {
	            if ($(this).data('sort') === `${sortType}`) {
	                $(this).addClass("fw-bold");
	            }
	        });
	    }
        
 
        // 이미지 모달창 
        $('.review-img').on('click', function() { // review-img 클래스 클릭 시
            const reviewPhotos = $(this).closest('.review-content').data('photos');
            console.log(reviewPhotos);
            if (reviewPhotos) {
                const carouselInner = $('#carouselImages .carousel-inner');
                carouselInner.empty(); // 기존 이미지 제거

                // 사진 URL을 배열로 변환
                const photosArray = reviewPhotos.split(','); 
                photosArray.forEach((photo, index) => {
                    const isActive = index === 0 ? 'active' : ''; // 첫 번째 이미지를 활성화
                    const photoUrl = '<c:url value="/images/shoppingMall_review/' + photo + '"/>'; // URL 처리
                    const carouselItem = 
                        '<div class="carousel-item ' + isActive + '">' +
                            '<img src="' + photoUrl + '" class="d-block fixed-size" alt="이미지" style="width: 500px; height: 500px; object-fit: cover;">' +
                        '</div>';
                    carouselInner.append(carouselItem);
                });

                $('#imageModal').modal('show'); // 모달 열기
            } else {
                console.error('리뷰 이미지가 존재하지 않습니다.');
            }
		});
     
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
		
		//리뷰 페이징 버튼
		$("#review-paging").on("click", function() {
		    var productId = `${product.getProduct_id()}`; 
		    var nextPage = parseInt(`${reviewPage}`) + 1;
		    var sortType = $(".btn-up.fw-bold").data('sort') || '';
		    rememberScrollPosition();
			location.href = 'shopDetail?productId=' + productId + '&reviewPage=' + nextPage + '&sortType=' + sortType;
		});
		
	
		//리뷰 정렬 버튼
 		$(".btn-up").on("click",function(){
 			rememberScrollPosition();
	        var productId = `${product.getProduct_id()}`; 
	        var sortType = $(this).data('sort');
	        location.href = 'shopDetail?productId=' + productId + '&sortType=' + sortType;
		});
		
		
		//이전 스크롤 위치로 이동
		const savedScrollPosition = localStorage.getItem('scrollPosition');
		if (savedScrollPosition) {
		    window.scrollTo({
		        top: savedScrollPosition,
		        behavior: 'instant'
		    });
		    localStorage.removeItem('scrollPosition'); // 저장된 위치 삭제
		}
		
		//현재 스크롤 위치 기억 함수
		function rememberScrollPosition() {
			const scrollPosition = window.scrollY;
 			localStorage.setItem('scrollPosition', scrollPosition);
		}
	

	})

</script>