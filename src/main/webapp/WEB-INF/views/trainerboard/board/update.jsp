
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
		    	<div class="label">
		    	<label for="title">글제목</label></div>
		    	<input type="text" id="title" name="title"  maxlength="50" required value="${dto.title}"><br><br>
		    	<div class="label">
		    	<label for="content">내용</label></div>
		    	<textarea id="content" name="content"  maxlength="1000" required>${dto.content}</textarea><br>
			</form>		   
	
		    <div class="button">
		    	<button class="buttonmulti" onclick="location.href='${pageContext.request.contextPath}/TrainerBoard/retrieve/${dto.postid}'">수정완료</button>
		    	<button class="buttonmulti" onclick="location.href='${pageContext.request.contextPath}/TrainerBoard'">목록보기</button>

			</div>
	
        </main>
       </div>
        
</body>
</html>