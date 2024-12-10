<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        
        <label for="product_isactive">판매상태</label>
        <input type="radio" name="product_isactive" value="1" <c:if test="${product.product_isactive == 1}"> checked </c:if> />판매중
        <input type="radio" name="product_isactive" value="0" <c:if test="${product.product_isactive == 0}"> checked </c:if>/>품절
        
        <!-- 옵션 여부 토글 -->
        <label for="has_options_toggle">옵션 여부</label>
        <label class="switch">
            <input type="checkbox" id="has_options_toggle" checked>
            <span class="slider round"></span>
        </label>
        
        <div id="option-container">
            <!-- 기존 옵션 출력 -->
            <c:forEach var="option" items="${options}">
                <div class="option-row">
                    <div class="input-group">
                        <label>옵션 타입</label>
                        <input type="text" name="option_type" class="option-type" value="${option.option_type}" placeholder="예: Size" />

                        <label>옵션 재고</label>
                        <input type="text" name="stock" class="option-stock" value="${option.stock}" placeholder="예: 10,15,20" />
                    </div>
                    <div class="input-group-2">
                        <label>옵션 이름</label>
                        <input type="text" name="option_name" class="option-name" value="${option.option_name}" placeholder="예: S,M,L" />

                        <button type="button" class="remove-option" onclick="removeOption(this)">삭제</button>
                    </div>
                </div>
            </c:forEach>
        </div>
        <!-- 옵션 추가 버튼 -->
        <div id="add-option-container">
            <button type="button" id="add-option">옵션 추가</button>
        </div>
        
		<!-- 수량 입력 필드 (옵션이 없을 경우 표시) -->
        <div id="stock-container" style="display: none;">
            <label for="stock">수량</label>
            <input type="number" id="stock" name="stock_no_option" value="${product.getProduct_stock() }" placeholder="예: 100" min="1" />
        </div>
        
        <label for="product_price">가격</label>
        <input type="text" id="product_price" name="product_price" value="${product.getProduct_price()}" required/><br/>
        
        <label for="product_image">상품 이미지</label>
        <input type="file" id="product_image" name="product_image" accept="image/*" onchange="showPreview(this, 'preview1')"/>
        <img id="preview1" class="image-preview" style="display: block;" src="<c:url value='/images/shoppingMall_product/${product.getProduct_imagename()}'/>"/>
        
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
	//페이지 로드 시 옵션 여부에 따라 필드 표시 설정
	window.addEventListener('DOMContentLoaded', function () {
	    const hasOptionsToggle = document.getElementById('has_options_toggle');
	    const optionContainer = document.getElementById('option-container');
	    const addOptionContainer = document.getElementById('add-option-container');
	    const stockContainer = document.getElementById('stock-container');
	
	    // 옵션 여부 초기 상태 설정
	    if (${product.hasOptions}) {
	        hasOptionsToggle.checked = true;
	        optionContainer.style.display = 'block';
	        addOptionContainer.style.display = 'block';
	        stockContainer.style.display = 'none';
	    } else {
	        hasOptionsToggle.checked = false;
	        optionContainer.style.display = 'none';
	        addOptionContainer.style.display = 'none';
	        stockContainer.style.display = 'block';
	    }
	    hasOptionsToggle.dispatchEvent(new Event('change')); // 초기 상태에 따라 필수 필드 설정
	});

	// 옵션 여부에 따라 필수 필드 설정
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

	        // 옵션 필드에 필수 속성 추가
	        optionTypeInputs.forEach(input => input.setAttribute('required', 'required'));
	        optionStockInputs.forEach(input => input.setAttribute('required', 'required'));
	        optionNameInputs.forEach(input => input.setAttribute('required', 'required'));

	        // 수량 필드에서 필수 속성 제거
	        stockInput.removeAttribute('required');
	    } else {
	        // 옵션 입력 숨김
	        optionContainer.style.display = 'none';
	        addOptionContainer.style.display = 'none';
	        stockContainer.style.display = 'block';

	        // 옵션 필드에서 필수 속성 제거
	        optionTypeInputs.forEach(input => input.removeAttribute('required'));
	        optionStockInputs.forEach(input => input.removeAttribute('required'));
	        optionNameInputs.forEach(input => input.removeAttribute('required'));

	        // 수량 필드에 필수 속성 추가
	        stockInput.setAttribute('required', 'required');
	    }
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
	
    // 옵션 추가
    document.getElementById('add-option').addEventListener('click', function () {
        const container = document.getElementById('option-container');
        const currentOptions = container.querySelectorAll('.option-row').length;

        if (currentOptions >= 10) {
            alert('옵션은 최대 10개까지만 추가할 수 있습니다.');
            return;
        }

        const newRow = document.createElement('div');
        newRow.classList.add('option-row');
        newRow.innerHTML = `
            <div class="input-group">
                <label>옵션 타입</label>
                <input type="text" name="option_type" class="option-type" placeholder="예: Size" />
                
                <label>옵션 재고</label>
                <input type="text" name="stock" class="option-stock" placeholder="예: 10,15,20" />
            </div>
            <div class="input-group-2">
                <label>옵션 이름</label>
                <input type="text" name="option_name" class="option-name" placeholder="예: S,M,L" />
                
                <button type="button" class="remove-option" onclick="removeOption(this)">삭제</button>
            </div>
        `;
        container.appendChild(newRow);
    });

    // 옵션 삭제
    function removeOption(button) {
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