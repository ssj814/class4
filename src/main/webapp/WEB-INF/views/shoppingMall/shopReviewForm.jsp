<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet" href="../resources/css/shoppingMall/shopReviewForm.css">

<div class="container">
	<form action="/app/shop_productReview" method="post" enctype="multipart/form-data">
        
		<input type="hidden" name="product_id" value="${productDTO.product_id}">
		<hr class="mt-4">
		<div class="container">
			<h3>상품 리뷰</h3>
			이 상품에 대해서 얼마나 만족하시나요?
		</div>
		<hr>
		<div class="container row">
		    <div class="col-auto">
		        <img src="<c:url value='/images/shoppingMall_product/${productDTO.product_imagename}'/>"  
		        	alt="Product Image" style="object-fit: contain; max-height: 150px; max-width: 150px;">
		    </div>
		    <div class="col">
		    	<div class="mt-3">
		    		${productDTO.product_name}
		    	</div>
		    	<div class="mt-1"> 
		    		<div id="star-rating">
			            <span class="star checked" data-value="1">&#9733;</span>
			            <span class="star" data-value="2">&#9733;</span>
			            <span class="star" data-value="3">&#9733;</span>
			            <span class="star" data-value="4">&#9733;</span>
			            <span class="star" data-value="5">&#9733;</span>
			        </div>
			        <p><span class="selected-rating">1</span> 점</p>
			        <input type="hidden" name="rating" class="selected-rating" value=""> 
		    	</div>	        
		    </div>
		</div>
		<hr>
		<div class="mb-3">
		  <label for="exampleFormControlTextarea1" class="form-label">상세 리뷰</label>
		  <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="8" required ></textarea>
		</div>
		<hr>
		<div class="mb-3">
		  <label for="formFileMultiple" class="form-label">리뷰 사진 (최대 5장)</label>
		  <input name="multipartFilePhotos" class="form-control" type="file" id="formFileMultiple" accept="image/*" multiple>
		  <div class="row mt-3" id="image-preview"></div>	  
		</div>
		<hr>
		<button type="button" class="btn btn-dark" onClick="window.close()">취소하기</button>
		<button type="submit" class="btn btn-dark" id="insert-productReview">리뷰 등록하기</button>
	</form>
</div>

<script>

	$(function(){
		
		//자식창 닫기
		var closeWindow = '${closeWindow}';
		if(closeWindow){
			alert('${mesg}');
			window.close();
		}
		
		//별점 계산
		$('.star').on('click', function() {
            const rating = $(this).data('value');
            $('.star').removeClass('checked'); //별점 반영
            for (let i = 0; i < rating; i++) {
                $('.star').eq(i).addClass('checked');
            }
            $('.selected-rating').text(rating);
            $('.selected-rating[name="rating"]').val(rating); 
        });
		
		//이미지 미리보기
		$('#formFileMultiple').on('change', function(event) {
            const files = event.target.files;
            if (files.length > 5) { //이미지 5개 제한
                alert('최대 5개의 이미지만 선택할 수 있습니다.');
                $(this).val(''); 
                $('#image-preview').empty();
                return;
            }

            const previewContainer = $('#image-preview');
            previewContainer.empty(); // 이전 미리보기 초기화

            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                const reader = new FileReader();
                reader.onload = function(e) {
                    const col = $('<div>').addClass('col-2 mb-1');
                    const card = $('<div>').addClass('card');
                    const img = $('<img>')
                    				.addClass('card-img-top')
                    				.attr('src', e.target.result)
                    				.css({ 'max-width': '100%', 'height': 'auto' });
                    card.append(img);
                    col.append(card);
                    previewContainer.append(col);
                };
                reader.readAsDataURL(file);
            }
        });
		
	})

</script>
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"></script>