<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="resources/css/shoppingMall/productInsert.css">

<div class="container insert-container">
    <h1>상품 등록</h1>
    <form action="<c:url value='/product'/>" method="post" enctype="multipart/form-data">
        <label for="product_category_id">카테고리</label>
        <select id="product_category_id" name="product_category_id" >
            <option value="0">선택하세요</option>
            <option value="1">스포츠용품</option>
            <option value="2">스포츠의류</option>
            <option value="3">단백질보충제</option>
            <option value="4">헬스&피트니스식품</option>
        </select>
        
        <label for="product_isactive">판매상태</label>
        <input type="radio" name="product_isactive" value="1" checked="checked"/>판매중
        <input type="radio" name="product_isactive" value="0"/>품절
        
        <label for="product_id">상품코드</label>
        <input type="text" id="product_id" name="product_id" placeholder="${ProductId}" value="${ProductId}" readonly />
        
        <label for="product_name">상품명</label>
        <input type="text" id="product_name" name="product_name" placeholder="상품명을 입력하세요." required />

        <label for="product_price">가격</label>
        <input type="text" id="product_price" name="product_price" value="0" required />
		
		<label for="product_inventory">재고 수량</label>
        <input type="number" id="product_inventory" name="product_inventory" value="0" step="1" min="0" />
		
		<label for="product_image">대표 이미지</label>
        <input type="file" id="product_image" name="product_image" accept="image/*" onchange="showPreview(this, 'preview1')" />
        
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
	
    function showPreview(input, previewId) {
        const file = input.files[0];
        if (file) {
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
