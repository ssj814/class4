<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin User Management</title>
</head>
<body>
    <div class="container mt-5">
        <h1>사원 목록 보기</h1>
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>아이디</th>
                    <th>가입날자</th>
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
                        <td><a href="/app/admin/delete/${user.usernumber}" class="btn btn-danger">삭제</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
