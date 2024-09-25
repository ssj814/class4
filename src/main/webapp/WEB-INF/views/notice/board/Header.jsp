<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="resources/css/main.css">
<c:if test="${not empty pageSpecificCss}">
	<link rel="stylesheet" href="${pageSpecificCss}">
</c:if>
<title>Insert title here</title>
<!-- Flash Attribute로 전달된 메시지 처리 -->
<c:if test="${not empty mesg}">
    <script type="text/javascript">
        alert("${mesg}");
    </script>
</c:if>
</head>

<body>
	<header>
		<div class="header-content">
			<h1>
				<a href="MainShopServlet">운동이 답이다.</a>
			</h1>
		</div>
		<a href="LoginUIServlet" class="login-link">Login</a>
		<!-- 로그인 링크 추가 -->
		<nav>
			<ul>
				<li><a href="#">트레이너 구인</a></li>
				<li><a href="#">운동식단 추천</a></li>
				<li><a href="ShopListServlet">SHOP</a></li>
				<li><a href="#">운동대회</a></li>
				<li><a href="#">공지사항</a></li>
			</ul>
		</nav>
	</header>
	<!-- 	<div class="container"> -->
	<!-- 		<nav> -->
	<!-- 			<ul> -->
	<!-- 				<li><a href="#">트레이너 구인</a></li> -->
	<!-- 				<li><a href="#">운동식단 추천</a></li> -->
	<!-- 				<li><a href="#">SHOP</a></li> -->
	<!-- 				<li><a href="#">운동대회</a></li> -->
	<!-- 				<li><a href="BoardListServlet">공지사항</a></li> -->
	<!-- 			</ul> -->
	<!-- 		</nav> -->
	<!-- 	</div> -->