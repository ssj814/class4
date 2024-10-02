<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헬스대회 게시판</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="resources/css/main.css" rel="stylesheet" type="text/css">
<link href="resources/css/contest/fitnessContest.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
$(function () {
	  $("#main").on("click", function () {
      	location.href = "FitnessContest";
		})
})
</script>
</head>
<body class="fitness-body">
   <jsp:include page="/WEB-INF/views/common/header.jsp" flush="true"></jsp:include>
    
    <div class="fitness-container">
        <div class="fitness-main-content">
            <h1 id="main">헬스대회</h1>
            <div class="fitness-list-header">
                <span class="fitness-post-head">글번호</span>
                <span class="fitness-post-title">제목</span>
                <span class="fitness-post-meta">작성자</span>
                <span class="fitness-post-meta">작성일</span>
                <span class="fitness-post-meta">조회</span>
            </div>
            <ul class="fitness-post-list">
                
                
    			
    		<c:forEach var="post" items="${posts }">
               
                    <li class="fitness-post-item">
                        <span class="fitness-post-head">${post.postid }</span>
                        <span class="fitness-post-title"><a href="FitnessContent?postid=${post.postid }">${post.title }</a></span>
                        <span class="fitness-post-meta">${post.writer }</span>
                        <span class="fitness-post-meta">${post.createdate }</span>
                        <span class="fitness-post-meta">${post.viewcount }</span>
                    </li>
                    
                </c:forEach>
            </ul>
            <div class="fitness-search-container"> 
            <form action="SearchContent">
    <div class="fitness-search-box">
        <select id="searchCategory" name="select" class="sea">
            <option value="작성자">작성자</option>
            <option value="내용">내용</option>
        </select>
        <input type="text" name="text" class="sea">
        <button type="submit" id="search" name="search" class="sea">검색</button>
    </div>
    </form>
    <div class="fitness-write-button">
        <form action="Write" method="get">
            <button type="submit" id="write" class="sea">글쓰기</button>
        </form>
    </div>
</div>

        <!-- 페이지네이션 -->
        <div class="fitness-pagination">
    <c:if test="${currentPage > 1}">
        <a href="FitnessContest?page=1">&laquo; 처음</a>
        <a href="FitnessContest?page=${currentPage - 1}">&laquo; 이전</a>
    </c:if>

    <c:forEach var="i" begin="${startPage}" end="${endPage}">
        <a href="FitnessContest?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
    </c:forEach>

    <c:if test="${currentPage < totalPages}">
        <a href="FitnessContest?page=${currentPage + 1}">다음 &raquo;</a>
        <a href="FitnessContest?page=${totalPages}">마지막 &raquo;</a>
    </c:if>
</div>
    </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" flush="true"></jsp:include>
</body>
</html>