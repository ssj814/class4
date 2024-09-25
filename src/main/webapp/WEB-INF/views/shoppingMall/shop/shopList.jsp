<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="resources/css/shoppingMall/shopList.css">

<div class="main-container">

	<nav class="navbar bg-body-tertiary mb-4">
		<div class="container-fluid">
		<!-- 현재 카페고리 -->
			<a class="navbar-brand fw-bold fs-2"> 
				<c:choose> 
					<c:when test="${category == 1}">
            			Athletic Gear
        			</c:when>
					<c:when test="${category == 2}">
           				Active wear
        			</c:when>
					<c:when test="${category == 3}">
            			Protein Supplements
       				 </c:when>
					<c:when test="${category == 4}">
            			Health & Fitness Foods
        			</c:when>
					<c:when test="${category == 0}">
            			Others
        			</c:when>
					<c:otherwise>
            			${not empty category ? category : 'Shop'}
       				</c:otherwise>
				</c:choose>
			</a>

			<div class="d-flex ms-auto">
				<!-- 상품 정렬 폼 -->
				<form action="<c:url value='/shopList'/>" method="get"
					id="main-OrderBy-form" class="mx-3">
					<c:if test="${not empty category}">
						<input type="hidden" name="category" value="${category}">
					</c:if>
					<c:if test="${not empty search}">
						<input type="hidden" name="search" value="${search}">
					</c:if>
					<label> <input type="radio" name="sort" value="nameAsc"
						<c:if test="${sort == 'nameAsc'}"> checked </c:if>> 이름순
					</label> <label> <input type="radio" name="sort" value="priceAsc"
						<c:if test="${sort == 'priceAsc'}"> checked </c:if>> 낮은가격순
					</label> <label> <input type="radio" name="sort" value="priceDesc"
						<c:if test="${sort == 'priceDesc'}"> checked </c:if>>
						높은가격순
					</label>
					<button type="submit">정렬</button>
				</form>
				<!-- 상품 검색 폼 -->
				<form action="<c:url value='/shopList'/>" method="get"
					id="main-Search-form" class="me-2">
					<c:if test="${not empty category}">
						<input type="hidden" name="category" value="${category}">
					</c:if>
					<input type="text" name="search" placeholder="search"
						value="${not empty search ? search : ''}">
					<button type="submit">검색</button>
				</form>

			</div>
		</div>
	</nav>

	<!-- 상품 목록 -->
	<div class="container text-center">
		<div class="row">
			<div class="col-2 d-flex flex-column justify-content-between">
				<div>
					<p
						style="font-size: 18px; font-weight: bold; letter-spacing: 1px; background-color: pink; border-radius: 10px">CATEGORY</p>
					<ul class="list-group list-group-flush mt-2 flex-grow-1"
						style="cursor: pointer;">
						<li class="list-group-item list-group-item-action"><a
							href="<c:url value='/shopList?category=1'/>">Athletic Gear</a></li>
						<li class="list-group-item list-group-item-action"><a
							href="<c:url value='/shopList?category=2'/>">Active wear</a></li>
						<li class="list-group-item list-group-item-action"><a
							href="<c:url value='/shopList?category=3'/>">Protein
								Supplements</a></li>
						<li class="list-group-item list-group-item-action"><a
							href="<c:url value='/shopList?category=4'/>">Health & Fitness
								Foods</a></li>
						<li class="list-group-item list-group-item-action"><a
							href="<c:url value='/shopList?category=0'/>">Others</a></li>
					</ul>
				</div>
				<!-- 관리자 영역-->
				<c:if test="true" >
					<button onclick="location.href='<c:url value='/product'/>'">상품등록버튼</button>
				</c:if>
			</div>

			<div class="col-10">
				<div class="main-ProductList">
					<c:forEach var="product" items="${ProductList}">
						<div class="main-Products">
							<a
								href="<c:url value='shopDetail?productId=${product.getProduct_id()}'/>">
								<img src="<c:url value='/images/shoppingMall_product/${product.getProduct_imagename()}'/>" 
								alt="Image"
								style="object-fit: contain; max-height: 150px; width: 100%;">
							</a>
							<h2>
								<a
									href="<c:url value='shopDetail?productId=${product.getProduct_id()}'/>">${product.getProduct_name()}</a>
							</h2>
							<p>₩ ${product.getProduct_price()}</p>
							<!-- 관리자 영역-->
							<c:if test="true">
								<button
									onclick="location.href='productUpdate?productId=${product.getProduct_id()}'">수정하기</button>
								<button class="del-product" data-id="${product.getProduct_id()}">삭제</button>
							</c:if>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>

	<!-- 페이징 -->
	<div class="main-paging">
		<c:url var="url" value="/shopList?" />
		<c:if test="${not empty category}">
			<c:set var="url" value="${url}category=${category}&" />
		</c:if>
		<c:if test="${not empty search}">
			<c:set var="url" value="${url}search=${search}&" />
		</c:if>
		<c:if test="${not empty sort}">
			<c:set var="url" value="${url}sort=${sort}&" />
		</c:if>
		<c:forEach var="page" begin="1" end="${totalPage}">
			<button onclick="location.href='${url}page=${page}'">${page}</button>
		</c:forEach>
	</div>

</div>

<script type="text/javascript">
	// 상품 삭제 버튼 
	$(".del-product").on("click", function() {
		var delCheck = confirm("정말 삭제하시겠습니까?");
		var dataId = $(this).data("id");
		var parent = $(this).parent();
		if (delCheck) {
			$.ajax({
				type : "DELETE",
				url : "product/productId/"+dataId,
				dataType : "json",
				success : function(resData, status, xhr) {
					alert(resData.mesg);
					parent.remove();
				},
				error : function(xhr, status, error) {
					alert("실패");
					console.log(error);
				}
			});
		}
	});
</script>