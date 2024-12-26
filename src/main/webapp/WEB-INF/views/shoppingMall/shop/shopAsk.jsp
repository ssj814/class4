<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="container mt-5 mb-5">
	
	<input type="hidden" class="ProductId"
		value="${product.getProduct_id()}">

	<div class="d-flex justify-content-between align-items-center">
		<h3 class="align-items-center fw-bold">상품문의</h3>
		<c:if test="${!empty sessionScope.SPRING_SECURITY_CONTEXT.authentication }"> 
			<!-- 새창띄울 거면 이걸로. -->
			<button id="product-ask-openWindow"
				class="btn btn-link fst-italic text-dark mb-0">
				<i class="fa-solid fa-pen"></i>문의하기
			</button>
		</c:if>
	</div>
	
	<hr class="mt-0">
	
	<div class="container p-4">
	    <div class="">
	    	<ul>
	    		<li>상품문의 및 후기게시판을 통해 취소나 환불, 반품 등은 처리되지 않습니다.</li>
	    		<li>가격, 판매자, 교환/환불 및 배송 등 해당 상품 자체와 관련 없는 문의는 고객센터 내 Q&A 문의하기를 이용해주세요.</li>
	    		<li>"해당 상품 자체"와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출 제한, 삭제 등의 조치가 취해질 수 있습니다.</li>
	    		<li>공개 게시판으로 전화번호, 메일 주소 등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.</li>
	    	</ul>
	    </div>
	</div>

	<!-- 상품 리뷰 리스트 -->
	<div class="card">
		<div class="list-group list-group-flush">
			${ask}
		</div>
	</div>
	
	<!-- 문의 페이징 -->
	<!-- (질문+답변 세트로)5개 보여주고, 전체보기 -->
	<div class="askBtn-container text-center mt-3">
		<button type="button" class="btn btn-dark">
			<i class="fa-solid fa-chevron-down"></i>
			<span> 전체보기</span>
		</button>
	</div>
	
	<!-- 상품 신고 -->
	<div class="report-container">
		<h5>상품 신고</h5>
		<div class="d-flex justify-content-between">
			<span>부적절한 상품이나 지적재산권을 침해하는 상품의 경우 신고하여 주시기 바랍니다.</span>
			<button class="btn text-dark m-0 p-0 opacity-50 text-decoration-underline">신고하기</button>
		</div>
	</div>

</div>

