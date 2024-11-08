<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<link rel="stylesheet" href="resources/css/shoppingMall/shopMain.css">

<!-- 공지사항 모달 -->
<c:if test="${not empty sessionScope.popupNotices}">
    <div class="modal fade" id="noticeModal" tabindex="-1" aria-labelledby="noticeModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="noticeModalLabel">새로운 공지사항이 등록되었습니다</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <ul>
                        <c:forEach var="notice" items="${sessionScope.popupNotices}">
                            <li>
                                <a href="<c:url value='/notice_content?postid=${notice.postid}'/>">
                                    ${notice.title}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="modal-footer">
                    <button type="button" id="closePopup" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
</c:if>

<!-- top -->
<div id="carouselExampleFade" class="carousel slide carousel-fade">
	<div class="carousel-inner">
		<div class="carousel-item active">
			<img src="<c:url value='/images/shoppingMall_main/mainbanner_1.png'/>" class="d-block w-100" alt="..." 
			style="width: 100%; height:auto; object-fit: contain">
		</div>
		<div class="carousel-item">
			<img src="<c:url value='/images/shoppingMall_main/mainbanner_2.png'/>" class="d-block w-100" alt="..."
				style="width: 100%; height:auto; object-fit: contain">
		</div>
	</div>
	<button class="carousel-control-prev" type="button"
		data-bs-target="#carouselExampleFade" data-bs-slide="prev">
		<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="visually-hidden">Previous</span>
	</button>
	<button class="carousel-control-next" type="button"
		data-bs-target="#carouselExampleFade" data-bs-slide="next">
		<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="visually-hidden">Next</span>
	</button>
</div>

