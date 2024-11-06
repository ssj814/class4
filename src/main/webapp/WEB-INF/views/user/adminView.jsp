<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin User Management</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1>사원 목록 보기</h1>
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>아이디</th>
                    <th>최초 가입일</th>
                    <th>수정일</th>
                    <th>마지막 로그인</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.usernumber}</td>
                        <td>${user.userid}</td>
                        <td>${user.formattedCreated}</td>  <!-- String으로 변환된 날짜 출력 -->
                        <td>${user.formattedUpdated}</td>  <!-- String으로 변환된 날짜 출력 -->
                        <td>${user.formattedLastLogin}</td>  <!-- String으로 변환된 날짜 출력 -->
                        <td><a href="/admin/delete/${user.usernumber}" class="btn btn-danger">삭제</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="/admin/home" class="btn btn-primary">관리자 홈으로</a>
    </div>
</body>
</html>
