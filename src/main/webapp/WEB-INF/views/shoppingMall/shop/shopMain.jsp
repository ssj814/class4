<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="resources/css/shoppingMall/shopMain.css">

<!-- 공지사항 모달 -->
<div class="modal fade" id="noticeModal" tabindex="-1" aria-labelledby="noticeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="noticeModalLabel">새로운 공지사항이 등록되었습니다</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <strong>${sessionScope.popupNotice.title}</strong>
            </div>
            <div class="modal-footer">
                <button type="button" id="closePopup" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<!-- top -->
<div class="container text-center mt-5">
	<div class="row">
		<div class="col-3 d-flex flex-column justify-content-start">
			<p
				style="font-size: 30px; font-weight: bold; letter-spacing: 1px; background-color: #eee; border-radius: 10px">DISCOVER</p>
			<ul class="list-group list-group-flush mt-2" style="cursor: pointer;">
				<li class="list-group-item list-group-item-action fw-bolder"
					data-bs-toggle="collapse" data-bs-target="#extra-items1">ShoppingMall
				</li>
				<!-- toggle list-->
				<ul class="collapse list-group list-group-flush show" id="extra-items1"
					style="margin-left: 20px;">
					<li class="list-group-item fst-italic"><a href="shopList"
						class="text-dark" style="text-decoration: none">View All
							Products</a></li>
					<c:forEach var="category" items="${CategoryList}">
				        <c:if test="${category.product_category_id != 0}">
				            <li class="list-group-item fst-italic">
				                <a href="<c:url value='/shopList?category=${category.product_category_id}'/>" class="text-dark" style="text-decoration: none">
				                    ${category.product_category_eng_name}
				                </a>
				            </li>
				        </c:if>
				    </c:forEach>
				    <c:forEach var="category" items="${CategoryList}">
				        <c:if test="${category.product_category_id == 0}">
				            <li class="list-group-item fst-italic" style="border-bottom: 1px solid rgba(0, 0, 0, 0.125);">
				                <a href="<c:url value='/shopList?category=${category.product_category_id}'/>" class="text-dark" style="text-decoration: none">
				                    ${category.product_category_eng_name}
				                </a>
				            </li>
				        </c:if>
				    </c:forEach>
				</ul>
				<li class="list-group-item list-group-item-action fw-bolder"
					data-bs-toggle="collapse" data-bs-target="#extra-items2">For
					Trainer</li>
				<!-- toggle list-->
				<ul class="collapse list-group list-group-flush" id="extra-items2"
					style="margin-left: 20px;">
					<li class="list-group-item fst-italic"><a href="#"
						class="text-dark" style="text-decoration: none">Find a Trainer</a></li>
					<li class="list-group-item fst-italic"
						style="border-bottom: 1px solid rgba(0, 0, 0, 0.125);"><a
						href="#" class="text-dark" style="text-decoration: none">Trainer
							Tips</a></li>
				</ul>
				<li class="list-group-item list-group-item-action fw-bolder"><a
					href="#" class="text-dark" style="text-decoration: none">Meal
						Plan</a></li>
				<li class="list-group-item list-group-item-action fw-bolder"><a
					href="#" class="text-dark" style="text-decoration: none">Notice</a></li>
			</ul>
		</div>
		
		<!-- 신상품 -->
		<div class="col-9">
			<div class="row g-4 mx-5">
				<c:forEach var="product" items="${ProductList}" begin="0" end="7">
					<div class="col-6 col-md-3">
						<div class="card" style="height: 230px; border: none;">
							<a
								href="<c:url value='shopDetail?productId=${product.getProduct_id()}'/>"
								class="list-group-item-action"> <img
								src="<c:url value='/images/shoppingMall_product/${product.getProduct_imagename()}'/>" 
								class="card-img-top mt-2" alt="loading"
								style="object-fit: contain; max-height: 150px; width: 100%;">
							</a>
							<div class="card-body d-flex flex-column mx-3">
								<p class="card-title" style="font-size: 15px;">
									<a
										href="<c:url value='shopDetail?productId=${product.getProduct_id()}'/>"
										class="list-group-item-action">${fn:substring(product.getProduct_name(), 0, 8)}...</a>
								</p>
								<p class="card-text text-danger">
								    <fmt:formatNumber value="${product.getProduct_price()}" type="currency" currencySymbol="₩" />
								</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>

		
	</div>
</div>

<hr class="container p-3">

<!-- mid -->

