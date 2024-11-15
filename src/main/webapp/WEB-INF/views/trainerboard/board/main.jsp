<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
				<option value="realUsername">작성자</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="searchValue" placeholder="검색어">
			<input type="submit" value="검색">
		</form>

		<table border="1" id="listForm">
			<colgroup>
				<col style="width: 7%;">
				<col style="width: 63%;">
				<col style="width: 10%;">
				<col style="width: 10%;">
				<col style="width: 10%;">
			</colgroup>
			<thead>
				<tr>
					<td class="tdTopPosts" style="font-weight: bold;">번호</td>
					<td style="font-weight: bold;">제목</td>
					<td class="tdTopPosts" style="font-weight: bold;">작성자</td>
					<td class="tdTopPosts" style="font-weight: bold;">작성일</td>
					<td class="tdTopPosts" style="font-weight: bold;">조회</td>
				</tr>
			</thead>
			<tbody>
			
			<!-- 조회수 순 -->
				<c:if test="${not empty topPosts}">
    					<c:forEach var="post" items="${topPosts}">
       					 <tr>
       					 	<td class="tdTopPosts"><img src="resources/img/trainerboard/recommend.png" alt="recommend" height=25 width=25></td>
            				<td class="trainerboard_topPosts"><a href="Retrieve/${post.postid}/${pDTO.curPage}"><strong>${post.title}</strong></a></td>
           					<td class="tdTopPosts">${post.realUsername}</td>
            				<td class="tdTopPosts">${post.crdate}</td>
            				<td class="tdTopPosts">${post.viewcount}</td>
       					 </tr>
   						 </c:forEach>
				</c:if>
		
				<c:choose>
				<c:when test="${pDTO != null && pDTO.list != null && !pDTO.list.isEmpty()}">
						<c:forEach var="dto" items="${pDTO.list}" varStatus="status">
							<tr>
								<td class="trainerboard_postno">${pDTO.totalCount-(status.index+(pDTO.curPage-1)*pDTO.perPage)} </td>
								<td class="trainerboard_content"><a href="Retrieve/${dto.postid}/${pDTO.curPage}">${dto.title}</a></td>
								<td class="trainerboard_tbody">${dto.realUsername}</td>
								<td class="trainerboard_tbody" >${dto.crdate}</td>
								<td class="trainerboard_tbody">${dto.viewcount}</td>
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

		<c:if test="${fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'TRAINER') 
			or fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN')}">
		<!-- TRAINER로 권한 설정된 회원만 글쓰기 보이게 -->
		<div class="button">
			<button class="buttonmulti" onclick="location.href='${pageContext.request.contextPath}/trainerboardWrite'">글쓰기</button>
		</div>
		</c:if>

		</main>
	</div>
</body>
</html>