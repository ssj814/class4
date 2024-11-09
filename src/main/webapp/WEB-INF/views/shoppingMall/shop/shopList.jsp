<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="resources/css/shoppingMall/shopList.css">

<div class="main-container">

	<!-- Modal -->
	<div class="modal fade" id="messageModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div id="mesg" class="modal-body"></div>
				<div class="modal-footer border-top-0">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<nav class="navbar bg-body-tertiary mb-4">
		<div class="container-fluid">
		<!-- 현재 카테고리 -->
			<div class="navbar-brand fw-bold fs-2"> 
				<c:choose>
					<c:when test="${not empty category}">
						<c:forEach var="cat" items="${CategoryList}">
							<c:if test="${cat.product_category_id == category}">
								${cat.product_category_eng_name}
							</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>
						Shop
					</c:otherwise>
				</c:choose>
			</div>

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
					<button type="submit">
						<!-- 검색 -->
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</form>

			</div>
		</div>
	</nav>

	<!-- 상품 목록 -->
	<div class="container text-center">
		<div class="row">
			<div class="col-2 d-flex flex-column justify-content-between">
				<div>
					<p style="font-size: 18px; font-weight: bold; letter-spacing: 1px; background-color: pink; border-radius: 10px">CATEGORY</p>
					<ul class="list-group list-group-flush mt-2 flex-grow-1" style="cursor: pointer;">
						<li class="list-group-item list-group-item-action">
							<a href="shopList">View All Products</a>
						</li>
					    <c:forEach var="category" items="${CategoryList}">
					        <c:if test="${category.product_category_id != 0}">
					            <li class="list-group-item list-group-item-action">
					                <a href="<c:url value='/shopList?category=${category.product_category_id}'/>">
					                    ${category.product_category_eng_name}
					                </a>
					            </li>
					        </c:if>
					    </c:forEach>
					    <c:forEach var="category" items="${CategoryList}">
					        <c:if test="${category.product_category_id == 0}">
					            <li class="list-group-item list-group-item-action">
					                <a href="<c:url value='/shopList?category=${category.product_category_id}'/>">
					                    ${category.product_category_eng_name}
					                </a>
					            </li>
					        </c:if>
					    </c:forEach>
					</ul>
				</div>
				<!-- 관리자 영역-->
				<c:if test="${fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN')}">
					<button class="btn btn-dark" onclick="location.href='<c:url value='/product'/>'">상품등록버튼</button>
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
								<a class="product-name"
									href="<c:url value='shopDetail?productId=${product.getProduct_id()}'/>">${product.getProduct_name()}</a>
							</h2>
							<p><fmt:formatNumber value="${product.getProduct_price()}" type="currency" currencySymbol="₩" /></p>
							<!-- 관리자 영역-->
							<c:if test="${fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN')}">
								<button
									onclick="location.href='<c:url value="/productUpdate?productId=${product.getProduct_id()}&page=${currentPage}" />'">수정하기</button>
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
	
	$(function() {
		
		//상품명 길이 처리
		$(".product-name").each(function(idx,data) {
			sliceLength(data,10);
		});
		
		// 모달창
        var message = '${mesg}';
        if (message) {
            $("#mesg").html(message);
            var messageModal = new bootstrap.Modal($('#messageModal')[0]);
            messageModal.show();
        }

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

	})
	
	function sliceLength(data,len){
		let productName = $(data).text();
		if(productName.length < len){
			return
		}
	    let sliceName = $(data).text().slice(0,len) + "...";
	    $(data).text(sliceName);
	}
</script>