<script>

	$(function() {
		
		// 로그인 유저 정보
		const loginUser = `${sessionScope.SPRING_SECURITY_CONTEXT.authentication.name }`;
		const isAdmin =  ${fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN')};
		
		//화면 최초 랜더링시 리뷰조회
		var nowReviewPage = 0;
		reviewPaging();
		
		//이벤트 핸들러
		$('#review-paging').on('click', reviewPaging); //페이징버튼
		$(document).on('click', '.review-more', reviewMore); //리뷰더보기버튼
		
		//리뷰 - 더보기 버튼
		function reviewMore(){		
			var reviewContainer = $(this).closest('.review-content');
		    
		    var buttonText = $(this).text() === '더보기...' ? '간략히 보기' : '더보기...';
		    reviewContainer.find('.review-more').text(buttonText);  // 버튼 텍스트 변경
		    
		    reviewContainer.find('.full-review').toggle();  // 전체 텍스트 보여줌
		    reviewContainer.find('.slice-review').toggle();  // 자른 텍스트 숨김
		}
		
		//리뷰 - 등록
		$('#product-ask-openWindow').on('click',function() {
			console.log("새창열기");
			var productId = $(".ProductId").val();
			var width = 600;
			var height = 700;
			var left = Math.ceil((window.screen.width - width) / 2);
			var top = Math.ceil((window.screen.height - height) / 2);
			window.open('/app/user/shop_productAsk/' + productId,
					'_blank', "width=" + width + ", height=" + height
							+ ", left=" + left + ",top=" + top
							+ "scrollbars=yes");
		});
	
		
		//리뷰 - 페이징
		function reviewPaging() {
			// 기존 리뷰 지우기
			$(".review-container").empty();

			var productId = `${product.getProduct_id()}`; 
		    var nextPage = nowReviewPage + 1;
		    var sortType = $(".btn-up.fw-bold").data('sort') || '';
			$.ajax({
		        url: 'shop_productReview_paging',
		        type: 'GET',
		        data: {
		        	productId: productId,
		        	sortType: sortType,
		        	reviewPage: nextPage
		        },
		        dataType: 'json',
		        success: function(resData) {
					resData.forEach(review => {
						$(".review-container").append(generateReviewHTML(review));
				    });
					
					reviewListStar() //리뷰 별점 표시
					feedbackUpDown() //리뷰피드백 표시
					nowReviewPage++; //리뷰페이징 번호+1
					
					//마지막 페이지면 페이징 버튼 숨기기
					if(nowReviewPage>=`${totalPage}` || resData.length<5){
						$(".askBtn-container").hide();
					} 
					
		        },
		        error: function(xhr, status, error) {
		            console.log(error);
		        }
			});
		}
		

		
	
		//리뷰 HTML 생성 함수
		function generateReviewHTML(productReview) {
			
			// 이미지 태그 미리 생성
		    let photosHTML = '';
		    if (productReview.photos && productReview.photos.length > 0) {
		        const photoList = productReview.photos.split(',');
		        for (let photo of photoList) {
		            const photoURL = "images/shoppingMall_review/" + photo;
		            photosHTML += "<img src='" + photoURL +
		            			"' alt='사용자 사진' class='img-thumbnail me-2 mb-2 review-img' style='width: 100px; height: 100px; object-fit: cover;' />";
		        }
		    }
		    
		    // 작성 유저에게만 수정, 삭제 버튼 노출 + admin
		    let delUpdateHTML = '';	    
		    if (productReview.user_id == loginUser || isAdmin){		    	
		    	delUpdateHTML += '<button class="update-productReview btn btn-outline-dark me-2 btn-sm" data-reviewid="' + productReview.review_id + '">' +
						        '<i class="fa-solid fa-pen-to-square"></i>' +
						        '</button>' +
						        '<button class="del-productReview btn btn-outline-dark me-2 btn-sm" data-reviewid="' + productReview.review_id + '">' +
						        '<i class="fa-solid fa-trash"></i>' +
						        '</button>'
		    }
		    
		    // 리뷰내용이 길면 더보기 버튼 추가
		    let reviewMoreBtn = '';
		    if (productReview.content.length > 100) {
		    	showReview = productReview.content.slice(0, 100);
		    	reviewMoreBtn += '<span class="review-more">더보기...</span>';
		    } else {
		    	showReview = productReview.content;
		    }
		    
			// 리뷰 HTML
		    let reviewHTML = 
		        '<input type="hidden" class="review_id" value="' + productReview.review_id + '">' +
		        '<div class="list-group-item m-3">' +
		        '<div class="d-flex align-items-start">' +
		        '<img src="https://via.placeholder.com/50" alt="사용자1 이미지" class="rounded-circle me-3" style="width: 50px; height: 50px;">' +
		        '<div>' +
		        '<h6 class="mb-0 mt-1">' + productReview.user_id + 
		        '<small class="text-muted"> ' + productReview.create_date + '</small>' +
		        /* 리뷰 신고 버튼 */
		        '<small class="text-muted"> | <button class="btn text-dark m-0 p-0 opacity-50" style="font-size:12px;">신고</button></small>' +
		        '</h6>' +
		        '<small class="text-muted">평점:<span class="rating-stars" data-rating="' + productReview.rating + '"></span></small>' +
		        '</div>' +
		        '</div>' +
		        '<hr>' +
		        '<div class="row">' + 
		        '<div class="review-content col-10" data-photos="' + productReview.photos + '">' + photosHTML +
		        '<p class="slice-review mb-3" style="white-space: pre-wrap;">' + showReview + reviewMoreBtn + '</p>' +
		        '<p class="full-review" style="display: none; white-space: pre-wrap;">' + productReview.content + reviewMoreBtn + '</p>'+
		        '</div>' +
		        '<div class="ms-auto col-2 text-end">' + 
		        delUpdateHTML + 
		        '<button id="up-' + productReview.review_id + '" class="btn-feedback up btn btn-outline-dark me-2 btn-sm" data-reviewid="' + productReview.review_id + '">' +
		        '<i class="fa-regular fa-thumbs-up"></i>' +
		        '<span class="up-feedback-' + productReview.review_id + '">' + productReview.feedback_up + '</span>' +
		        '</button>' +
		        '<button id="down-' + productReview.review_id + '" class="btn-feedback down btn btn-outline-dark btn-sm" data-reviewid="' + productReview.review_id + '">' +
		        '<i class="fa-regular fa-thumbs-down"></i>' +
		        '<span class="down-feedback-' + productReview.review_id + '">' + productReview.feedback_down + '</span>' +
		        '</button>' +
		        '</div>' +
		        '</div>' +
		        '</div>';
			return reviewHTML;
		}

	})

</script>