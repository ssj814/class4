<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
     <!-- id, 패스워드 입력 검사 후 진행하도록  작성  -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("form").on("submit",function(event){        
            var userid = $("#userid").val();
            var passwd = $("#userpw").val();
                   if(userid.length==0){
                       alert("userid 필수")
                       $("#userid").focus();
                       event.preventDefault();
                   }else if(passwd.length==0){
                       alert("userpw 필수")
                       $("#userpw").focus();
                       event.preventDefault();
                   }
               });
		$("#member").click(function(){
			location.href = "UserWriteForm";
		})
	})
</script>
  <div class="login-container">
        <h2>로그인</h2>
        <form action="<c:url value="/login"/>" method="post">
            <label for="userid">사용자 이름:</label>
            <input type="text" id="userid" name="userid">
            
            <label for="userpw">비밀번호:</label>
            <input type="password" id="userpw" name="userpw">
            
            <button type="submit">로그인</button>
        </form>
        	<button id="member">회원가입</button>
    </div>
