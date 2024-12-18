<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="container">
	<div id="boardList">
		<div id="boardList_title">[ Q & A ]</div>
		<div id="boardArticle">
			<table class="boardHeader">
				<tr>
					<th>카테고리</th>
					<td>${BoardOne.category}</td>
					<th>작성자</th>
					<td>${BoardOne.questioner}</td>
					<th>등록일</th>
					<td>${BoardOne.faq_qna_date}</td>
					<th>답변여부</th>
					<td><c:choose>
							<c:when test="${BoardOne.answer != null}">
								<strong>답변완료</strong>
							</c:when>
							<c:otherwise>
					        	답변대기
				    		</c:otherwise>
						</c:choose></td>
				</tr>
			</table>
			<div id="boardArticle_content">
				<table border="0">
					<tr>
						<td>${BoardOne.question}</td>
					</tr>
				</table>
			</div>
		</div>

		<div id="answer">
			<c:if test="${BoardOne.answer != null}">
				<div class="comment-container view">
					<div class="comment-header">
						<h4>답변</h4>
					</div>
					<div class="comment-body">
						<textarea id="comment-textarea" rows="5" readonly>${BoardOne.answer}</textarea>
						<!-- 수정 버튼 -->
						<c:if
							test="${fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN')}">
							<button type="button" id="edit-answer">수정</button>
						</c:if>
					</div>
				</div>

				<div class="comment-container edit hidden">
					<div class="comment-header">
						<h4>답변 수정</h4>
					</div>
					<div class="comment-body">
						<form class="answerForm">
							<input type="hidden" id="faq_qna_id" name="faq_qna_id"
								value="${BoardOne.faq_qna_id}">
							<textarea id="comment-textarea" name="answer"
								placeholder="답변을 입력하세요." rows="5">${BoardOne.answer}</textarea>
							<button type="submit" id="submit-comment">수정</button>
						</form>
					</div>
				</div>
			</c:if>
			<c:if
				test="${BoardOne.answer == null and fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN')}">
				<div class="comment-container">
					<div class="comment-header">
						<h4>답변 작성</h4>
					</div>
					<div class="comment-body">
						<form class="answerForm">
							<input type="hidden" id="faq_qna_id" name="faq_qna_id"
								value="${BoardOne.faq_qna_id}">
							<textarea id="comment-textarea" name="answer"
								placeholder="답변을 입력하세요." rows="5"></textarea>
							<button type="submit" id="submit-comment">등록</button>
						</form>
					</div>
				</div>
			</c:if>
		</div>

		<div id="boardArticle_footer">
			<div>
				<c:if
					test="${fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN')}">
					<input type="button" value=" 삭제 " id="BoardDelete" />
				</c:if>
			</div>
			<div>
				<input type="button" value=" 목록 " id="viewList" />
			</div>
		</div>
	</div>
</div>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

		//답변 수정 폼 보이기
		$("#edit-answer").on("click", function() {
			$(".view").addClass("hidden");
			$(".edit").removeClass("hidden");
		});

		// 답변 등록
		$(".answerForm").on("submit", function(event) {
			event.preventDefault();
			$.ajax({
				type : "PATCH",
				url : "qna_save",
				data : $(this).serialize(),
				success : function(resData, status, xhr) {
					location.reload();
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			});
		});

	});
</script>
