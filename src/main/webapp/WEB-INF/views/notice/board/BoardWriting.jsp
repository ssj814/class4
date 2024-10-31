<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="container">
	<form action="notice_save" method="post">
		<input type="hidden" name="postid" value="${post.postid}">
		<table border="1" width="90%">
			<tbody>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" id="title"
						style="width: 90%;"
						value="${post.title != null ? post.title : ''}"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="content" id="content"
							style="width: 90%; height: 100px;">${post.content != null ? post.content : ''}</textarea>
					</td>
				</tr>
				<tr>
					<td id="pop-up">
                        팝업 표시<input type="checkbox" name="popup" id="popup" value="Y" style="width: 90%;">
                    </td>
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("form").on("submit", function() {
			var title = $("#title");
			var content = $("#content");
			if (title.val() == null || title.val().length == 0) {
				alert("제목을 입력하세요.");
				title.focus();
				event.preventDefault();
			}
			if (content.val() == null || content.val().length == 0) {
				alert("내용을 입력하세요.");
				content.focus();
				event.preventDefault();
			}
		});

		$("#viewListButton").on("click", function() {
			location.href = 'notice';
		});

	});
</script>
