<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원 탈퇴</title>
</head>
<body>
    <h2>회원 탈퇴</h2>
    <form action="${pageContext.request.contextPath}/user/withdraw" method="post">
        <label for="reason">탈퇴 사유:</label><br>
        <textarea name="reason" id="reason" rows="5" cols="50" placeholder="탈퇴 사유를 입력해 주세요"></textarea><br><br>
        <input type="submit" value="탈퇴하기">
    </form>
</body>
</html>