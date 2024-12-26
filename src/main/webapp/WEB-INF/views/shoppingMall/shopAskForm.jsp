<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
	
		<style>
		
			.ask-header {
				padding: 10px;
				margin-top: 20px;
			}
			
			.ask-container {
				width: 100%;
				border-top: 2px solid gray;
				border-bottom: 2px solid lightgray;
				margin: 10px 0;
				font-size: 12px;
			}
			
			#ask-content {
				resize: none;
			}
			
			.ask-row {
				border-bottom: 1px solid lightgray;
			}
			
			.ask-row th {
				border-right: 1px solid lightgray;
			}

			.ask-row th,td {
				padding: 12px 8px;
			}
			
			.ask-content-label {
				vertical-align: top;
			}
			
			.btn-container {
				text-align: center;
			}
				
		</style>


<div class="container">
	<form action="/app/shop_productAsk" method="post">

		<input type="hidden" name="product_id" value="${productId}">
		
		<div class="ask-header container">
			<h3>문의하기</h3>
		</div>
		<div class="container">
			<table class="ask-container">
				<tr class="ask-row">
					<th>상품명</th>
					<td>~~~</td>
				</tr>
				<tr class="ask-row">
					<th>작성자</th>
					<td>~~~</td>
				</tr>
				<tr class="ask-row">
					<th class="ask-content-label">문의내용</th>
					<td><textarea name="question" class="form-control"
					id="ask-content" rows="7" required></textarea></td>
				</tr>
			</table>
		</div>
		<div class="btn-container">
			<button type="submit" class="btn btn-dark" id="insert-productReview">문의하기</button>
			<button type="button" class="btn btn-dark" onClick="window.close()">취소하기</button>
		</div>
	</form>
</div>

<script>

	$(function() {

		//자식창 닫기
		var closeWindow = '${closeWindow}';
		if (closeWindow) {
			window.opener.location.reload();
			window.close();
		}	

	})
	
</script>