<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시물 작성/수정</title>

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

    <style>
        body {
            background-color: #f5f7fa;
            font-family: 'Helvetica Neue', Arial, sans-serif;
        }

         .content-wrapper {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            margin-top: 53px;
            max-width: 900px; /* 최대 너비 설정 */
            margin-left: auto;
            margin-right: auto; /* 양옆 공간을 자동으로 설정하여 가운데 정렬 */
        }

        h2 {
            font-size: 2rem;
            font-weight: bold;
            color: #333;
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 3px solid #000;
            padding-bottom: 10px;
        }

        .form-control {
            padding: 12px;
            border-radius: 6px;
            border: 1px solid #ced4da;
            margin-bottom: 20px;
            font-size: 1.1rem;
            background-color: #f9f9f9;
        }

        .form-control:focus {
            border-color: #333;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.2);
        }

        .btn-primary {
            background-color: #333;
            border-color: #333;
            padding: 12px 20px;
            font-size: 1.1rem;
            border-radius: 6px;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #555;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
            padding: 12px 20px;
            font-size: 1.1rem;
            border-radius: 6px;
            margin-left: 10px;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
        }

        .summernote {
            height: 300px;
            border-radius: 6px;
        }

        label {
            font-weight: bold;
            font-size: 1.2rem;
            color: #333;
        }
        /* Summernote가 전체화면일 때 페이지를 덮는 스타일 */
        .note-editor.fullscreen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            z-index: 1050;
            background-color: #fff;
            overflow: hidden;
        }

        .note-toolbar {
            position: relative;
            z-index: 1051;
        }

        .note-editable {
            height: calc(100vh - 120px) !important;
            overflow-y: auto;
            background-color: white;
        }

    </style>

    <script type="text/javascript">
        $(document).ready(function() {
            $('.summernote').summernote({
                lang: 'ko-KR',
                height: 300,
                toolbar: [
                    ['style', ['style']],
                    ['font', ['bold', 'italic', 'underline', 'clear']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['insert', ['link', 'picture', 'video']],
                    ['view', ['fullscreen', 'codeview', 'help']]
                ]
            });
        });

        function formCheck(event) {
            var title = document.querySelector("#sic_title").value;
            var userid = document.querySelector("#user_id").value;
            var content = $('.summernote').summernote('code');

            if (title.length == 0) {
                alert("제목을 작성해주세요.");
                return false;
            } else if (userid.length == 0) {
                alert("작성자를 입력해주세요.");
                return false;
            } else if (content.length == 0 || content === '<p><br></p>') {
                alert("내용을 작성해주세요.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>


<div class="content-wrapper">
    <h2>${isUpdate ? '게시물 수정' : '게시물 작성'}</h2>

    <form action="<c:url value='/sicdan/submit' />" method="post" onsubmit="return formCheck(event)">
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
        <button type="button" class="btn btn-secondary" onclick="location.href='<c:url value='/sicdan/list' />'">목록 보기</button>
    </form>

</div>

</body>
</html>
