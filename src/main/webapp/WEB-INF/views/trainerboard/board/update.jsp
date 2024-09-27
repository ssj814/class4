
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/trainerboard_css/tb.css">
</head>
<body>
<div class="container" style="margin-top:40px;">
        <main>
		   <form action="${pageContext.request.contextPath}/update" method="post" id="updateForm">
		    	<input type="hidden" name="postid" value="${dto.postid}">
		    	<label for="title">글제목</label><br>
		    	<input type="text" id="title" name="title"  maxlength="50" required value="${dto.title}"><br>
		    	<label for="content">내용</label><br>
		    	<textarea id="content" name="content"  maxlength="1000" required>${dto.content}</textarea><br>
		    	<hr>
		    	<button type="submit">수정완료</button>
		    	<a class="buttonmulti" href="${pageContext.request.contextPath}/TrainerBoard">목록보기</a>
			</form>

        </main>
       </div>
        
</body>
</html>