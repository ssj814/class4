<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시물 작성/수정</title>

    <!-- Bootstrap CSS -->
    
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
	<link rel="stylesheet" href="resources/css/sicdan/sicdanForm.css">
    <style>
        body {
            background-color: #f5f7fa;
            font-family: 'Helvetica Neue', Arial, sans-serif;
        }

        /* 기타 스타일 */
    </style>

</head>
<body>

<div class="content-wrapper">
    <h2>${isUpdate ? '게시물 수정' : '게시물 작성'}</h2>

    <form action="<c:url value='/sicdan_submit' />" method="post" onsubmit="return formCheck(event)" enctype="multipart/form-data">
        <input type="hidden" name="sic_num" value="${dto.sic_num}">
        <input type="hidden" name="isUpdate" value="${isUpdate}">
        <input type="hidden" name="currentPage" value="${currentPage}">

        <div class="form-group">
            <label for="sic_title">제목:</label>
            <input type="text" class="form-control" id="sic_title" name="sic_title" value="${dto.sic_title}">
        </div>

        <div class="form-group">
            <label for="user_id">작성자:</label>
            <input type="text" class="form-control" id="user_id" name="user_id" value="${dto.user_id}">
        </div>

        <div class="form-group">
            <label for="content">내용:</label>
            <textarea class="summernote form-control" id="content" name="content">${dto.content}</textarea>
        </div>

        <input type="submit" class="btn btn-primary" value="${isUpdate ? '수정' : '발행'}">
        <button type="button" class="btn btn-secondary" onclick="location.href='<c:url value='/sicdan_list' />'">목록 보기</button>
    </form>

</div>

</body>
</html>
