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

    <!-- Product 섹션 -->
    <div class="search-section">
        <h3 class="section-title">상품 (Product)</h3>
        <c:set var="hasProduct" value="false" />
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
                    <c:if test="${result.category == 'PRODUCT'}">
                        <c:set var="hasProduct" value="true" />
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
                <c:if test="${not hasProduct}">
                    <tr>
                        <td colspan="5">상품 결과가 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- Board 섹션 -->
    <div class="search-section">
        <h3 class="section-title">게시글 (Board)</h3>
        <c:forEach var="boardSection" items="${boardSections}">
            <h4 class="sub-section-title">${boardSection.name}</h4>
            <c:set var="hasBoard" value="false" />
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
                        <c:if test="${result.category == 'POSTS' && result.productPrice == boardSection.id}">
                            <c:set var="hasBoard" value="true" />
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
                    <c:if test="${not hasBoard}">
                        <tr>
                            <td colspan="4">${boardSection.name} 결과가 없습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </c:forEach>
    </div>

    <!-- FAQ 섹션 -->
    <div class="search-section">
        <h3 class="section-title">자주 묻는 질문 (FAQ)</h3>
        <c:set var="hasFAQ" value="false" />
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
                        <c:set var="hasFAQ" value="true" />
                        <tr>
                            <td>${result.title}</td>
                            <td>${result.content}</td>
                            <td>${result.writer}</td>
                            <td>${result.createdAt}</td>
                        </tr>
                    </c:if>
                </c:forEach>
                <c:if test="${not hasFAQ}">
                    <tr>
                        <td colspan="4">FAQ 결과가 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- 뒤로 가기 버튼 -->
    <button onclick="history.back()" class="btn btn-secondary back-button">뒤로 가기</button>
</div>
