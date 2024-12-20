<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

    <!-- Summernote CSS -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <!-- Summernote JS -->
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    <!-- Summernote 한국어 설정 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
    <!-- 모듈화된 Summernote 설정 파일 포함 -->
    <script src="../resources/js/summernote.js"></script>
    

<div class="container">
	<form action="notice_save" method="post" id="notice_write">
		<input type="hidden" name="postid" value="${post.postId}">
		<table border="1" width="90%">
			<tbody>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" id="title"
						value="${post.title != null ? post.title : ''}"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="content" class="summernote" id="content">${post.content != null ? post.content : ''}</textarea>
					</td>
				</tr>
				<tr>
					<td id="pop-up">
	                	팝업<input type="checkbox" name="popup" id="popup" value="Y">
                    </td>
					<td colspan="2" align="center">
						<button type="submit" class="notice_write">작성 완료</button>
						<button type="reset" class="notice_write">다시 입력</button>
						<button type="button" id="viewListButton" class="notice_write">목록 보기</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

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
			location.href = '/app/notice';
		});

	});
</script>
