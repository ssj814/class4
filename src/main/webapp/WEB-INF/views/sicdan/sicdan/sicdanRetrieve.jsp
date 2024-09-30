<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 상세보기</title>
</head>
<body>

<div id="boardArticle">
    <h2>게시물 상세보기</h2>
    <table class="boardHeader">
        <tr>
            <th>제목</th>
            <td colspan="3">${retrive.sic_title}</td>
            <th>작성자</th>
            <td>${retrive.user_id}</td>
        </tr>
        <tr>
            <th>글번호</th>
            <td>${retrive.sic_num}</td>
            <th>등록일</th>
            <td>${retrive.writeday}</td>
            <th>조회수</th>
            <td>${retrive.readCnt}</td>
        </tr>
    </table>
    <div id="boardArticle_content">
        <p>${retrive.content}</p>
    </div>
</div>

<div id="boardArticle_footer">
    <button onclick="location.href='<c:url value='/sicdan/form?num=${retrive.sic_num}&currentPage=${currentPage}' />'">수정</button>
    <button onclick="location.href='<c:url value='/sicdan/delete?num=${retrive.sic_num}&currentPage=${currentPage}' />'">삭제</button>
    <button onclick="location.href='<c:url value='/sicdan/list?currentPage=${currentPage}' />'">목록</button>
</div>

</body>
</html>
