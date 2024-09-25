<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>삭제 확인</title>
  
    <script>
        function confirmDelete(postid) {
            if (confirm("정말로 삭제하시겠습니까?")) {
                // 삭제를 위한 폼을 서버로 제출합니다.
                document.getElementById('deleteForm').action = "/delete?postid=" + postid;
                document.getElementById('deleteForm').submit();
            }
        }
    </script>
</head>
<body>
    <!-- 예시: 게시글 목록 -->
    <c:forEach items="${posts}" var="post">
        <div>
            <span>${post.title}</span>
            <button onclick="confirmDelete(${post.id})">삭제</button>
        </div>
    </c:forEach>

    <!-- 숨겨진 폼을 사용하여 삭제 요청을 보냅니다. -->
    <form id="deleteForm" method="post">
        <!-- 삭제 요청을 위한 필드가 추가될 수 있습니다. -->
    </form>
</body>
</html>
