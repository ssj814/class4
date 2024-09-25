<%@page import="com.example.dto.TrainerDTO"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String st = (String)request.getAttribute("searchType");
	String sv = (String)request.getAttribute("searchVal");
	String mesg = (String)request.getAttribute("mesg");
	//if(mesg!=null){
%>
<c:if test="${mesg != null}">
	<script type="text/javascript">
     alert('${mesg}');
   </script>
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>트레이너 목록</title>
<link rel="stylesheet" type="text/css" href="resources/css/trainer/trainerList.css"> <!-- CSS 파일 링크 -->
</head>
<body>
    <h2 class="title">트레이너 페이지</h2>
    <div class="button-group" id="fieldContainer">
	    <button class="filter-button" value="all">전체</button>
	    <button class="filter-button" value="웨이트">웨이트</button>
		<button class="filter-button" value="재활">재활</button>
		<button class="filter-button" value="다이어트">다이어트</button>
		<button class="filter-button" value="대회준비">대회준비</button>
		<button class="filter-button" value="맨몸운동">맨몸운동</button>
		<button class="filter-button" value="바디프로필">바디프로필</button>
		<button class="filter-button" value="건강관리">건강관리</button>
    </div>
    <hr>
    <!-- 검색기능 -->
	    <div class="trainer-search">
	    	<select name="searchType" id="searchType">
	    		<option value="intro" <%if (st != null && st.equals("intro")){ %> selected<%} %>>제목</option>
	    		<option value="gender"<%if (st != null &&  st.equals("gender")){ %> selected<%} %>>성별</option>
	    		<option value="loc"<%if (st != null &&  st.equals("loc")){ %> selected<%} %>>지역</option>
	    	</select>
	    	<input type="text" id="searchVal" name="searchVal" <%if (sv != null){ %> value=<%= sv %> <%} %>>
	    	<button type="submit" id="searchBtn">검색</button>
	    </div><br>
    <!-- 트레이너 리스트 -->
    <div class="trainer-list">
    <c:forEach var="t" items="${list}">
    	 <div class="trainer-card">
            <div class="trainer-header">
                <b><span class="trainer-name"><a href="trainer_info?idx=${t.trainer_id}">${t.name}</a> </span></b>&nbsp;&nbsp;<span class="trainer-center">${t.lesson_area1} ${t.lesson_area2}</span><br>
                <h3 class="trainer-intro"><span><a href="trainer_info?idx=${t.trainer_id}">${t.intro}</a></span></h3>
                <span class="trainer-spec">
	                <c:forTokens items="${t.field}" delims="," var="field">
					${field}
					</c:forTokens>
                </span><br>
                <span class="trainer-date">${t.reg_date}</span>
            </div>
            <div class="trainer-image">
                <%-- <img src="upload/${t.trainer_img_name}" alt="Trainer Image"> --%>
            </div>
        </div>
        <br>
    </c:forEach>
    </div>
    <!-- 페이징 -->
     <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="trainer_list?page=1">&laquo; 처음</a>
            <a href="trainer_list?page=${currentPage - 1}&field=${field}&searchType=${searchType}&searchVal=${searchVal}">&laquo; 이전</a>
        </c:if>
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <a href="trainer_list?page=${i}&field=${field}&searchType=${searchType}&searchVal=${searchVal}" class="${i == currentPage ? 'active' : ''}">${i}</a>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <a href="trainer_list?page=${currentPage + 1}&field=${field}&searchType=${searchType}&searchVal=${searchVal}">다음 &raquo;</a>
            <a href="trainer_list?page=${totalPages}&field=${field}&searchType=${searchType}&searchVal=${searchVal}">마지막 &raquo;</a>
        </c:if>
    </div>
    <br>
    <div class="trainerAdding">
    <a href="trainer_join">트레이너 등록</a>
    </div>
    <br>
</body>

<!-- script tag -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function () {
		//트레이너 분야 검색
		$(".filter-button").on("click", function () {
			if ($(this).val() =='all') {
				location.href = "trainer_list";
			} else {
				location.href = "trainer_list?field="+$(this).val();
			}
		})
		
		//트레이너 추가 검색
		 $("#searchBtn").on("click", function () {
			 var params = new URL(location.href).searchParams;
			 var field = params.get('field');
			 
			 if (field !== null) {//필드 선택되어 있으면
				 location.href = "trainer_list?field="+field+"&searchType="+$("#searchType").val()
						 						 +"&searchVal="+$("#searchVal").val();
			 } else {
				 location.href = "trainer_list?searchType="+$("#searchType").val()+
						 						 "&searchVal="+$("#searchVal").val();
			 }
			
		}) 
		
	})
</script>
</html>
