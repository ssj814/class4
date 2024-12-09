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

		<!-- 옵션 여부 토글 -->
        <label for="has_options_toggle">옵션 여부</label>
        <label class="switch">
            <input type="checkbox" id="has_options_toggle" checked>
            <span class="slider round"></span>
        </label>
        
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
		<div id="add-option-container">
		    <button type="button" id="add-option">옵션 추가</button>
		</div>

		<!-- 수량 입력 필드 (옵션이 없을 경우 표시) -->
        <div id="stock-container" style="display: none;">
            <label for="stock">수량</label>
            <input type="number" id="stock" name="stock_no_option" placeholder="예: 10" min="1" />
        </div>
        
        <label for="product_price">가격</label>
        <input type="text" id="product_price" name="product_price" placeholder="예: 1000" required />
		
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
	//토글에 따라 옵션 입력과 수량 입력 표시 전환
	document.getElementById('has_options_toggle').addEventListener('change', function () {
	    const optionContainer = document.getElementById('option-container');
	    const addOptionContainer = document.getElementById('add-option-container');
	    const stockContainer = document.getElementById('stock-container');
	
	    const optionTypeInputs = document.querySelectorAll('.option-type');
	    const optionStockInputs = document.querySelectorAll('.option-stock');
	    const optionNameInputs = document.querySelectorAll('.option-name');
	    const stockInput = document.getElementById('stock');
	
	    if (this.checked) {
	        // 옵션 입력 표시
	        optionContainer.style.display = 'block';
	        addOptionContainer.style.display = 'block';
	        stockContainer.style.display = 'none';
	
	        // 옵션 필수 설정
	        optionTypeInputs.forEach(input => input.setAttribute('required', 'required'));
	        optionStockInputs.forEach(input => input.setAttribute('required', 'required'));
	        optionNameInputs.forEach(input => input.setAttribute('required', 'required'));
	
	        // 수량 필수 해제
	        stockInput.removeAttribute('required');
	    } else {
	        // 옵션 입력 숨김, 수량 입력 표시
	        optionContainer.style.display = 'none';
	        addOptionContainer.style.display = 'none';
	        stockContainer.style.display = 'block';
	
	        // 옵션 필수 해제
	        optionTypeInputs.forEach(input => input.removeAttribute('required'));
	        optionStockInputs.forEach(input => input.removeAttribute('required'));
	        optionNameInputs.forEach(input => input.removeAttribute('required'));
	
	        // 수량 필수 설정
	        stockInput.setAttribute('required', 'required');
	    }
	});
	
	// 페이지 로드 시 초기 상태 설정
	document.addEventListener('DOMContentLoaded', function () {
	    const toggle = document.getElementById('has_options_toggle');
	    toggle.dispatchEvent(new Event('change')); // 초기 상태에 따라 동작
	});
	
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
    
    // 옵션별 수량의 총 합이 같은지 계산
    document.querySelector('form').addEventListener('submit', function (event) {
        const optionRows = document.querySelectorAll('.option-row');
        let totalStock = null;

        for (let row of optionRows) {
            const stockInput = row.querySelector('.option-stock');
            if (stockInput) {
                const stockValues = stockInput.value.split(',').map(value => parseInt(value.trim(), 10));
                const currentTotalStock = stockValues.reduce((acc, val) => acc + val, 0);

                // 첫 번째 옵션의 총합을 기준으로 설정
                if (totalStock === null) {
                    totalStock = currentTotalStock;
                } else if (totalStock !== currentTotalStock) {
                    alert("옵션별 수량의 총합이 일치하지 않습니다.");
                    event.preventDefault(); // 폼 제출 중단
                    return;
                }
            }
        }
    });
</script>
