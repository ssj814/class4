<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="container">
	<form action="qna_save" method="post" id="qna_write">
		<table border="1" width="90%">
			<tbody>
				<tr>
					<th>비밀글</th>
					<td><input type="checkbox" name="is_secret" id="is_secret" value="1"></td>	
				</tr>
				<tr>
					<th>카테고리</th>
					<td>
						<select id="category" name="category">
							<option value="select" disabled selected>선택하세요</option>
							<option value="member">회원</option>
							<option value="trainer">트레이너</option>
							<option value="product">상품</option>
							<option value="mealplan">식단</option>
							<option value="other">기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>질문</th>
					<td><textarea name="question" id="question"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button type="submit">작성 완료</button>
						<button type="reset">다시 입력</button>
						<button type="button" id="viewListButton">목록 보기</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		
		$("form").on("submit", function() {
			var category = $("#category");
			var question = $("#question");
			if (category.val() == null) {
				event.preventDefault();
				alert("카테고리를 선택하세요.");
				return
			}
			if (question.val() == null || question.val().length == 0) {
				event.preventDefault();
				alert("질문을 입력하세요.");
				question.focus();
			}
		});

		$("#viewListButton").on("click", function() {
			location.href = 'qna';
		});
		
	    document.getElementById('category').addEventListener('focus', function() {
	        // 선택하세요 옵션 숨기기
	        this.querySelector('option[value="select"]').style.display = 'none';
	    });

	});
</script>
