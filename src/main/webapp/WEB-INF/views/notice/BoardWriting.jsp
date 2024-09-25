<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("pageSpecificCss", "resources/css/notice/BoardWriting.css");
%>
<!-- 임시로 css 작성해둠 -->
<link rel="stylesheet" href="resources/css/notice/BoardWriting.css">
<!--  -->
<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
<jsp:include page="board/BoardWriting.jsp" flush="true" />
<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>