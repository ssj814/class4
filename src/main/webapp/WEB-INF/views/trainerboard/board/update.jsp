<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    

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

 	
 	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/trainerboard_css/tb.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
</head>
<body>
<div class="container" style="margin-top:40px;">
        <main>


		   <form action="${pageContext.request.contextPath}/update" method="post" id="writeForm" enctype="multipart/form-data">
		    	<input type="hidden" name="postid" value="${dto.postid}">
		    	<div class="label">
		    	<label for="title">제목</label></div>
		    	<input type="text" id="title" name="title"  maxlength="50" required value="${dto.title}"><br><br>
		    	<div class="label">
		    	<label for="content">내용</label></div>
		    	  <textarea class="summernote form-control" id="content" name="content">${dto.content}</textarea> 
		    	<%-- <textarea id="content" name="content"  maxlength="1000" required>${dto.content}</textarea><br> --%>
			   
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
				class="img-fluid" style="object-fit: contain; height: 100px; width:100px; ">
                <input type="hidden" name="imagename" value='${dto.imagename}'/>
                </div>
                
			   <br>
			   <!-- 파일추가 -->
			   <div class="label">
			   <label for="file">이미지수정</label>
				<input type="file" id="weightImage" name="weightImage" accept="image/*" onchange="showPreview(this, 'preview')"><%-- ${dto.weightimage } --%>
				<img id="preview" class="image-preview" style="display: none;  width:100px; height:100px;" />
				</div>

				<br>
		    <div class="writeSubmit"  style="text-align: left;">
		    	<button class="writeSubmit">수정완료</button>
		    	<button class="writeSubmit" type="button" onclick="location.href='${pageContext.request.contextPath}/TrainerBoard'">목록보기</button>

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