<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Summernote CSS -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    
    <!-- Summernote JS -->
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

    <!-- Summernote 한국어 설정 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>

    <!-- 모듈화된 Summernote 설정 파일 포함 -->
    <script src="resources/js/summernote.js"></script>
    
    <link rel="stylesheet" href="resources/css/trainerboard_css/tb.css">

</head>
<body>
    <div class="container" style="margin-top:40px;">
        <main>
            <form action="${pageContext.request.contextPath}/write" method="post" id="writeForm" enctype="multipart/form-data">
                <!-- 글제목 입력란 -->
                <div class="label">
                    <label for="title">제목</label>
                </div>
                <input type="text" id="title" name="title" placeholder="글제목" maxlength="50" required /><br><br>

                <!-- 내용 입력란 -->
                <div class="label">
                    <label for="content">내용</label>
                </div>
              <textarea class="summernote form-control" id="content" name="content">${dto.content}</textarea> 
              <!--   <textarea id="content" name="content" placeholder="내용을 적어주세요" maxlength="1000" required></textarea><br>  -->
                
                <!-- 이미지 첨부 -->
                <div class="label">
                    <label for="weightImage">이미지첨부</label>
                	<input type="file" id="weightImage" name="weightImage" accept="image/*"  onchange="showPreview(this, 'preview')" />
        			<img id="preview" class="image-preview" style="display: none;  width:100px; height:100px;" />
        			

                <!-- required 없이 저장가능하게  하고싶으나 sql 오류발생 / 부적합한 열 유형 :1111 어쩌라고-->
                </div>

                <!-- 저장 버튼과 목록 보기 링크 -->
                <div class="btn">
                    <button class="btn" type="submit">저장</button>&nbsp;
                    <button class="btn" type="button" onclick="location.href='${pageContext.request.contextPath}/TrainerBoard'">목록 보기</button>	
                </div>
            </form>
        </main>
    </div>
<script>
	
	//이미지 미리보기
    function showPreview(input, previewId) {
        const file = input.files[0];
        if (file) {
        	//이미지 사이즈 제한
        	const maxSize = 2 * 1024 * 1024;
        	if (file.size > maxSize) {
                alert('파일 크기는 2MB를 초과할 수 없습니다.');
                input.value = '';
                return;
            }
        	//이미지 미리보기
            const reader = new FileReader();
            reader.onload = function (e) {
                const preview = document.getElementById(previewId);
                preview.src = e.target.result;
                preview.style.display = 'block';
            }
            reader.readAsDataURL(file);
        }
    }
	</script>
	
</body>
</html>