<div class="container-fluid">
	<div class="row justify-content-center">
		<div class="col-xl-8 col-lg-10 text-center" style="min-height: 400px;">
			<h2 class="display-3 mt-5 mb-3 pt-5">Start Your Fitness Journey!</h2>
			<p class="lead text-muted mb-5 pb-5">Ignite your passion for
				fitness and conquer your goals. Every drop of sweat brings you one
				step closer to the strong, confident version of yourself. Embrace
				the grind, elevate your strength, and transform your journey into a
				powerful lifestyle. Your body is a canvas—let each workout be a
				stroke of determination, crafting the masterpiece that is you. With
				every rep and every challenge, you build resilience, fortitude, and
				an unbreakable spirit. The path to greatness starts here; let’s rise
				together and push beyond our limits!</p>
		</div>
	</div>
</div>

<hr class="container p-3">

<div class="container pt-0">

<div class="countdown">
    <div class="time">
        <span id="days">00</span> Days
    </div>
    <div class="time">
        <span id="hours">00</span> Hours
    </div>
    <div class="time">
        <span id="minutes">00</span> Minutes
    </div>
    <div class="time">
        <span id="seconds">00</span> Seconds
    </div>
</div>

	<div class="row g-4 mx-5">
		<div class="pb-2">
			<h2>Popular products</h2>
		</div>
		<c:forEach var="product" items="${ProductList}" begin="0" end="7">
			<div class="col-6 col-md-3">
				<div class="card" style="height: 300px; border: none;">
					<a
						href="<c:url value='shopDetail?productId=${product.getProduct_id()}'/>"
						class="list-group-item-action"> <img
						src="<c:url value='/images/shoppingMall_product/${product.getProduct_imagename()}'/>" 
						class="card-img-top mt-2" alt="loading"
						style="object-fit: contain; max-height: 150px; width: 100%;">
					</a>
					<div class="card-body d-flex flex-column mx-3">
						<p class="card-title fs-6">
							<a
								href="<c:url value='shopDetail?productId=${product.getProduct_id()}'/>"
								class="list-group-item-action">${product.getProduct_name()}</a>
						</p>
						<p class="card-text text-danger">
						    <fmt:formatNumber value="${product.getProduct_price()}" type="currency" currencySymbol="₩" />
						</p>
						<div class="mt-auto"></div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<hr class="container p-3">

<script>

	// toggle list
	$('.list-group-item-action').on('click', function() {
		var target = $(this).data('bs-target');
		$('.collapse').not(target).collapse('hide');
	});
	
	document.addEventListener("DOMContentLoaded", function () {
	    // 설정된 종료 시간을 설정 (일 * 시 * 분 * 초 * 밀리초)
	    // 밀리초(ms) => Date 객체가 밀리초 단위로 표현하기 때문 
	    var countdownDate = new Date().getTime() + (1 * 01 * 01 * 15 * 1000); 

	    // 1초마다 남은 시간을 계산하고 화면에 표시
	    var interval = setInterval(function () {
	        var now = new Date().getTime();
	        var distance = countdownDate - now;

	        // 남은 일, 시, 분, 초 계산
	        var days = Math.floor(distance / (1000 * 60 * 60 * 24));
	        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
	        var seconds = Math.floor((distance % (1000 * 60)) / 1000);

	        // 계산한 값을 HTML에 삽입
	        document.getElementById("days").innerText = String(days).padStart(2, '0');
	        document.getElementById("hours").innerText = String(hours).padStart(2, '0');
	        document.getElementById("minutes").innerText = String(minutes).padStart(2, '0');
	        document.getElementById("seconds").innerText = String(seconds).padStart(2, '0');

	        // 카운트다운이 끝났을 때
	        if (distance < 0) {
	            clearInterval(interval);
	         // 카운트다운 div 숨김
	            document.querySelector(".countdown").style.display = "none";
	        }
	    }, 1000);
	});
	 $(document).ready(function () {
	        const popupNotice = ${sessionScope.popupNotice != null}; // 공지사항 존재 여부 체크
	        if (popupNotice) {
	            const noticeModal = new bootstrap.Modal(document.getElementById('noticeModal'));
	            noticeModal.show();
	        }

	        $('#closePopup').on('click', function() {
	        	fetch('/app/clearPopupNotice', { 
	        		method: 'POST' 
	        		})
                .then(response => {
                    if (response.ok) {
                        console.log("세션에서 공지 팝업 데이터 삭제 완료");
                    } else {
                    	console.log("세션 삭제 실패")
                    }
                }).catch(error => console.error("세션 삭제 오류:", error));
	        });    
	  });
</script>

