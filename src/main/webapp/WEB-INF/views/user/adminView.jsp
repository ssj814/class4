<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin User Management</title>
</head>
<body>
    <h1>사원 목록 보기</h1>
    <table border="1">
        <thead>
            <tr>
                <th>번호</th>
                <th>이름</th>
                <th>주소</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.name}</td>
                    <td>${user.address}</td>
                    <td><a href="${pageContext.request.contextPath}/users/${user.id}/delete">삭제</a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/admin">관리자 홈으로</a>
</body>
</html>