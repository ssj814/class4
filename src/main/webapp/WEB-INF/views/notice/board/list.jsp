<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container">
	<div id="boardList">
		<div id="boardList_title">[ 공 지 사 항 ]</div>
		<div id="boardList_list">
			<div id="postTitle">
				<dl class="horizontal">
					<dt class="postid">번호</dt>
					<dt class="title">제목</dt>
					<dt class="writer">작성자</dt>
					<dt class="createdate">작성일</dt>
					<dt class="viewcount">조회수</dt>
				</dl>
			</div>
			<div id="lists">
				<c:forEach var="dto" items="${BoardList}">
					<dl class="horizontal">
						<dd class="postid">${dto.postid}</dd>
						<dd class="title">
							<a
								href="notice_content?postid=${dto.postid}&currentPage=${currentPage}">${dto.title}</a>
						</dd>
						<dd class="writer">${dto.writer}</dd>
						<dd class="createdate">${dto.createdate}</dd>
						<dd class="viewcount">${dto.viewcount}</dd>
					</dl>
				</c:forEach>
			</div>
		</div>
		<div id="boardList_paging">
			<c:choose>
                <c:when test="${currentPage > 1}">
                    <a class="page-link"
                        href="notice?currentPage=${currentPage - 1}
                        <c:if test='${not empty search.searchKey && not empty search.searchValue}'>
                            &searchKey=${search.searchKey}&searchValue=${search.searchValue}
                        </c:if>
                    ">이전</a>
                </c:when>
            </c:choose>
            <c:forEach var="i" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span>${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a
                            href="notice?currentPage=${i}<c:if test='${not empty search.searchKey && not empty search.searchValue}'>
                        &searchKey=${search.searchKey}&searchValue=${search.searchValue}
                    </c:if>">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:choose>
                <c:when test="${currentPage < totalPages}">
                    <a class="page-link"
                        href="notice?currentPage=${currentPage + 1}
                        <c:if test='${not empty search.searchKey && not empty search.searchValue}'>
                            &searchKey=${search.searchKey}&searchValue=${search.searchValue}
                        </c:if>
                    ">다음</a>
                </c:when>
            </c:choose>
		</div>
		<div id="boardList_footer">
			<div>
				<form action="#" method="post" name="searchForm">
					<select name="searchKey" class="selectField">
						<option value="title">제목</option>
						<option value="writer">작성자</option>
						<option value="content">내용</option>
					</select> <input type="text" name="searchValue" class="textField" /> <input
						type="button" value=" 검 색 " id="boardSearch" />
				</form>
			</div>
			<div>
				<c:if test="${fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN')}">
					<input type="button" value=" 글쓰기 " id="Writing" />
				</c:if>
			</div>
		</div>
	</div>
</div>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#Writing").on("click", function() {
			location.href = 'admin/notice_write';
		});

		$("#boardSearch").on("click", function() {
			$("form").attr("action", "notice").submit();
		});
	});
</script>