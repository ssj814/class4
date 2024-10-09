<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헬스대회 게시판 - 검색 결과</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="resources/css/contest/main.css" rel="stylesheet" type="text/css">
<style type="text/css">
    .search-results-container {
        padding: 20px;
        max-width: 1200px;
        margin: 0 auto;
        background-color: #fff;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
        padding-top: calc(1rem + 100px); /* 헤더 높이만큼 여백 추가 */
        margin-top: 70px; /* 네비게이션 바의 높이에 따라 이 값을 조정 */
    }

    .search-results-container h1 {
        font-size: 2em;
        margin-bottom: 20px;
        text-align: center;
        color: #333;
    }

    /* 스타일들을 search-results-container로 한정 */
    .search-results-container .list-header,
    .search-results-container .post-item {
        display: flex;
        justify-content: space-between;
        padding: 10px 0;
        border-bottom: 1px solid #ddd;
    }

    .search-results-container .list-header {
        font-weight: bold;
        background-color: #f9f9f9;
        padding: 15px;
        border-bottom: 2px solid #ddd;
    }

    .search-results-container .post-item {
        padding: 15px;
        transition: background-color 0.3s ease;
    }

    .search-results-container .post-item:hover {
        background-color: #f1f1f1;
    }

    .search-results-container .post-head, 
    .search-results-container .post-title, 
    .search-results-container .post-meta {
        flex: 1;
        text-align: center;
    }

    .search-results-container .post-title {
        flex: 3;
        color: #333;
    }

    .search-results-container .post-item a {
        text-decoration: none;
        color: #007BFF;
    }

    .search-results-container .post-item a:hover {
        color: #0056b3;
    }

    .search-results-container .search-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 20px;
    }

    .search-results-container .search-box {
        display: flex;
        align-items: center;
        flex: 1;
    }

    .search-results-container .search-box input[type="text"] {
        margin-right: 10px;
    }

    .search-results-container .write-button {
        text-align: right;
        flex: 1;
    }

    .search-results-container .pagination {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }

    .search-results-container .pagination a {
        color: black;
        padding: 8px 16px;
        text-decoration: none;
        margin: 0 4px;
        border-radius: 4px;
        transition: background-color 0.3s ease;
    }

    .search-results-container .pagination a.active {
        background-color: #007BFF;
        color: white;
    }

    .search-results-container .pagination a:hover:not(.active) {
        background-color: #ddd;
    }
</style>
<script type="text/javascript">
$(function () {
    $("#main").on("click", function () {
        location.href="FitnessContest";
    })
})
</script>
</head>
<body>
     <jsp:include page="/WEB-INF/views/common/header.jsp" flush="true"></jsp:include>
    
    <div class="search-results-container">
        <div class="main-content">
            <h1 id="main">헬스대회</h1>
            <div class="list-header">
                <span class="post-head">말머리</span>
                <span class="post-title">제목</span>
                <span class="post-meta">작성자</span>
                <span class="post-meta">작성일</span>
                <span class="post-meta">조회</span>
            </div>
            <ul class="post-list">
                <c:forEach var="post" items="${posts}">
                    <li class="post-item">
                        <span class="post-head">${post.postid}</span>
                        <span class="post-title"><a href="FitnessContent?postid=${post.postid}">${post.title}</a></span>
                        <span class="post-meta">${post.writer}</span>
                        <span class="post-meta">${post.createdate}</span>
                        <span class="post-meta">${post.viewcount}</span>
                    </li>
                </c:forEach>
            </ul>
            <div class="search-container"> 
                <form action="SearchContent">
                    <div class="search-box">
                        <select id="searchCategory" name="select" class="sea">
                            <option value="작성자">작성자</option>
                            <option value="내용">내용</option>
                        </select>
                        <input type="text" name="text" class="sea">
                        <button type="submit" id="search" name="search" class="sea">검색</button>
                    </div>
                </form>
                <div class="write-button">
                    <form action="insert.jsp" method="get">
                        <button type="submit" id="write" class="sea">글쓰기</button>
                    </form>
                </div>
            </div>

            <!-- 페이지네이션 -->
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="SearchContent?page=1&select=${param.select}&text=${param.text}">&laquo; 처음</a>
                    <a href="SearchContent?page=${currentPage - 1}&select=${param.select}&text=${param.text}">&laquo; 이전</a>
                </c:if>

                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                    <a href="SearchContent?page=${i}&select=${param.select}&text=${param.text}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="SearchContent?page=${currentPage + 1}&select=${param.select}&text=${param.text}">다음 &raquo;</a>
                    <a href="SearchContent?page=${totalPages}&select=${param.select}&text=${param.text}">마지막 &raquo;</a>
                </c:if>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" flush="true"></jsp:include>
</body>
</html>