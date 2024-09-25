<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setAttribute("pageSpecificCss", "resources/css/notice/list.css");
%>
<!-- 임시로 css 작성해둠 -->
<link rel="stylesheet" href="resources/css/notice/list.css">
<!--  -->
<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
<jsp:include page="board/list.jsp" flush="true" />
<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>