<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 내용</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#edit").on("click", function() {
			$("#btnform").attr("action", "UpdatePostUI");
		});
		$("#list").on("click", function() {
			location.href = "FitnessContest";
		});
		$("#delete").on("click", function() {
			$("#btnform").attr("action", "DeletePost");
		});
		$("#boardList_title").on("click", function() {
			location.href = "FitnessContest";
		})
		$('#submit-comment')
				.on(
						'click',
						function() {

							// 버튼의 data 속성에서 postid와 userid 값 가져오기
							var postid = $(this).data('xxx');
							var userid = $(this).data('yyy');

							// 댓글 내용 가져오기
							var comment = $('#comment-textarea').val();

							// AJAX 요청을 통해 서버로 댓글 삽입 요청
							$
									.ajax({ //댓글 ajax
										type : 'post',
										url : 'insert', // Spring Controller로 요청
										contentType : 'application/json; charset=utf-8',
										dataType : 'json',
										data : JSON.stringify({
											postid : postid,
											userid : userid,
											content : comment
										}),
										success : function(response) {
											console.log(response);
											if (response) {
												console.log("대댓글 등록 성공:",
														response);
												const commentId = response.commentId; // 응답에서 댓글 ID 가져오기
												const userId = response.userid; // 응답에서 사용자 ID 가져오기
												const createDate = response.createdate; // 응답에서 작성일 가져오기
												const content = response.content; // 응답에서 댓글 내용 가져오기

												const newReplyHtml = '<div class="reply-block" id="comment-' + commentId + '">'
														+ '<table class="reply-table">'
														+ '<tr>'
														+ '<td class="reply-userid">작성자: '
														+ userId
														+ '</td>'
														+ '<td class="reply-createdate">작성일: '
														+ createDate
														+ '&nbsp;&nbsp;|&nbsp;'
														+ '<span id="comment-upd-' + commentId + '" class="comment-upd">수정</span>&nbsp;&nbsp;|&nbsp;'
														+ '<span id="comment-del-' + commentId + '" class="comment-del">삭제</span>'
														+ '</td>'
														+ '</tr>'
														+ '<tr>'
														+ '<td id="comment-content-' + commentId + '" colspan="2" class="reply-content">'
														+ content
														+ '</td>'
														+ '</tr>'
														+ '<tr>'
														+ '<td colspan="2" class="reply-button">'
														+ '<input type="button" value="대댓글달기" class="btn">'
														+ '</td>'
														+ '</tr>'
														+ '</table>'
														+ '<div class="reply-replies"></div>'
														+ '<div class="reply-form" style="display:none; margin-left: 20px;">'
														+ '<textarea name="content" placeholder="대댓글을 입력하세요" cols="100" rows="3" required></textarea>'
														+ '<button class="submit-reply" data-xxx="' + commentId + '" data-yyy="' + userId + '" data-zzz="' + postid + '">대댓글 입력</button>'
														+ '</div>' + '</div>';

												// 댓글 추가 위치를 지정
												$('.reply-container').append(
														newReplyHtml);
												$('#comment-textarea').val('');
											} else {
												console.log("대댓글 등록 실패");
												alert("대댓글 등록에 실패했습니다.");
											}
										},
										error : function(xhr, status, error) {
											console.error("에러 발생:", error);
											alert("대댓글 등록 중 오류가 발생했습니다.");
										}
									});
						});

		// "답글달기" 버튼 클릭 시 대댓글 입력 폼 토글
		$(".reply-container").on(
				"click",
				".reply-button .btn",
				function() {

					var replyForm = $(this).closest('.reply-block').find(
							'.reply-form'); // 자식태그찾기

					// 현재 보이는 상태인지 확인 후 토글
					if (replyForm.is(":visible")) {
						replyForm.slideUp(); // 슬라이드 업 애니메이션으로 숨김
					} else {
						$(".reply-form").slideUp(); // 다른 모든 대댓글 폼 숨김
						replyForm.slideDown(); // 현재 대댓글 폼만 표시
					}
				});

		// 대댓글 입력 폼에서 "대댓글 달기" 버튼 클릭 시 처리
		$('.reply-container')
				.on(
						'click',
						'.submit-reply',
						function() {
							// 버튼에 저장된 데이터 속성에서 필요한 값들을 가져옴
							var parentCommentId = $(this).data('xxx'); // 부모 댓글의 ID
							var userId = $(this).data('yyy'); // 작성자의 ID
							var postId = $(this).data('zzz'); // 게시글의 ID
							var replyContent = $(this).closest('.reply-form')
									.find('textarea').val(); // 대댓글 내용

							// 대댓글 내용이 비어있으면 경고 메시지를 출력하고 중단
							if (replyContent.trim() === "") {
								alert("대댓글 내용을 입력해주세요.");
								return;
							}

							// AJAX 요청을 통해 서버로 대댓글 데이터 전송
							$
									.ajax({
										type : 'POST',
										url : 'ReplyInsert', // 서버에서 대댓글을 처리할 URL
										contentType : 'application/json; charset=utf-8',
										dataType : 'json',
										data : JSON.stringify({
											postid : postId,
											userId : userId,
											parentCommentId : parentCommentId,
											content : replyContent
										}),
										success : function(data) {
											console.log("서버 응답 데이터 구조 확인:",
													data); // 서버 응답 확인
											console.log(data.userId);
											console.log(data.createDate);
											console.log(data.content);

											if (data && data.replyId) {
												console.log("대댓글 등록 성공:", data);

												// 대댓글 생성

												var newReplyHtml = '<div class="reply" style="margin-left: 20px; padding: 5px; border-left: 2px solid #ddd;" id="reply-' + data.replyId + '">'
														+ '<p>작성자: '
														+ data.userId
														+ ' &nbsp;&nbsp;|&nbsp;&nbsp; 작성일: '
														+ data.createDate
														+ ' &nbsp;&nbsp;|&nbsp;&nbsp;'
														+ '<u class="reply-upd">수정</u>&nbsp;&nbsp;|&nbsp;&nbsp;'
														+ '<u class="reply-del" data-reply-user="' + data.userId + '" data-reply-postid="' + data.postid + '" data-reply-replyId="' + data.replyId + '" data-reply-id="' + data.parentCommentId + '">삭제</u>'
														+ '</p>'
														+ '<p class="reply-content">'
														+ data.content
														+ '</p>'
														+ '<button class="reply-save" data-reply-id="' + data.replyId + '"'
													    + ' data-reply-user="' + data.userId + '"'
													    + ' data-reply-postid="' + data.postid + '" style="display: none;">저장</button>' // 버튼 추가
														+ '</div>';

												// 댓글이 추가되는 위치 확인
												var parentReplyContainer = $(
														'#comment-'
																+ data.parentCommentId)
														.find('.reply-replies');
												console.log("새로 추가된 댓글 구조:", $(
														'#reply-'
																+ data.replyId)
														.html());
												if (parentReplyContainer.length) {
													parentReplyContainer
															.append(newReplyHtml); // 새 댓글을 DOM에 추가
													console
															.log(
																	"댓글이 추가되었습니다:",
																	$(
																			'#reply-'
																					+ data.replyId)
																			.html()); // 추가된 댓글 출력
													console
															.log(
																	"부모 댓글 ID:",
																	data.parentCommentId);
													console
															.log(
																	"부모 댓글 선택자:",
																	$('#comment-'
																			+ data.parentCommentId));
												} else {
													console
															.error(
																	"부모 댓글의 reply-replies 컨테이너를 찾을 수 없습니다: ",
																	data.parentCommentId);
												}

												// 대댓글 입력창 숨기기 및 초기화
												var replyForm = $(
														'.submit-reply[data-xxx="'
																+ data.parentCommentId
																+ '"]')
														.closest('.reply-form');
												replyForm.slideUp(); // 입력창 숨기기
												replyForm.find('textarea').val(
														''); // 입력창 초기화

												alert('대댓글이 성공적으로 등록되었습니다.');
											} else {
												alert('대댓글 등록에 실패했습니다.');
											}
										},
										error : function(xhr, status, error) {
											console.error("에러 발생:", error);
											alert("대댓글 등록 중 오류가 발생했습니다.");
										}
									});
						});

		// 수정 버튼 클릭 시 텍스트 필드를 입력 폼으로 변환
		$(".reply-container")
				.on(
						"click",
						".reply-upd",
						function() {
							console.log("수정 버튼 클릭됨"); // 클릭 시 콘솔 로그 출력
							var replyDiv = $(this).closest(".reply");
							var contentP = replyDiv.find(".reply-content"); // 댓글 내용을 찾음
							console.log(contentP);
							var replyContent = contentP.text().trim(); // 댓글 내용 추출

							// 댓글을 텍스트 입력 필드로 변환
							contentP
									.replaceWith('<textarea class="edit-reply-content">'
											+ replyContent + '</textarea>');

							// 이미 존재하는 "저장" 버튼을 표시
							replyDiv.find(".reply-save").show();

						});

		// 저장 버튼 클릭 시 Ajax로 서버에 데이터 전송
		$(".reply-container").on(
				"click",
				".reply-save",
				function() {
					var replyDiv = $(this).closest(".reply");
					var textarea = replyDiv.find(".edit-reply-content");
					var Content = textarea.val();
					var postid = $(this).attr("data-reply-postid");
					var replyId = $(this).attr("data-reply-replyId");

					// 저장 버튼을 숨김
					$(this).hide();

					// 데이터 전송에 필요한 정보
					var CommentId = $(this).data('reply-id');
					var userId = $(this).data('reply-user');

					// Ajax로 서버에 데이터 전송
					$.ajax({
						type : "POST", // GET 대신 POST로 변경 (보통 업데이트는 POST 사용)
						url : "Replyupdate", // 서버에서 업데이트 처리하는 URL
						data : {
							replyId : replyId,
							userId : userId,
							Content : Content,
							postid : postid,
							parentCommentId : CommentId
						},
						success : function(response) {
							// 서버 응답 처리
							var updatedContent = response.updatedContent
									|| Content; // 서버에서 반환된 데이터가 있으면 사용, 없으면 수정된 데이터 사용

							// 입력 필드를 다시 텍스트 필드로 변환
							textarea.replaceWith('<p class="reply-content">' + updatedContent + '</p>');


							console.log("Reply updated successfully.");
						},
						error : function(xhr, status, error) {
							console.error("Error updating reply:", error);
						}
					});
				});

		$('.reply-container')
				.on(
						'click',
						'.comment-upd',
						function() {
							var commentId = $(this).attr('id').split('-')[2]; // commentId 추출
							console.log("클릭: commentId = " + commentId); // 디버깅용 로그

							// 현재 댓글 내용을 입력 폼으로 변경
							var contentTd = $('#comment-content-' + commentId);
							console.log("contentTd: ", contentTd); // 디버깅용 로그
							if (contentTd.find('input').length > 0) {
								return; // 이미 수정 모드면 더 이상 실행하지 않음
							}
							var originalContent = contentTd.text().trim(); // 기존 댓글 내용 저장
							console.log("originalContent: ", originalContent); // 디버깅용 로그

							contentTd
									.html('<input type="text" id="edit-content-' + commentId + '" value="' + originalContent + '" class="hidden-input" />'
											+ '<button id="save-comment-' + commentId + '">저장</button>'
											+ '<button id="cancel-comment-' + commentId + '">취소</button>');

							console.log("폼이 변경되었습니다."); // 폼이 변경된 후 로그 출력

							// 저장 버튼 클릭 시 Ajax로 수정 요청
							$('#save-comment-' + commentId).click(
									function() {
										var newContent = $(
												'#edit-content-' + commentId)
												.val();

										$.ajax({
											type : 'get',
											url : 'CommentUpdate', // 서버 업데이트 URL
											data : {
												commentId : commentId,
												content : newContent
											},
											success : function(response) {
												// 서버 응답 성공 시 화면에 수정된 내용 반영
												contentTd.html(newContent);
											},
											error : function() {
												alert('댓글 수정에 실패했습니다.');
											}
										});
									});

							// 취소 버튼 클릭 시 원래 내용으로 복구
							$('#cancel-comment-' + commentId).click(function() {
								contentTd.html(originalContent);
							});
						});
		$('.reply-container').on('click', '.comment-del', function() {
			var commentId = $(this).attr('id').split('-')[2]; // commentId 추출
			var confirmDelete = confirm('정말로 이 댓글을 삭제하시겠습니까?'); // 삭제 확인 창

			if (confirmDelete) {
				$.ajax({
					type : 'GET',
					url : 'DeleteComment', // 서버의 댓글 삭제 처리 URL
					data : {
						commentId : commentId,
						content : "삭제된 글입니다" // 댓글을 "삭제된 글입니다"로 업데이트
					},
					success : function(response) {
						if (response === 'success') {
							// 원댓글의 내용, 작성자, 수정/삭제 버튼만 변경하고 대댓글은 유지
							var commentBlock = $('#comment-' + commentId);
							// 원댓글과 대댓글 모두 삭제
							commentBlock.remove();

							console.log('댓글이 성공적으로 삭제되었습니다.');
						} else {
							alert('댓글 삭제에 실패했습니다.');
						}
					},
					error : function() {
						alert('댓글 삭제 요청 중 오류가 발생했습니다.');
					}
				});
			}
		});

		$(".reply-container").on("click", ".relply-del", function() {
			var userId = $(this).data('reply-user');
			var postid = $(this).attr("data-reply-postid");
			var replyId = $(this).attr("data-reply-replyId");
			var parentCommentId = $(this).attr("data-reply-id");

			var confirmDelete = confirm('정말로 이 댓글을 삭제하시겠습니까?'); // 삭제 확인 창

			if (confirmDelete) {
				$.ajax({
					type : 'get',
					url : 'ReplyDelete', // 서버의 댓글 삭제 URL
					data : {
						userId : userId,
						postid : postid,
						replyId : replyId,
						parentCommentId : parentCommentId
					},
					success : function(response) {
						if (response === 'success') {
							// DOM에서 해당 댓글 삭제
							$('#reply-' + replyId).remove();
							console.log('댓글이 성공적으로 삭제되었습니다.');
						} else {
							alert('댓글 삭제에 실패했습니다.');
						}
					},
					error : function() {
						alert('댓글 삭제 요청 중 오류가 발생했습니다.');
					}
				});
			}
		});
	});
