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
	document.getElementById('scrollTopBtn').addEventListener('click',
			function() {
				window.scrollTo({
					top : 0,
					behavior : 'smooth'
				});
			});

	document.getElementById('scrollBottomBtn').addEventListener('click',
			function() {
				window.scrollTo({
					top : document.body.scrollHeight,
					behavior : 'smooth'
				});
			});
</script>