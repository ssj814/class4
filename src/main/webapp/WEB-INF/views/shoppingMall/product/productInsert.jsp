<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="resources/css/shoppingMall/productInsert.css">

<div class="container insert-container">
    <h1>상품 등록</h1>
    <form action="<c:url value='/product'/>" method="post" enctype="multipart/form-data">
        <label for="product_category_id">카테고리</label>
	    <select id="product_category_id" name="product_category_id">
		    <option value="0" disabled selected>선택하세요</option>
		    <c:forEach var="category" items="${CategoryList}">
		    	<c:if test="${category.product_category_id != 0}">
			        <option value="${category.product_category_id}">
			            ${category.product_category_name}
			        </option>
		        </c:if>
		    </c:forEach>
		    <c:forEach var="category" items="${CategoryList}">
		    	<c:if test="${category.product_category_id == 0}">
			        <option value="${category.product_category_id}">
			            ${category.product_category_name}
			        </option>
		        </c:if>
		    </c:forEach>
		</select>
	        
        
        <label for="product_isactive">판매상태</label>
        <input type="radio" name="product_isactive" value="1" checked="checked"/>판매중
        <input type="radio" name="product_isactive" value="0"/>품절
        
        <label for="product_id">상품코드</label>
        <input type="text" id="product_id" name="product_id" placeholder="${ProductId}" value="${ProductId}" readonly />
        
        <label for="product_name">상품명</label>
        <input type="text" id="product_name" name="product_name" placeholder="상품명을 입력하세요." required />

		<div id="option-container">
		    <div class="option-container">
		        <label>옵션 타입 1</label>
		        <input type="text" name="option_type" class="option-type" placeholder="예: Size" />
		        <label>옵션 이름 1</label>
		        <input type="text" name="option_name" class="option-name" placeholder="예: S, M, L" />
		    </div>
		
		    <div class="option-container">
		        <label>옵션 타입 2</label>
		        <input type="text" name="option_type" class="option-type" placeholder="예: Color" />
		        <label>옵션 이름 2</label>
		        <input type="text" name="option_name" class="option-name" placeholder="예: Red, Blue, Black" />
		    </div>
		
		    <div class="option-container">
		        <label>옵션 타입 3</label>
		        <input type="text" name="option_type" class="option-type" placeholder="예: Material" />
		        <label>옵션 이름 3</label>
		        <input type="text" name="option_name" class="option-name" placeholder="예: Cotton, Wool" />
		    </div>
		</div>

        <label for="product_price">가격</label>
        <input type="text" id="product_price" name="product_price" value="0" required />
		
		<label for="product_inventory">재고 수량</label>
        <input type="number" id="product_inventory" name="product_inventory" value="0" step="1" min="0" />
		
		<label for="product_image">대표 이미지</label>
        <input type="file" id="product_image" name="product_image" accept="image/*" onchange="showPreview(this, 'preview1')" required/>
        <img id="preview1" class="image-preview" style="display: none;" />

        <label for="product_description">상세 정보</label>
        <textarea id="product_description" name="product_description" rows="10" placeholder="상품 설명을 입력하세요." required></textarea>

        <div class="button-container">
            <input type="submit" value="등록" />
            <input type="reset" onclick="history.back(-1);" value="취소" />
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
    
    document.getElementById('product_category_id').addEventListener('focus', function() {
        // 선택하세요 옵션 숨기기
        this.querySelector('option[value="0"]').style.display = 'none';
    });

    document.getElementById('product_category_id').addEventListener('change', function() {
        // 다른 옵션이 선택되면 선택하세요 옵션을 완전히 제거
        var optionToRemove = this.querySelector('option[value="0"]');
        if (optionToRemove) {
            optionToRemove.remove();
        }
    });
 
</script>
