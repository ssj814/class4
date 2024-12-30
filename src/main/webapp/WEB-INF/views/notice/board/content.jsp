<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container">
	<div id="boardList">
		<div id="boardList_title">[ 공 지 사 항 ]</div>
		<div id="boardArticle">
			<table class="boardHeader">
				<tr>
					<th>제목</th>
					<td colspan="3">${BoardOne.title}</td>
					<th>작성자</th>
					<td>${BoardOne.writer}</td>
				</tr>
				<tr>
					<th>글번호</th>
					<td>${BoardOne.postId}</td>
					<th>등록일</th>
					<td>${BoardOne.createdAt}</td>
					<th>조회수</th>
					<td>${BoardOne.viewCount}</td>
				</tr>
			</table>
			<div id="boardArticle_content">
				<table border="0">
					<tr>
						<td>${BoardOne.content}
							<c:if test="${not empty BoardOne.imageName}">
				                 <img src="<c:url value='/images/notice/${BoardOne.imageName}'/>"  alt="Image"
								class="img-fluid" style="object-fit: contain; max-height: 200px;">
							</c:if>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<div id="reply">
			<c:forEach var="comment" items="${comments}">
				<div class="reply-container"
					style="margin-left: ${comment.repIndent * 20}px;">
					<table class="reply-table">
						<tr class="reply">
							<td class="reply-userid" colspan="2">
								<span>${comment.userid} | </span>
								<span><button class="btn" data-id="${comment.id}">신고</button></span>
							</td>
						</tr>
						<tr class="reply">
							<td class="reply-content" colspan="2">
								<span class="comment-content">${comment.content}</span>
		 						<!-- 수정 시 표시될 textarea와 버튼 컨테이너 -->
		                        <div class="edit-content-container" style="display:none;">
		                            <textarea class="edit-content-textarea">${comment.content}</textarea>
		                            <div class="edit-buttons">
		                                <button class="save-edit-button" data-id="${comment.id}">수정</button>
		                                <button class="cancel-edit-button">취소</button>
		                            </div>
		                        </div>		                        
                       		</td>
						</tr>
						<tr class="reply">
							<td class="reply-createdate">${comment.createdate}</td>
							<td class="reply-button">
							<c:if test="${fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN') 
            					or (comment.userid eq sessionScope.SPRING_SECURITY_CONTEXT.authentication.name) }">
								<input type="button" class="edit-button" value="수정" data-id="${comment.id}">
								<input type="button" class="delete-button" value="삭제" data-id="${comment.id}"> 
							</c:if>
								<c:if test="${!empty sessionScope.SPRING_SECURITY_CONTEXT.authentication }">
									<input type="button" class="reply-reply-button" value="답글" data-parentid="${comment.id}">
								</c:if>
							</td>
						</tr>
					</table>

					<!-- 대댓글 작성 폼 (숨겨진 상태로 시작) -->
					<div class="reply-form-container" style="display: none;">
						<form class="replyForm">
							<input type="hidden" name="postId" value="${comment.postId}">
							<input type="hidden" name="parentId" value="${comment.id}">
							<input type="hidden" name="repIndent"
								value="${comment.repIndent + 1}">
							<input type="hidden" name="userid" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.name}">
							
							<div class="reply-textarea-container">
					            <textarea name="content" placeholder="대댓글을 입력하세요" rows="3"></textarea>
					            <div class="submit-reply-button-container">
					                <button type="submit">댓글 작성</button>
					            </div>
					        </div>
							
						</form>
					</div>
				</div>
			</c:forEach>
		</div>


		<div class="comment-container">
			<div class="comment-header">
				<h3>댓글 작성</h3>
			</div>
			<div class="comment-body">
				<form class="replyForm">
					<input type="hidden" name="postid" value="${BoardOne.postId}">
					<input type="hidden" name="userid" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.name}">
					<textarea id="comment-textarea" name="content"
						placeholder="댓글을 입력하세요" rows="5"></textarea>
					<c:if test="${!empty sessionScope.SPRING_SECURITY_CONTEXT.authentication }">
						<button type="submit" id="submit-comment" class="hidden">댓글 작성</button>
					</c:if>
				</form>
			</div>
		</div>

		<div id="boardArticle_footer">
			<div>
				<c:if test="${fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN')}">
					<input type="button" value=" 수정 " id="BoardUpdate" /> 
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
				var currentPage = ${currentPage}; // JavaScript 변수로 currentPage 값 설정

				$("#viewList").on("click", function() {
					location.href = '/app/notice?currentPage=' + currentPage;
				});

				$("#BoardUpdate").on("click", function() {
					location.href = 'admin/notice_update?postid=' + ${BoardOne.postId} + '&currentPage=' + currentPage;
				});

				$("#BoardDelete").on("click", function() {
					var confirmed = confirm("정말로 삭제하겠습니까?");
					if (confirmed) {
						location.href = 'admin/notice_delete?postid=' + ${BoardOne.postId} + '&currentPage=' + currentPage;
					}
				});
				
				// 댓글 작성 폼의 textarea에 포커스
			    $('#comment-textarea').on('focus', function() {
			        // 모든 대댓글 작성 폼 숨기기
			        $('.reply-form-container').hide();
			    });
				// 대댓글 작성 폼 토글
		        $(document).on('click', '.reply-reply-button', function() {
		            $('.reply-form-container').hide(); // 모든 대댓글 작성 폼 숨기기
		            $(this).closest('.reply-container').find('.reply-form-container').toggle();
		        });

		        // 댓글 및 대댓글 작성 폼 제출 처리
		        $(document).on('submit', '.replyForm', function(event) {
		            event.preventDefault();
					
		            $.ajax({
		                type: 'POST',
		                url: 'saveComment',  // 댓글 저장할 URL
		                data: $(this).serialize(),  // 폼 데이터를 직렬화하여 전송
		                success: function(response) {
		                    location.reload();  // 성공 시 페이지 새로고침
		                },
		                error: function() {
		                    alert('댓글 저장 중 오류가 발생했습니다.');
		                }
		            });
		        });
		        
		        // 댓글 수정 버튼 클릭
		        $(document).on('click', '.edit-button', function() {
		            var commentId = $(this).data('id');
		            var parentContainer = $(this).closest('.reply-container');
		            
		            // 기존 댓글 내용은 숨기고, textarea와 저장/취소 버튼을 표시
		            parentContainer.find('.comment-content').hide();
		            parentContainer.find('.edit-content-container').show();
		            $(this).hide();  // 수정 버튼 숨김
		        });

		        // 수정 취소 버튼 클릭
		        $(document).on('click', '.cancel-edit-button', function() {
		            var parentContainer = $(this).closest('.reply-container');
		            
		            // textarea와 버튼 숨기고, 기존 댓글 내용 다시 표시
		            parentContainer.find('.edit-content-container').hide();
		            parentContainer.find('.comment-content').show();
		            parentContainer.find('.edit-button').show();  // 수정 버튼 다시 표시
		        });
		        
		        // 댓글 수정 완료
		        $(document).on('click', '.save-edit-button', function() {
		            var commentId = $(this).data('id');
		            var parentContainer = $(this).closest('.reply-container');
		            var newContent = parentContainer.find('.edit-content-textarea').val();  // 수정된 내용
		            
		            $.ajax({
		                type: 'POST',
		                url: 'editComment',  // 댓글 수정 서버 URL
		                data: { id: commentId, content: newContent },
		                success: function(response) {
		                    location.reload();  // 페이지 새로고침
		                },
		                error: function() {
		                    alert('댓글 수정 중 오류가 발생했습니다.');
		                }
		            });
		        });		   
		        
		        // 댓글 삭제 버튼 클릭
		        $(document).on('click', '.delete-button', function() {
		            var commentId = $(this).data('id');
		            var confirmed = confirm("댓글을 삭제하시겠습니까?");
		            
		            if (confirmed) {
		                $.ajax({
		                    type: 'POST',
		                    url: 'deleteComment',  // 댓글 삭제 서버 URL
		                    data: { id: commentId },
		                    success: function(response) {
		                        location.reload();  // 페이지 새로고침
		                    },
		                    error: function() {
		                        alert('댓글 삭제 중 오류가 발생했습니다.');
		                    }
		                });
		            }
		        });
			});

		document.addEventListener('DOMContentLoaded', function() {
			var textarea = document.getElementById('comment-textarea');
			var submitButton = document.getElementById('submit-comment');
	
			textarea.addEventListener('focus', function() {
				submitButton.classList.remove('hidden'); // 버튼을 표시
			});
	
			textarea.addEventListener('blur', function() {
				if (!textarea.value.trim()) {
					submitButton.classList.add('hidden'); // 버튼을 숨김
				}
			});
			
			const commnetReportButtons = document.querySelectorAll(".btn");

		    commnetReportButtons.forEach((button) => {
		        button.addEventListener("click", function () {
		        	
		            let url = `${pageContext.request.contextPath}/user/reportWrite?targetType=COMMENT&category=NOTICE`;
		            if(button.dataset.id){
						url += '&id=' + button.dataset.id;
		            }
		            console.log(url);
		            location.href = url;
		        });
		    });
		});
</script>
