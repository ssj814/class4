<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="resources/css/shoppingMall/QuickMenu.css" rel="stylesheet">

<div class="quick-menu">
	<button id="scrollTopBtn">▲</button>

	<div class="recent-products">
		<c:forEach var="product" items="${recentProducts}" varStatus="status">
			<c:if test="${status.index < 4}">
				<div class="recent-product">
					<a href="<c:url value='shopDetail?productId=${product.productId}'/>"> 
					<img src="<c:url value='/images/shoppingMall_product/${product.productImage}'/>"
						alt="${product.productId}">
					</a>
				</div>
			</c:if>
		</c:forEach>
	</div>

	<button id="scrollBottomBtn">▼</button>
</div>

<script>
	// 페이지 로드 시 초기 설정
	window.onload = function() {
	    var quickMenu = document.querySelector('.quick-menu');
	    var initialTop = window.innerHeight * 0.2;  // 초기 위치 (상단으로부터 20%)
	    var maxOffset = window.innerHeight * 0.3;   // 최대 상단으로부터 50% 위치까지 이동 (0.5 - 0.2)

	    // 메뉴의 초기 위치 설정
	    quickMenu.style.top = initialTop + 'px';

	    window.addEventListener('scroll', function() {
	        var scrollY = window.scrollY || document.documentElement.scrollTop;  // 현재 스크롤 위치
	        var newTop = scrollY * 0.3;  // 스크롤 비율에 따라 이동
	        
	        // 상단에서 최대 50%까지 이동 제한
	        if (newTop > maxOffset) {
	            newTop = maxOffset;  // 하단 50% 제한
	        }

	        // 메뉴의 Y 위치 조정
	        quickMenu.style.top = (initialTop + newTop) + 'px';
	    });
	};

	// 상단으로 스크롤
	document.getElementById('scrollTopBtn').addEventListener('click', function() {
	    window.scrollTo({
	        top: 0,
	        behavior: 'smooth'
	    });
	});

	// 하단으로 스크롤
	document.getElementById('scrollBottomBtn').addEventListener('click', function() {
	    window.scrollTo({
	        top: document.body.scrollHeight,
	        behavior: 'smooth'
	    });
	});
</script>