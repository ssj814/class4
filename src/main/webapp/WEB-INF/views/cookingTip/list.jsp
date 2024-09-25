<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰</title>
</head>
<body>
<h1>고객 리뷰</h1>
<table border="1">
  <tr>
    <td>번호</td>
    <td>제목</td>
    <td>후기</td>
    <td>작성자</td>
    <td>작성일</td>
    <td>조회수</td>
    
  </tr>
  <c:forEach var="list" items="${allData}">
    <tr>
    <td>${list.bno}</td>
    <td>${list.title}</td>
    <td>${list.content}</td>
    <td>${list.writer}</td>
    <td>${list.regdate}</td>
    <td>${list.viewcnt}</td>
    
   
  </tr>
  </c:forEach>
</table>

</body>
</html>
