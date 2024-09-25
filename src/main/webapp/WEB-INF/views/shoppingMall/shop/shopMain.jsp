<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- top -->
<div id="carouselExampleFade" class="carousel slide carousel-fade">
	<div class="carousel-inner">
		<div class="carousel-item active">
			<img src="<c:url value='/images/shoppingMall_main/al.webp'/>" class="d-block w-100" alt="..."
				style="height: 100vh; object-fit: cover;">
		</div>
		<div class="carousel-item">
			<img src="<c:url value='/images/shoppingMall_main/mm.jpg'/>" class="d-block w-100" alt="..."
				style="height: 100vh; object-fit: cover;">
			<div class="carousel-caption d-none d-md-block text-end"
				style="bottom: 20%; right: 15%;">
				<h1 style="font-size: 5rem; color: black;">Strength</h1>
				<h1 style="font-size: 5rem; color: black; margin-right: 50px;">Meets</h1>
				<h1 style="font-size: 5rem; color: black; margin-right: 80px;">Style</h1>
			</div>
		</div>

	</div>
	<button class="carousel-control-prev" type="button"
		data-bs-target="#carouselExampleFade" data-bs-slide="prev">
		<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="visually-hidden">Previous</span>
	</button>
	<button class="carousel-control-next" type="button"
		data-bs-target="#carouselExampleFade" data-bs-slide="next">
		<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="visually-hidden">Next</span>
	</button>
</div>

<hr class="container p-3">

<!-- mid-1 -->
<div class="container text-center">
	<div class="row">
		<div class="col-3 d-flex flex-column justify-content-start">
			<p
				style="font-size: 24px; font-weight: bold; letter-spacing: 1px; background-color: #eee; border-radius: 10px">DISCOVER</p>
			<ul class="list-group list-group-flush mt-2" style="cursor: pointer;">
				<li class="list-group-item list-group-item-action fw-bolder"
					data-bs-toggle="collapse" data-bs-target="#extra-items1">ShoppingMall
				</li>
				<!-- toggle list-->
				<ul class="collapse list-group list-group-flush" id="extra-items1"
					style="margin-left: 20px;">
					<li class="list-group-item fst-italic"><a href="shopList"
						class="text-dark" style="text-decoration: none">View All
							Products</a></li>
					<li class="list-group-item fst-italic"><a href="<c:url value='/shopList?category=1'/>"
						class="text-dark" style="text-decoration: none">Athletic Gear</a></li>
					<li class="list-group-item fst-italic"><a href="<c:url value='/shopList?category=2'/>"
						class="text-dark" style="text-decoration: none">Active wear</a></li>
					<li class="list-group-item fst-italic"><a href="<c:url value='/shopList?category=3'/>"
						class="text-dark" style="text-decoration: none">Protein
							Supplements</a></li>
					<li class="list-group-item fst-italic"><a href="<c:url value='/shopList?category=4'/>"
						class="text-dark" style="text-decoration: none">Health &
							Fitness Foods</a></li>
					<li class="list-group-item fst-italic"
						style="border-bottom: 1px solid rgba(0, 0, 0, 0.125);"><a href="<c:url value='/shopList?category=0'/>"
						class="text-dark" style="text-decoration: none">Others</a></li>
				</ul>
				<li class="list-group-item list-group-item-action fw-bolder"
					data-bs-toggle="collapse" data-bs-target="#extra-items2">For
					Trainer</li>
				<!-- toggle list-->
				<ul class="collapse list-group list-group-flush" id="extra-items2"
					style="margin-left: 20px;">
					<li class="list-group-item fst-italic"><a href="#"
						class="text-dark" style="text-decoration: none">Find a Trainer</a></li>
					<li class="list-group-item fst-italic"
						style="border-bottom: 1px solid rgba(0, 0, 0, 0.125);"><a
						href="#" class="text-dark" style="text-decoration: none">Trainer
							Tips</a></li>
				</ul>
				<li class="list-group-item list-group-item-action fw-bolder"><a
					href="#" class="text-dark" style="text-decoration: none">Meal
						Plan</a></li>
				<li class="list-group-item list-group-item-action fw-bolder"><a
					href="#" class="text-dark" style="text-decoration: none">For
						Contest</a></li>
				<li class="list-group-item list-group-item-action fw-bolder"><a
					href="#" class="text-dark" style="text-decoration: none">Notice</a></li>
			</ul>
		</div>
		<div class="col-9"> 
			<img alt="" src="<c:url value='/images/shoppingMall_main/main2.webp'/>"  class="img-fluid"
				style="max-height: 100%; border-radius: 10px;">
		</div>
	</div>
</div>

<hr class="container p-3">

<!-- mid-2 -->

<div class="container-fluid">
	<div class="row justify-content-center">
		<div class="col-xl-8 col-lg-10 text-center" style="min-height: 400px;">
			<h2 class="display-3 mt-5 mb-3 pt-5">Start Your Fitness Journey!</h2>
			<p class="lead text-muted mb-5 pb-5">Ignite your passion for
				fitness and conquer your goals. Every drop of sweat brings you one
				step closer to the strong, confident version of yourself. Embrace
				the grind, elevate your strength, and transform your journey into a
				powerful lifestyle. Your body is a canvas—let each workout be a
				stroke of determination, crafting the masterpiece that is you. With
				every rep and every challenge, you build resilience, fortitude, and
				an unbreakable spirit. The path to greatness starts here; let’s rise
				together and push beyond our limits!</p>
		</div>
	</div>
</div>

<hr class="container p-3">

<!-- mid-3 -->

<div class="container pt-0">

	<div class="row g-4 mx-5">
		<div class="pb-2">
			<h2>Popular products</h2>
		</div>
		<c:forEach var="product" items="${ProductList}" begin="0" end="7">
			<div class="col-6 col-md-3">
				<div class="card" style="height: 300px; border: none;">
					<a
						href="<c:url value='shopDetail?productId=${product.getProduct_id()}'/>"
						class="list-group-item-action"> <img
						src="<c:url value='/images/shoppingMall_product/${product.getProduct_imagename()}'/>" 
						class="card-img-top mt-2" alt="loading"
						style="object-fit: contain; max-height: 150px; width: 100%;">
					</a>
					<div class="card-body d-flex flex-column mx-3">
						<p class="card-title fs-6">
							<a
								href="<c:url value='shopDetail?productId=${product.getProduct_id()}'/>"
								class="list-group-item-action">${product.getProduct_name()}</a>
						</p>
						<p class="card-text text-danger">₩
							${product.getProduct_price()}</p>
						<div class="mt-auto"></div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<hr class="container p-3">

<script>
	// toggle list
	$('.list-group-item-action').on('click', function() {
		var target = $(this).data('bs-target');
		$('.collapse').not(target).collapse('hide');
	});
</script>

