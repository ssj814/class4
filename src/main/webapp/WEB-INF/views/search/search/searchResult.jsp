<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="<c:url value='/resources/css/general/searchResult.css'/>">

<div id="search-result-container" class="custom-search">
    <h2>검색 결과: "${keyword}"</h2>

    <!-- 검색 결과가 없는 경우 -->
    <c:if test="${empty results}">
        <p>검색 결과가 없습니다.</p>
    </c:if>

    <!-- Product 섹션 -->
    <div class="search-section">
        <h3 class="section-title">상품 (Product)</h3>
        <c:set var="productCount" value="0" />
        <c:set var="totalProductCount" value="0" />
        <!-- 상품 결과 개수 카운트 -->
        <c:forEach var="result" items="${results}">
            <c:if test="${result.category == 'PRODUCT'}">
                <c:set var="totalProductCount" value="${totalProductCount + 1}" />
            </c:if>
        </c:forEach>
        
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
                    <c:if test="${result.category == 'PRODUCT' && productCount < 3}">
                    	<c:set var="productCount" value="${productCount + 1}" />
                        <tr onclick="location.href='<c:url value='shopDetail?productId=${result.id}' />'" style="cursor: pointer;">
                            <td><img src="<c:url value='/images/shoppingMall_product/${result.writer}'/>" alt="Image"
                                    class="product-img"></td>
                            <td>${result.title}</td>
                            <td>${result.content}</td>
                            <td>${result.productPrice}</td>
                            <td>${result.createdAt}</td>
                        </tr>
                    </c:if>
                </c:forEach>
                <c:if test="${productCount == 0}">
                    <tr>
                        <td colspan="5">상품 결과가 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
        <c:if test="${totalProductCount > 3}">
        	<a href="<c:url value='/searchDetail?category=PRODUCT&keyword=${keyword}' />" class="btn btn-dark">더보기</a>
        </c:if>
    </div>

    <!-- Board 섹션 -->
    <div class="search-section">
        <h3 class="section-title">게시글 (Board)</h3>
        <c:forEach var="boardSection" items="${boardSections}">
            <h4 class="sub-section-title">${boardSection.name}</h4>
            <c:set var="boardCount" value="0" />
            <c:set var="totalBoardCount" value="0" />
            <!-- 게시판 결과 개수 카운트 -->
            <c:forEach var="result" items="${results}">
                <c:if test="${result.category == 'POSTS' && result.productPrice == boardSection.id}">
                    <c:set var="totalBoardCount" value="${totalBoardCount + 1}" />
                </c:if>
            </c:forEach>
            
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
                        <c:if test="${result.category == 'POSTS' && result.productPrice == boardSection.id && boardCount < 3}">
                            <c:set var="boardCount" value="${boardCount + 1}" />
                            <tr <c:choose>
                                    <c:when test="${boardSection.id == 1}">
                                        onclick="location.href='<c:url value='notice_content?postid=${result.id}' />'"
                                    </c:when>
                                    <c:when test="${boardSection.id == 2}">
                                        onclick="location.href='<c:url value='Retrieve/${result.id}/1' />'"
                                    </c:when>
                                    <c:when test="${boardSection.id == 3}">
                                        onclick="location.href='<c:url value='/sicdan_retrieve?num=${result.id}&currentPage=1' />'"
                                    </c:when>
                                </c:choose>
                                style="cursor: pointer;">
                                <td>${result.title}</td>
                                <td>${result.content}</td>
                                <td>${result.writer}</td>
                                <td>${result.createdAt}</td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    <c:if test="${boardCount == 0}">
                        <tr>
                            <td colspan="4">${boardSection.name} 결과가 없습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
            <c:if test="${totalBoardCount > 3}">
            	<a href="<c:url value='/searchDetail?category=POSTS&subcategory=${boardSection.id}&keyword=${keyword}' />" class="btn btn-dark">더보기</a>
            </c:if>
        </c:forEach>
    </div>

    <!-- FAQ 섹션 -->
    <div class="search-section">
        <h3 class="section-title">자주 묻는 질문 (FAQ)</h3>
        <c:set var="faqCount" value="0" />
        <c:set var="totalFaqCount" value="0" />
        <!-- FAQ 결과 개수 카운트 -->
        <c:forEach var="result" items="${results}">
            <c:if test="${result.category == 'FAQ'}">
                <c:set var="totalFaqCount" value="${totalFaqCount + 1}" />
            </c:if>
        </c:forEach>
        
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
                    <c:if test="${result.category == 'FAQ'}">
                        <c:set var="faqCount" value="${faqCount + 1}" />
                        <tr>
                            <td>${result.title}</td>
                            <td>${result.content}</td>
                            <td>${result.writer}</td>
                            <td>${result.createdAt}</td>
                        </tr>
                    </c:if>
                </c:forEach>
                <c:if test="${faqCount == 0}">
                    <tr>
                        <td colspan="4">FAQ 결과가 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
        <c:if test="${totalFaqCount > 3}">
        	<a href="<c:url value='/searchDetail?category=FAQ&keyword=${keyword}' />" class="btn btn-dark">더보기</a>
        </c:if>
    </div>

    <!-- 뒤로 가기 버튼 -->
    <button onclick="history.back()" class="btn btn-secondary back-button">뒤로 가기</button>
</div>
