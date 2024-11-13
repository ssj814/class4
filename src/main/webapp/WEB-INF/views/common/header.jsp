<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>">
<title>Insert title here</title>

</head>
<body> 
<header>
	<nav class="navbar navbar-expand-lg bg-dark border-body p-3"
		style="position: fixed; top: 0; left: 0; right: 0; z-index: 999;">
		<div class="container-fluid">
			<a class="navbar-brand fs-4" href="${pageContext.request.contextPath}"
				style="color: pink; font-style: italic;">PKDB </a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
				aria-controls="navbarNavDropdown" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link active"
						href="${pageContext.request.contextPath}/shopList" style="color: beige;">ShoppingMall</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="${pageContext.request.contextPath}/trainer_list" style="color: beige;">For Trainer</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="${pageContext.request.contextPath}/TrainerBoard" style="color: beige;">TrainerBoard</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"
						style="color: beige;">Meal Plan</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/cookingTip_cooking">Cooking	Tip</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/sicdan_list">Sicdan</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/Chart">Chart</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/bmiForm">BmiForm</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link active"
						href="${pageContext.request.contextPath}/notice" style="color: beige;">Notice</a></li>
						<li class="nav-item"><a class="nav-link active"
							href="${pageContext.request.contextPath}/Faq_allList" style="color: beige;">FAQ</a></li>
				</ul>
				<c:if test="${!empty sessionScope.SPRING_SECURITY_CONTEXT.authentication }"> <!-- 로그인 -->
					<ul class="navbar-nav ms-auto">
						<li class="nav-item"><a class="nav-link active"
							href="#" style="color: pink;">${sessionScope.SPRING_SECURITY_CONTEXT.authentication.name }<sec:authentication property="principal.userDto.userid" /> 님 환영합니다.</a></li>
						<li class="nav-item"><a class="nav-link active"
							href="${pageContext.request.contextPath}/logout" style="color: pink;">LOGOUT</a></li>
						<li class="nav-item"><a class="nav-link active"
							href="${pageContext.request.contextPath}/user/wishList" style="color: pink;">WISH</a></li>
						<li class="nav-item"><a class="nav-link active"
							href="${pageContext.request.contextPath}/user/cartList" style="color: pink;">CART</a></li>
						<li class="nav-item"><a class="nav-link active"
							href="${pageContext.request.contextPath}/mypage" style="color: pink;">MY</a></li>
						<c:if test="${fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN')}">
        					<li class="nav-item"><a class="nav-link active"
								href="${pageContext.request.contextPath}/admin/view" style="color: pink;">ADMIN</a></li>
        				</c:if>
					</ul>
				</c:if>
				<c:if test="${empty sessionScope.SPRING_SECURITY_CONTEXT.authentication }"><!-- 로그인 x -->
					<ul class="navbar-nav ms-auto">
						<li class="nav-item"><a class="nav-link active"
							href="loginForm" style="color: pink;">LOGIN/JOIN</a></li>
					</ul>
				</c:if>
			</div>
		</div>
	</nav>
	<div style="height: 70px"></div>
</header>
<main>