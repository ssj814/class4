<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        
           <form action="${pageContext.request.contextPath}/write"  method="post" id="writeForm" enctype="multipart/form-data">
                <!-- 글제목 입력란 -->
                <div class="label">
                <label for="title">글제목</label></div>
    			<input type="text" id="title" name="title" placeholder="글제목" maxlength="50" required /><br><br>


                <!-- 내용 입력란 -->
                 <div class="label">
                <label for="content">내용</label></div>
                <textarea id="content" name="content" placeholder="내용을 적어주세요" maxlength="1000" required></textarea><br>
				<label for="file"></label>
				<input type="file" id="weightImage" name="weightImage" accept="image/*">
				

                <!-- 저장 버튼과 목록 보기 링크 -->
                <div class="writebutton">
                	<button class="buttonmulti" type="submit">저장</button>&nbsp;
                	<button class="buttonmulti"  onclick="location.href='${pageContext.request.contextPath}/TrainerBoard'">목록 보기</button>	
		</div>
          </form>
        </main>
    </div>
<script>
	

 
</script>
</body>
</html>
