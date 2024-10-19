<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    

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


		   <form action="${pageContext.request.contextPath}/update" method="post" id="updateForm" enctype="multipart/form-data">
		    	<input type="hidden" name="postid" value="${dto.postid}">
		    	<div class="label">
		    	<label for="title">글제목</label></div>
		    	<input type="text" id="title" name="title"  maxlength="50" required value="${dto.title}"><br><br>
		    	<div class="label">
		    	<label for="content">내용</label></div>
		    	<textarea id="content" name="content"  maxlength="1000" required>${dto.content}</textarea><br>
			   
			    <!-- 첨부된 파일 이름 표시 -->
                <div class="label">
                    <label>첨부된 파일명:</label>
                    <span>${dto.imagename != null ? dto.imagename : "첨부된 파일이 없습니다."}</span>
                </div>
                <br>
                   <!-- 현재 이미지 미리보기 -->
                <div class="label">
                    <label>첨부된 이미지:</label>
               
                 <img src="<c:url value='/images/trainerboard_image/${dto.imagename}'/>"  alt="Image"
				class="img-fluid" style="object-fit: contain; max-height: 100px; max-weight:100px; ">
				
                </div>
                
			   <br>
			   <!-- 파일추가 -->
			   <div class="label">
			   <label for="file"></label>
				<input type="file" id="weightImage" name="weightImage" accept="image/*"  required><%-- ${dto.weightimage } --%>
				</div>


		    <div class="button">
		    	<button class="buttonmulti">수정완료</button>
		    	<button class="buttonmulti" type="button" onclick="location.href='${pageContext.request.contextPath}/TrainerBoard'">목록보기</button>

			</div>
	</form>		
        </main>
       </div>


</body>
</html>