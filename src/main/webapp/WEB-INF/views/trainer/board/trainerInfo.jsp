<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.example.dto.TrainerDTO"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${mesg != null}">
	<script type="text/javascript">
     alert('${mesg}');
   </script>
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="resources/css/trainer/trainerInfo.css"> <!-- CSS 파일 링크 -->
</head>
<body>
	<div class="trainer-card">
		<div class="trainer-header">
			<b><span class="trainer-name">${info.name}</span></b>&nbsp;&nbsp;<span class="trainer-center">${info.lesson_area1} ${info.lesson_area2}</span><br>
      <h3 class="trainer-intro"><span>${info.intro}</span></h3><br>
      <span class="trainer-date">${info.reg_date}</span>
    </div>
    <div class="trainer-image">
      <%--   <img src="<%= request.getContextPath()%>\<%= img %>" alt="Trainer Image"> --%>
        <%-- <img src="upload/${info.img_name}" alt="Trainer Image"> --%>
    </div>
  </div>
  
  <div class="trainer-card">
		<span>소개글</span>
		<span class="trainer-content">${info.content}</span>
  </div>
   
  <div class="trainer-card">
		<span>전문 수업</span>
		<c:forTokens items="${info.field}" delims="," var="field">
		<button>${field}</button>
		</c:forTokens>
  </div>
  
  <div class="trainer-card">
		<span>활동 중인 센터</span><br>
		<span class="trainer-center">${info.center_name}</span>
  </div>
  <div class="trainer-card">
		<span>자격 사항</span><br>
		<span class="trainer-cert">${info.certificate_type} ${info.certificate}</span>
  </div>
  <div class="trainer-card">
		<span>레슨 프로그램</span><br>
		<span class="trainer-program">
		<c:forTokens items="${info.lesson_program}" delims="," var="program">
		<button>${program}</button>
		</c:forTokens>
		</span>
  </div>
  <br>
  
  <!--  -->
  <a href="trainer_list">목록</a>
  <%-- <c:if test="idx랑 로그인한멤버의 idx가 같으면"> --%>
  	<a href="trainer_modify?idx=${info.trainer_id}">수정</a>
  	<a href="trainer_deletion?idx=${info.trainer_id}">삭제</a>
  <%-- </c:if> --%>
</body>
</html>