<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="resources/css/login/userWriteForm.css?ver=2">
<title>Insert title here</title>
<%
   String mesg = (String)session.getAttribute("mesg");
   if(mesg!=null){
%>
   <script type="text/javascript">
     alert('<%=mesg%>');
   </script>
<%
session.removeAttribute("mesg");
   }
%>
</head>
<body>
<jsp:include page="member/UserWriteForm.jsp" flush="true" />
</body>
</html>