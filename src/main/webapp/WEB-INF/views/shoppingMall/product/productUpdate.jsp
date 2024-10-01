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
            <option value="0" <c:if test="${product.getProduct_category_id()==0}"> selected </c:if>>선택하세요</option>
            <option value="1" <c:if test="${product.getProduct_category_id()==1}"> selected </c:if>>스포츠용품</option>
            <option value="2" <c:if test="${product.getProduct_category_id()==2}"> selected </c:if>>스포츠의류</option>
            <option value="3" <c:if test="${product.getProduct_category_id()==3}"> selected </c:if>>단백질보충제</option>
            <option value="4" <c:if test="${product.getProduct_category_id()==4}"> selected </c:if>>헬스&피트니스식품</option>
        </select>
        <label for="product_name">상품명</label>
        <input type="text" id="product_name" name="product_name" value="${product.getProduct_name()}" required/><br/>
        
        <label for="product_price">가격</label>
        <input type="text" id="product_price" name="product_price" value="${product.getProduct_price()}" required/><br/>
        
        <label for="product_image">상품 이미지</label>
        <input type="file" id="product_image" name="product_image" accept="image/*"/>
        
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
