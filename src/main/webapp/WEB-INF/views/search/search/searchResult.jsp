<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container" style="margin-top: 80px;">
    <h2>검색 결과: "${keyword}"</h2>

    <!-- 검색 결과가 없는 경우 -->
    <c:if test="${empty results}">
        <p>검색 결과가 없습니다.</p>
    </c:if>

    <!-- Product 섹션 -->
    <h3>상품 (Product)</h3>
    <c:set var="hasProduct" value="false" />
    <table class="table table-striped">
        <thead>
            <tr>
                <th>제목</th>
                <th>내용</th>
                <th>등록일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="result" items="${results}">
                <c:if test="${result.category == 'PRODUCT'}">
                    <c:set var="hasProduct" value="true" />
                    <tr>
                        <td>${result.title}</td>
                        <td>${result.content}</td>
                        <td>${result.createdAt}</td>
                    </tr>
                </c:if>
            </c:forEach>
            <c:if test="${not hasProduct}">
                <tr>
                    <td colspan="3">상품 결과가 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <!-- Board 섹션 -->
    <h3>게시글 (Board)</h3>
    <c:set var="hasBoard" value="false" />
    <table class="table table-striped">
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
                <c:if test="${result.category == 'POSTS'}">
                    <c:set var="hasBoard" value="true" />
                    <tr>
                        <td>${result.title}</td>
                        <td>${result.content}</td>
                        <td>${result.writer}</td>
                        <td>${result.createdAt}</td>
                    </tr>
                </c:if>
            </c:forEach>
            <c:if test="${not hasBoard}">
                <tr>
                    <td colspan="4">게시글 결과가 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <!-- FAQ 섹션 -->
    <h3>자주 묻는 질문 (FAQ)</h3>
    <c:set var="hasFAQ" value="false" />
    <table class="table table-striped">
        <thead>
            <tr>
                <th>질문</th>
                <th>답변</th>
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
                        <td>${result.createdAt}</td>
                    </tr>
                </c:if>
            </c:forEach>
            <c:if test="${not hasFAQ}">
                <tr>
                    <td colspan="3">FAQ 결과가 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <!-- 뒤로 가기 버튼 -->
    <button onclick="history.back()" class="btn btn-secondary" style="margin-bottom: 50px;">뒤로 가기</button>
</div>
