
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 조회</title>
 	<link rel="stylesheet" href="../../resources/css/trainerboard_css/tb.css"> <!-- 수정 -->
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

<div class="container" style="margin-top:40px;">
    <main>
        
      
         <!--   BoardDTO dto = (BoardDTO) request.getAttribute("dto");
            
          
            int postid = dto.getPostid();
            String title = dto.getTitle();
            String content = dto.getContent();
            int userid = dto.getUserid();
        -->

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
                 <td>${dto.content}</td>
            </tr>
            
        </table>
        <br>
        <a class="buttonmulti" href="/app/update?postid=${dto.postid}&title=${dto.title}&content=${dto.content}">수정</a> &nbsp;
        <a class="buttonmulti" href="javascript:confirmDelete(${dto.postid})">삭제</a>&nbsp;
        <a class="buttonmulti" href="/app/TrainerBoard?curPage=${curPage}">목록보기</a>
        <hr>

        <div class="comments">
            <h4>댓글</h4>
            <form action="${pageContext.request.contextPath}/commentwrite" method="post">
                <input type="hidden" id="postid" name="postid" value="${dto.postid}">
                 <input type="hidden" id="userid" name="userid" value="${dto.userid}">
                <div id="commentbox">
                   <textarea name="commentbox" class="commentbox" cols="220" rows="5" required></textarea>
                    <button type="submit" id="commentbutton">등록</button>
                   
                </div>
            </form>
            <hr>
          <div class="comment-item">
               
 <c:if test="${not empty comments}">
        <c:forEach var="comment" items="${comments}">
            <div class="comment-item">
                <div class="comment">
                    <p><strong>작성자:</strong> ${comment.userid} | <strong>작성일:</strong> ${comment.comcrdate}</p>
                    <p>${comment.commcontent}</p>
                </div>
                <hr>
            </div>
        </c:forEach>
    </c:if>
    <!-- 댓글이 없는 경우 -->
    <c:if test="${empty comments}">
        <p>댓글이 없습니다.</p>
    </c:if>
            </div>
        </div>
    </main>


</div>

<!-- 삭제 요청을 위한 숨겨진 폼 -->
<form id="deleteForm" method="post" style="display:none;"></form>

</body>
</html>
