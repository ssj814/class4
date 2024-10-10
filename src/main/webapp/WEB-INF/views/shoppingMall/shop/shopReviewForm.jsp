<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="container">
	<form action="/app/shop_productReview" method="post"
		enctype="multipart/form-data">

		<input type="hidden" name="product_id" value="${productDTO.product_id}">
		<c:if test="${not empty productReviewDTO.review_id}">
			<!-- 수정하기 버튼을 눌렀을 경우 -->
			<input type="hidden" name="review_id" value="${productReviewDTO.review_id}">
		</c:if>
		<hr class="mt-4">
		<div class="container">
			<h3>상품 리뷰</h3>
			이 상품에 대해서 얼마나 만족하시나요?
		</div>
		<hr>
		<div class="container row">
			<div class="col-auto">
				<img src="<c:url value='/images/shoppingMall_product/${productDTO.product_imagename}'/>" alt="Product Image"
					style="object-fit: contain; max-height: 150px; max-width: 150px;">
			</div>
			<div class="col">
				<div class="mt-3">${productDTO.product_name}</div>
				<div class="mt-1">
					<div id="star-rating">
						<span class="star checked" data-value="1">&#9733;</span> 
						<span class="star checked" data-value="2">&#9733;</span> 
						<span class="star checked" data-value="3">&#9733;</span> 
						<span class="star" data-value="4">&#9733;</span>
						<span class="star" data-value="5">&#9733;</span>
					</div>
					<p class="mt-1">( <span class="selected-rating">3</span>점 )</p>
					<input type="hidden" name="rating" class="selected-rating" value="1">
				</div>
			</div>
		</div>
		<hr>
		<div class="mb-3">
			<label for="exampleFormControlTextarea1" class="form-label">상세 리뷰</label>
			<textarea name="content" class="form-control"
				id="exampleFormControlTextarea1" rows="8" required>${productReviewDTO.content}</textarea>
		</div>
		<hr>
		<div class="mb-2">
			<label for="formFileMultiple" class="form-label">리뷰 사진 (최대5장)</label> 
			<input name="multipartFilePhotos" class="form-control" type="file" id="formFileMultiple" accept="image/*" multiple>
			<div class="row mt-3" id="image-preview"></div>
		</div>
		<hr>
		<button type="button" class="btn btn-dark" onClick="window.close()">취소하기</button>
		<c:choose>
			<c:when test="${not empty productReviewDTO}">
				<button type="submit" class="btn btn-dark" id="update-productReview"
					data-reviewid="${productReviewDTO.review_id}">리뷰 수정하기</button>
			</c:when>
			<c:otherwise>
				<button type="submit" class="btn btn-dark" id="insert-productReview">리뷰등록하기</button>
			</c:otherwise>
		</c:choose>
	</form>
</div>

<script>

	$(function() {

		//자식창 닫기
		var closeWindow = '${closeWindow}';
		if (closeWindow) {
			alert('${mesg}');
			window.opener.location.reload();
			window.close();
		}
		
		//별점 표시
		var rating = '${productReviewDTO.rating}';
		if(rating){
			$('.star').removeClass('checked');
			for (let i = 0; i < rating; i++) {
				$('.star').eq(i).addClass('checked');
			}
			$('.selected-rating').text(rating);
			$('.selected-rating[name="rating"]').val(rating);
		}
		
		
		//수정 버튼
		$('#update-productReview').on('click', function(e) {
			e.preventDefault();
			var reviewId = $(this).data('reviewid');
			$('form').attr('action','/app/shop_productReview_update/'+reviewId);
			$('form').submit(); 
		});

		//별점 클릭시
		$('.star').on('click', function() {
			var rating = $(this).data('value');
			$('.star').removeClass('checked'); //별점 반영
			for (let i = 0; i < rating; i++) {
				$('.star').eq(i).addClass('checked');
			}
			$('.selected-rating').text(rating);
			$('.selected-rating[name="rating"]').val(rating);
		});

		//이미지 미리보기
		$('#formFileMultiple').on('change',function(event) {
			const files = event.target.files;
			const maxFileSize = 2 * 1024 * 1024; // 2MB
			if (files.length > 5) { //이미지 5개 제한
				alert('최대 5개의 이미지만 선택할 수 있습니다.');
				$(this).val('');
				$('#image-preview').empty();
				return;
			}
			for (let i = 0; i < files.length; i++) {
		        if (files[i].size > maxFileSize) {
		            alert("이미지 크기가 2MB를 초과합니다.");
		            $(this).val('');
		        }
		    }
			const previewContainer = $('#image-preview');
			previewContainer.empty(); // 이전 미리보기 초기화
			for (let i = 0; i < files.length; i++) {
				const file = files[i];
				const reader = new FileReader();
				reader.onload = function(e) {
					const col = $('<div>').addClass('col-2 mb-1');
					const card = $('<div>').addClass('card');
					const img = $('<img>').addClass('card-img-top')
							.attr('src', e.target.result).css({
								'max-width' : '100%',
								'height' : 'auto'
							});
					card.append(img);
					col.append(card);
					previewContainer.append(col);
				};
				reader.readAsDataURL(file);
			}
		});

	})
	
</script>