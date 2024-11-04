
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 조회</title>
 	<link rel="stylesheet" href="resources/css/trainerboard_css/tb.css">	
 	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/trainerboard_css/tb.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
 	<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
     <script>
        function confirmDelete(postid) {
            if (confirm("삭제하시겠습니까?")) {
                // 폼을 사용하여 삭제 요청을 전송합니다.
                var form = document.getElementById('deleteForm');
                form.action = '/app/delete?postid=' + encodeURIComponent(postid); // encodeURIComponent 추가
                form.method = 'post'; // Make sure the method is POST
                form.submit();
            }
        }
    </script>
    
</head>
<body>

<div class="container" style="margin-top:20px; ">
    <main>
        
      
         <!--   BoardDTO dto = (BoardDTO) request.getAttribute("dto");
            
          
            int postid = dto.getPostid();
            String title = dto.getTitle();
            String content = dto.getContent();
            int userid = dto.getUserid();
        -->
<br>

        <table border="1" id="retrieveForm">
            <colgroup>
                <col style="width: 10%;">
                <col style="width: 90%;">
            </colgroup>
            <tr>
                <th>글번호</th>
                <td>${dto.postid}</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>${dto.userid}</td>
            <tr>
                <th>글제목</th>
                 <td>${dto.title}</td>
            </tr>
            <tr>
                <th>글내용</th>
                 <td>${dto.content}
                 <c:if test="${not empty dto.imagename}">
                 <img src="<c:url value='/images/trainerboard_image/${dto.imagename}'/>"  alt="Image"
				class="img-fluid" style="object-fit: contain; max-height: 500px;">
				</c:if>
				</td>
            </tr>
            
        </table>
        <br>
        <div class="button">
      <button class="buttonmulti" onclick="location.href='/app/update?postid=${dto.postid}'">수정</button>&nbsp;
	<button class="buttonmulti" onclick="confirmDelete(${dto.postid})">삭제</button>&nbsp;
	<button class="buttonmulti" type="button" onclick="location.href='/app/TrainerBoard?curPage=${curPage}'">목록보기</button>
<!-- 폼안에서 button은 submit이 기본임. type으로 버튼 따로 지정해서 글 작성 도중에도 넘어가게 해줌  -->
		</div>

<div id="total-replyForm">

<div class="comment-container">
			<div class="comment-header">
				<h7>댓글 작성</h7>
			</div>
			<div class="comment-body">
				<form class="replyForm">
					<input type="hidden" name="postid" value="${dto.postid}">
					<input type="hidden" name="userid" value="${dto.userid}">
					<textarea id="comment-textarea" name="commContent"
						placeholder="댓글을 입력하세요" rows="5"></textarea>
					<button type="submit" id="submit-comment" class="hidden">댓글
						작성</button>
				</form>
			</div>
		</div>

		<div id="reply" >
			<c:forEach var="comment" items="${comments}">
				<div class="reply-container"
					style="margin-left: ${comment.tr_RepIndent * 20}px;">
					<table class="reply-table">
						<tr class="reply">
							<td class="reply-userid" colspan="2">${comment.userId}</td>
						</tr>
						<tr class="reply">
							<td class="reply-content" colspan="2">
								<span class="comment-content">${comment.commContent}</span>
		 						<!-- 수정 시 표시될 textarea와 버튼 컨테이너 -->
		                        <div class="edit-content-container" style="display:none;">
		                            <textarea class="edit-content-textarea">${comment.commContent}</textarea>
		                            <div class="edit-buttons">
		                                <button class="save-edit-button" data-id="${comment.commId}">수정</button>
		                                <button class="cancel-edit-button">취소</button>
		                            </div>
		                        </div>		                        
                       		</td>
						</tr>
						<tr class="reply">
							<td class="reply-createdate">${comment.comCrdate}</td>
							<td class="reply-button">
								<input type="button" class="edit-button" value="수정" data-id="${comment.commId}">
								<input type="button" class="delete-button" value="삭제" data-id="${comment.commId}"> 
								<input type="button" class="reply-reply-button" value="댓글" data-parentid="${comment.commId}">
							</td>
						</tr>
					</table>

					<!-- 대댓글 작성 폼 (숨겨진 상태로 시작) -->
					<div class="reply-form-container" style="display: none;">
						<form class="replyForm">
							<input type="hidden" name="postid" value="${comment.postid}">
							<input type="hidden" name="tr_ParentId" value="${comment.commId}">
							<input type="hidden" name="tr_RepIndent"
								value="${comment.tr_RepIndent + 1}">
							<input type="hidden" name="userId" value="${dto.userid}">
							
							<div class="reply-textarea-container">
					            <textarea name="commContent" placeholder="대댓글을 입력하세요" rows="3"></textarea>
					            <div class="submit-reply-button-container">
					                <button type="submit">등록</button>
					            </div>
					        </div>
							
						</form>
					</div>
				</div>
			</c:forEach>
		</div>

</div>	
<!-- 삭제 요청을 위한 숨겨진 폼 -->
<form id="deleteForm" method="post" style="display:none;"></form>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
				var curPage = ${curPage}; // JavaScript 변수로 currentPage 값 설정

				
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
					console.log($(this).serialize());
		            $.ajax({
		                type: 'POST',
		                url: '/app/writeTrainerboardComment',  // 댓글 저장할 URL
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
		            var commentId = $(this).data('id'); //96 data-id 로 data 뒤 id 만 불러오면 됨
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
		            
		            var postId = ${dto.postid};
		            console.log(postId);
		            //location.href = "/app/updateTrainerboardComment";
		           
		            $.ajax({
		                type: 'POST',
		                url: '/app/updateTrainerboardComment', // 댓글 수정 서버 URL
		                data: { commId: commentId, commContent: newContent },
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
		                    url: '/app/deleteTrainerboardComment',  // 댓글 삭제 서버 URL 슬래시 필수
		                    data: { commId: commentId },
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
	});
</script>

</body>
</html>