</script>
<link href="resources/css/contest/content.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="boardList">
		<div id="boardList_title">운동대회</div>

		<div id="boardArticle">
			<table class="boardHeader">
				<tr>
					<th>제목</th>
					<td colspan="3">${content.title }</td>
					<th>작성자</th>
					<td>${content.writer }</td>
				</tr>
				<tr>
					<th>글번호</th>
					<td>${content.postid }</td>
					<th>등록일</th>
					<td>${content.createdate}</td>
					<th>조회수</th>
					<td>${content.viewcount}</td>
				</tr>
			</table>

			<div id="boardArticle_content">
				<p>${content.content}</p>
			</div>

			<div id="boardArticle_footer">
				<form id="btnform" method="get">
					<input type="hidden" name="postid" value="${content.postid}">
					<input type="hidden" name="title" value="${content.title}">
					<input type="hidden" name="content" value="${content.content}">
					<input type="submit" value="수정" class="btn" id="edit"> <input
						type="submit" value="삭제" class="btn" id="delete">
				</form>
				<input type="button" value="목록" id="list" class="btn">
			</div>
		</div>

		<div class="comment-container">
			<h3 class="comment-header">댓글</h3>
			<hr>
			<div class="comment-body">
				<textarea id="comment-textarea" name="commentinsert" required></textarea>
				<button type="button" id="submit-comment"
					data-xxx="${content.postid}" data-yyy="${sessionScope.userid}">입력</button>
			</div>

		</div>

		<div class="reply-container">
			<c:forEach var="comment" items="${comments}">
				<div class="reply-block" id="comment-${comment.commentId}">
					<table class="reply-table">
						<tr>
							<td class="reply-userid">작성자: <c:out
									value="${comment.userid}" /></td>
							<td class="reply-createdate">작성일: <c:out
									value="${comment.createdate}" />&nbsp;&nbsp;|&nbsp; <span
								id="comment-upd-${comment.commentId}" class="comment-upd">수정</span>&nbsp;&nbsp;|&nbsp;
								<span id="comment-del-${comment.commentId}" class="comment-del">삭제</span>
						</tr>
						<tr>
							<td id="comment-content-${comment.commentId}" colspan="2"
								class="reply-content"><c:out value="${comment.content}" /></td>
						</tr>
						<tr>
							<td colspan="2" class="reply-button"><input type="button"
								value="대댓글달기" class="btn"></td>
						</tr>
					</table>

					<!-- 대댓글 리스트를 담을 컨테이너 -->
					<div class="reply-replies">
						<!-- 여기에 대댓글이 추가될 예정 -->
						<c:forEach var="reply" items="${replys}">
							<c:if test="${reply.parentCommentId == comment.commentId}">
								<div class="reply"
									style="margin-left: 20px; padding: 5px; border-left: 2px solid #ddd;"
									id="reply-${reply.replyId}">
									<p>
										작성자:
										<c:out value="${reply.userId}" />
										&nbsp;&nbsp;|&nbsp;&nbsp; 작성일:
										<c:out value="${reply.createDate}" />
										&nbsp;&nbsp;|&nbsp;&nbsp; <u class="reply-upd">수정</u>&nbsp;&nbsp;|&nbsp;&nbsp;
										<u class="relply-del" data-reply-user="${reply.userId}"
											data-reply-postid="${content.postid}"
											data-reply-replyId="${reply.replyId}"
											data-reply-id="${reply.parentCommentId}">삭제</u>
									</p>
									<p class="reply-content" id="reply-content-${reply.replyId}">
										<c:out value="${reply.content}" />
									</p>
									<button class="reply-save" data-reply-id="${reply.replyId}"
										data-reply-user="${reply.userId}"
										data-reply-postid="${content.postid}" style="display: none;">저장
									</button>
								</div>
							</c:if>
						</c:forEach>
					</div>

					<!-- 대댓글 입력 폼 -->
					<div class="reply-form" style="display: none; margin-left: 20px;">
						<textarea id="reply-text" name="content" placeholder="대댓글을 입력하세요"
							cols="100" rows="3" required></textarea>
						<button class="submit-reply" data-xxx="${comment.commentId}"
							data-yyy="${sessionScope.userid}" data-zzz="${content.postid}">대댓글
							입력</button>
					</div>
				</div>
				<hr>
			</c:forEach>
		</div>
</body>
</html>