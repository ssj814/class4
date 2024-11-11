<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="resources/css/shoppingMall/productUpdate.css">

<div class="container update-container">
<h1>상품 수정</h1>
    <form action="productUpdate" method="post" enctype="multipart/form-data">
        <input type="hidden" name="product_id" value="${product.getProduct_id()}"/>
        <input type="hidden" name="page" value="${currentPage}"/>
        <label for="category_id">카테고리</label>
        <select id="product_category_id" name="product_category_id" required>
		    <!-- "기타" 카테고리를 제외한 카테고리 출력 -->
		    <c:forEach var="category" items="${CategoryList}">
		        <c:if test="${category.product_category_id != 0}">
		            <option value="${category.product_category_id}" <c:if test="${product.getProduct_category_id() == category.product_category_id}"> selected </c:if>>
		                ${category.product_category_name}
		            </option>
		        </c:if>
		    </c:forEach>
		    <!-- "기타" 카테고리를 마지막에 출력 -->
		    <c:forEach var="category" items="${CategoryList}">
		        <c:if test="${category.product_category_id == 0}">
		            <option value="${category.product_category_id}" <c:if test="${product.getProduct_category_id() == 0}"> selected </c:if>>
		                ${category.product_category_name}
		            </option>
		        </c:if>
		    </c:forEach>
		</select>

        <label for="product_name">상품명</label>
        <input type="text" id="product_name" name="product_name" value="${product.getProduct_name()}" required/><br/>
        
        <div id="option-container">
		    <!-- 기존 옵션 출력 -->
		    <c:forEach var="option" items="${options}" varStatus="status">
		        <div class="option-container">
		            <label>옵션 타입 ${status.index + 1}</label>
		            <input type="text" name="option_type" class="option-type" value="${option.option_type}" placeholder="예: Size" />
		            <label>옵션 이름 ${status.index + 1}</label>
		            <input type="text" name="option_name" class="option-name" value="${option.option_name}" placeholder="예: S, M, L" />
		        </div>
		    </c:forEach>
		
		    <!-- 남은 옵션 필드 출력 (항상 3개의 입력 필드가 보이도록) -->
		    <c:forEach begin="${options.size() + 1}" end="3" var="index">
		        <div class="option-container">
		            <label>옵션 타입 ${index}</label>
		            <input type="text" name="option_type" class="option-type" placeholder="예: Size" />
		            <label>옵션 이름 ${index}</label>
		            <input type="text" name="option_name" class="option-name" placeholder="예: S, M, L" />
		        </div>
		    </c:forEach>
		</div>
		
        <label for="product_price">가격</label>
        <input type="text" id="product_price" name="product_price" value="${product.getProduct_price()}" required/><br/>
        
        <label for="product_image">상품 이미지</label>
        <input type="file" id="product_image" name="product_image" accept="image/*" onchange="showPreview(this, 'preview1')"/>
        <img id="preview1" class="image-preview" style="display: block;" src="<c:url value='/images/shoppingMall_product/${product.getProduct_imagename()}'/>"/>
        
        <label for="product_inventory">재고 수량</label>
        <input type="text" id="product_inventory" name="product_inventory" value="${product.getProduct_inventory()}" required/><br/>
        
        <label for="product_description">상세 정보</label>
        <textarea id="product_description" name="product_description" required>${product.getProduct_description()}</textarea><br/>
        
        <div class="button-container">
            <input type="submit" value="수정"/>
            <input type="reset" onclick="location.href='productUpdate?productId=${product.getProduct_id()}'" value="취소" />
            <input type="button" onclick="location.href='<c:url value="/shopList?page=${currentPage}" />'" value="목록"/>
        </div>
    </form>
 </div>

<script>

	//이미지 미리보기
	function showPreview(input, previewId) {
	    const file = input.files[0];
	    if (file) {
	    	//이미지 사이즈 제한
	    	const maxSize = 2 * 1024 * 1024;
	    	if (file.size > maxSize) {
	            alert('파일 크기는 2MB를 초과할 수 없습니다.');
	            input.value = '';
	            return;
	        }
	    	//이미지 미리보기
	        const reader = new FileReader();
	        reader.onload = function (e) {
	            const preview = document.getElementById(previewId);
	            preview.src = e.target.result;
	            preview.style.display = 'block';
	        }
	        reader.readAsDataURL(file);
	    }
	}

</script>