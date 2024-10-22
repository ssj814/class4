<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
<link rel="stylesheet" href="resources/css/main.css">
<title>Insert title here</title>

</head>
<body> 
<header>
	<nav class="navbar navbar-expand-lg bg-dark border-body p-3"
		style="position: fixed; top: 0; left: 0; right: 0; z-index: 999;">
		<div class="container-fluid">
			<a class="navbar-brand fs-4" href="/app"
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
						href="/app/shopList" style="color: beige;">ShoppingMall</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="/app/trainer_list" style="color: beige;">For Trainer</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="/app/TrainerBoard" style="color: beige;">TrainerBoard</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"
						style="color: beige;">Meal Plan</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="/app/cookingTip">Cooking	Tip</a></li>
							<li><a class="dropdown-item" href="/app/sicdan_list">Sicdan</a></li>
							<li><a class="dropdown-item" href="/app/Chart">Chart</a></li>
							<li><a class="dropdown-item" href="/app/bmiForm">BmiForm</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link active"
						href="/app/FitnessContest" style="color: beige;">For Contest</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="/app/notice" style="color: beige;">Notice</a></li>
				</ul>
				<ul class="navbar-nav ms-auto">
					<li class="nav-item"><a class="nav-link active"
						href="wishList" style="color: pink;">WISH</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="cartList" style="color: pink;">CART</a></li>
					<li class="nav-item"><a class="nav-link active" href="#"
						style="color: pink;">LOGIN</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div style="height: 70px"></div>
</header>
<main>