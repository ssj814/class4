<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Home</title>
	<link rel="stylesheet" href="resources/css/trainerboard_css/tb.css">
	
</head>
<body>
	<div class="container" style="margin-top:40px; ">
		<main>
		<form action="TrainerBoard" method="get" id="search">
			<select name="searchName">
				<option value="userid">작성자</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="searchValue" placeholder="검색어">
			<input type="submit" value="검색">
		</form>

		<table border="1" id="listForm">
			<colgroup>
				<col style="width: 10%;">
				<col style="width: 60%;">
				<col style="width: 10%;">
				<col style="width: 10%;">
				<col style="width: 10%;">
			</colgroup>
			<thead>
				<tr>
					<th>게시글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${pDTO != null && pDTO.list != null && !pDTO.list.isEmpty()}">
						<c:forEach var="dto" items="${pDTO.list}">
							<tr>
								<td>${dto.postid}</td>
								<td><a href="Retrieve/${dto.postid}/${pDTO.curPage}">${dto.title}</a></td>
								<td>${dto.userid}</td>
								<td>${dto.crdate}</td>
								<td>${dto.viewcount}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="5">게시글이 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>

		<!-- 페이지 네비게이션 -->
		<div class="tbpagination">
			<c:if test="${pDTO.curPage > 1}">
				<a href="TrainerBoard?curPage=${pDTO.curPage - 1}&searchName=${searchName}&searchValue=${searchValue}">이전</a>
			</c:if>
			<c:forEach var="i" begin="1" end="${pDTO.totalPages}">
				<a href="TrainerBoard?curPage=${i}&searchName=${searchName}&searchValue=${searchValue}">${i}</a>
			</c:forEach>
			<c:if test="${pDTO.curPage < pDTO.totalPages}">
				<a href="TrainerBoard?curPage=${pDTO.curPage + 1}&searchName=${searchName}&searchValue=${searchValue}">다음</a>
			</c:if>
		</div>

		<br>
		<a class="buttonmulti" href="${pageContext.request.contextPath}/trainerboardWrite">글쓰기</a>
		</main>
	</div>
</body>
</html>