<!-- mid -->
<div class="container mt-5">
	<div class="row">
		<div class="col-3 d-flex flex-column justify-content-start">
			<p style="font-size: 30px; font-weight: bold; letter-spacing: 1px;  border-radius: 10px">Categories</p>
			<hr class="container pb-0 my-0 opacity-100 border border-dark border-1">
			<ul class="list-group list-group-flush mt-2" style="cursor: pointer;">
				<li class="list-group-item list-group-item-action fw-bolder"
					data-bs-toggle="collapse" data-bs-target="#extra-items1">
					<i class="fa-solid fa-store"></i> ShoppingMall
				</li>
				<!-- toggle list-->
				<ul class="collapse list-group list-group-flush show" id="extra-items1"
					style="margin-left: 20px;">
					<li class="list-group-item fst-italic"><a href="shopList"
						class="text-secondary" style="text-decoration: none">View All
							Products</a></li>
					<c:forEach var="category" items="${CategoryList}">
				        <c:if test="${category.product_category_id != 0}">
				            <li class="list-group-item fst-italic">
				                <a href="<c:url value='/shopList?category=${category.product_category_id}'/>" class="text-secondary" style="text-decoration: none">
				                    ${category.product_category_eng_name}
				                </a>
				            </li>
				        </c:if>
				    </c:forEach>
				    <c:forEach var="category" items="${CategoryList}">
				        <c:if test="${category.product_category_id == 0}">
				            <li class="list-group-item fst-italic" style="border-bottom: 1px solid rgba(0, 0, 0, 0.125);">
				                <a href="<c:url value='/shopList?category=${category.product_category_id}'/>" class="text-secondary" style="text-decoration: none">
				                    ${category.product_category_eng_name}
				                </a>
				            </li>
				        </c:if>
				    </c:forEach>
				</ul>
				<li class="list-group-item list-group-item-action fw-bolder text-dark"
					data-bs-toggle="collapse" data-bs-target="#extra-items2">
					<i class="fa-solid fa-person-running"></i> For Trainer
				</li>
				<!-- toggle list-->
				<ul class="collapse list-group list-group-flush" id="extra-items2"
					style="margin-left: 20px;">
					<li class="list-group-item fst-italic"><a href="#"
						class="text-secondary" style="text-decoration: none">Find a Trainer</a></li>
					<li class="list-group-item fst-italic"
						style="border-bottom: 1px solid rgba(0, 0, 0, 0.125);"><a
						href="#" class="text-secondary" style="text-decoration: none">Trainer
							Tips</a></li>
				</ul>
				<li class="list-group-item list-group-item-action fw-bolder">
					<a href="#" class="text-dark" style="text-decoration: none">
						<i class="fa-solid fa-utensils"></i> Meal Plan
					</a></li>
				<li class="list-group-item list-group-item-action fw-bolder"><a
					href="#" class="text-dark" style="text-decoration: none">
					<i class="fa-solid fa-check"></i> Notice</a></li>
			</ul>
		</div>
		
		<!-- 신상품 -->
		<div class="col-9">
			<div class="row g-4 mx-5">
				<h2 class="mb-4 mt-2">new products</h2>
				<c:forEach var="product" items="${newProduct}" begin="0" end="7">
					<div class="col-6 col-md-3">
						<div class="card" style="height: 230px; border: none;">
							<a
								href="<c:url value='shopDetail?productId=${product.getProduct_id()}'/>"
								class="list-group-item-action"> 
								<img
									src="<c:url value='/images/shoppingMall_product/${product.getProduct_imagename()}'/>" 
									class="card-img-top mt-2 position-relative" alt="loading"
									style="object-fit: contain; height: 150px; width: 100%;">
								<span class="position-absolute top-0 translate-middle badge rounded-pill bg-danger" style="left:170px">
								    NEW
								 </span>
							</a>
							<div class="card-body d-flex flex-column mx-3 ps-1">
								<p class="card-title" style="font-size: 12px;">
									<a
										href="<c:url value='shopDetail?productId=${product.getProduct_id()}'/>"
										class="newProduct-name list-group-item-action">${product.getProduct_name()}</a>
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

	<div class="row g-4 mx-5">
		<div class="pb-2">
			<h2>popular products</h2>
		</div>
		<c:forEach var="product" items="${popularProduct}" begin="0" end="7">
			<div class="col-6 col-md-3">
				<div class="card" style="height: 300px; border: none;">
					<a
						href="<c:url value='shopDetail?productId=${product.getProduct_id()}'/>"
						class="list-group-item-action"> <img
						src="<c:url value='/images/shoppingMall_product/${product.getProduct_imagename()}'/>" 
						class="card-img-top mt-2 position-relative" alt="loading"
						style="object-fit: contain; max-height: 150px; width: 100%;">
						<span class="position-absolute top-0 translate-middle badge rounded-pill bg-danger" style="left:50px">
							HIT !
						</span>
					</a>
					<div class="card-body d-flex flex-column mx-3">
						<p class="card-title fs-6">
							<a
								href="<c:url value='shopDetail?productId=${product.getProduct_id()}'/>"
								class="popoluarProduct-name list-group-item-action">${product.getProduct_name()}</a>
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
	
	function sliceLength(data,len){
		let productName = $(data).text();
		if(productName.length < len){
			return
		}
	    let sliceName = $(data).text().slice(0,len) + "...";
	    $(data).text(sliceName);
	}

	$(document).ready(function () {
		
		// 신상품명 길이 처리
		$(".newProduct-name").each(function(idx,data) {
			sliceLength(data,10);
		});
		
		// 인기상품명 길이 처리
		$(".popoluarProduct-name").each(function(idx,data) {
			sliceLength(data,13);
		});

		// 팝업
		if ($('#noticeModal').length > 0) {
	        const noticeModal = new bootstrap.Modal(document.getElementById('noticeModal'));
	        noticeModal.show();

	        $('#closePopup').on('click', function() {
	            $.get('/app/clearPopupNotice', function() {
	                console.log("세션에서 공지 팝업 데이터 삭제 완료");
	            });
	        });
	    }
	});
</script>

