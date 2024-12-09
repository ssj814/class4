<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="resources/css/shoppingMall/productInsert.css">

<div class="container insert-container">
    <h1>상품 등록</h1>
    <form action="<c:url value='/product'/>" method="post" enctype="multipart/form-data">
        <label for="product_category_id">카테고리</label>
	    <select id="product_category_id" name="product_category_id">
		    <option value="select" disabled selected>선택하세요</option>
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
        <input type="text" id="product_name" name="product_name" placeholder="상품명을 입력하세요."  maxlength="50" required />

		<div id="option-container">
		    <div class="option-row">
		        <div class="input-group">
		            <label>옵션 타입</label>
		            <input type="text" name="option_type" class="option-type" placeholder="예: Size" />
		            
		            <label>각 옵션별 수량</label>
		            <input type="text" name="stock" class="option-stock" placeholder="예: 10,15,20" min="0" />
		        </div>
		
		        <div class="input-group-2">
		            <label>옵션 이름</label>
		            <input type="text" name="option_name" class="option-name" placeholder="예: S,M,L" />
		            
		            <button type="button" class="remove-option" onclick="removeOption(this)">삭제</button>
		        </div>
		    </div>
		</div>
		
		<!-- 옵션 추가 버튼 -->
		<div>
		    <button type="button" id="add-option">옵션 추가</button>
		</div>

        <label for="product_price">가격</label>
        <input type="text" id="product_price" name="product_price" value="0" required />
		
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
        this.querySelector('option[value="select"]').style.display = 'none';
    });

    document.getElementById('product_category_id').addEventListener('change', function() {
        // 다른 옵션이 선택되면 선택하세요 옵션을 완전히 제거
        var optionToRemove = this.querySelector('option[value="select"]');
        if (optionToRemove) {
            optionToRemove.remove();
        }
    });
 
    document.getElementById('add-option').addEventListener('click', function () {
        const container = document.getElementById('option-container');
     	// 현재 옵션 개수 확인
        const currentOptions = container.querySelectorAll('.option-row').length;
        // 옵션 최대개수 제한
        if (currentOptions >= 10) {
            alert('옵션은 최대 10개까지만 추가할 수 있습니다.');
            return;
        }
        // 새로운 옵션 행 생성
        const newRow = document.createElement('div');
        newRow.classList.add('option-row');
        
        newRow.innerHTML = `
            <div class="input-group">
                <label>옵션 타입</label>
                <input type="text" name="option_type" class="option-type" placeholder="예: Size" />
                
                <label>옵션 재고</label>
                <input type="text" name="stock" class="option-stock" placeholder="예: 10,15,20" min="0" />
            </div>
            <div class="input-group-2">
                <label>옵션 이름</label>
                <input type="text" name="option_name" class="option-name" placeholder="예: S,M,L" />
                
                <button type="button" class="remove-option" onclick="removeOption(this)">삭제</button>
            </div>
        `;
        
        container.appendChild(newRow);
    });

    function removeOption(button) {
        // 버튼이 속한 전체 옵션 행(`option-row`) 삭제
        const optionRow = button.closest('.option-row');
        if (optionRow) {
            optionRow.remove();
        }
    }
</script>
