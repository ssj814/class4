<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="<c:url value='/resources/css/searchResult.css'/>">

<div id="search-result-container" class="custom-search">
    <h2>검색 결과: "${keyword}"</h2>

    <!-- 검색 결과가 없는 경우 -->
    <c:if test="${empty results}">
        <p>검색 결과가 없습니다.</p>
    </c:if>

	<c:if test="${category == 'PRODUCT'}">
    <!-- Product 섹션 -->
    <div class="search-section">
        <h3 class="section-title">상품 (Product)</h3>
        <table class="custom-table">
            <thead>
                <tr>
                    <th>상품 이미지</th>
                    <th>상품 이름</th>
                    <th>상품 설명</th>
                    <th>가격</th>
                    <th>등록일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="result" items="${results}">
                    <tr onclick="location.href='<c:url value='shopDetail?productId=${result.id}' />'" style="cursor: pointer;">
                        <td><img src="<c:url value='/images/shoppingMall_product/${result.writer}'/>" alt="Image"
                                class="product-img"></td>
                        <td>${result.title}</td>
                        <td>${result.content}</td>
                        <td>${result.productPrice}</td>
                        <td>${result.createdAt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    </c:if>

	<c:if test="${category == 'POSTS'}">
    <!-- Board 섹션 -->
    <div class="search-section">
        <h3 class="section-title">게시글 (Board)</h3>
            <h4 class="sub-section-title">${subcategoryName}</h4>
            <table class="custom-table">
                <thead>
                    <tr>
                        <th>제목</th>
                        <th>내용</th>
                        <th>작성자</th>
                        <th>등록일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="result" items="${results}">
                            <tr <c:choose>
                                    <c:when test="${result.productPrice == 1}">
                                        onclick="location.href='<c:url value='notice_content?postid=${result.id}' />'"
                                    </c:when>
                                    <c:when test="${result.productPrice == 2}">
                                        onclick="location.href='<c:url value='Retrieve/${result.id}/1' />'"
                                    </c:when>
                                    <c:when test="${result.productPrice == 3}">
                                        onclick="location.href='<c:url value='/sicdan_retrieve?num=${result.id}&currentPage=1' />'"
                                    </c:when>
                                </c:choose>
                                style="cursor: pointer;">
                                <td>${result.title}</td>
                                <td>${result.content}</td>
                                <td>${result.writer}</td>
                                <td>${result.createdAt}</td>
                            </tr>
                    </c:forEach>
                </tbody>
            </table>
    </div>
    </c:if>

	<c:if test="${category == 'FAQ'}">
    <!-- FAQ 섹션 -->
    <div class="search-section">
        <h3 class="section-title">자주 묻는 질문 (FAQ)</h3>
        <table class="custom-table">
            <thead>
                <tr>
                    <th>질문</th>
                    <th>답변</th>
                    <th>작성자</th>
                    <th>등록일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="result" items="${results}">
                    <tr>
                        <td>${result.title}</td>
                        <td>${result.content}</td>
                        <td>${result.writer}</td>
                        <td>${result.createdAt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
	</c:if>
	
    <!-- 뒤로 가기 버튼 -->
    <button onclick="history.back()" class="btn btn-secondary back-button">뒤로 가기</button>
</div>
