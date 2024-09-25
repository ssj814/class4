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
    <div class="container">
        <main>
        
           <form action="${pageContext.request.contextPath}/write"  method="post" id="writeForm">
                <!-- 글제목 입력란 -->
                <label for="title">글제목</label><br>
    			<input type="text" id="title" name="title" placeholder="글제목" maxlength="50" required /><br>


                <!-- 내용 입력란 -->
                <label for="content">내용</label><br>
                <textarea id="content" name="content" placeholder="내용을 적어주세요" maxlength="1000" required></textarea><br>


                <!-- 저장 버튼과 목록 보기 링크 -->
                <button type="submit">저장</button>&nbsp;
                <a class="buttonmulti" href="${pageContext.request.contextPath}/TrainerBoard">목록 보기</a>
            </form>
        </main>
    </div>

</body>
</html>