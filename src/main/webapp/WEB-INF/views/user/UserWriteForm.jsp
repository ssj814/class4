<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<div style="height: 150px;"></div>
<jsp:include page="../common/header.jsp" flush="true"/>
<jsp:include page="member/UserWriteForm.jsp" flush="true" />
<jsp:include page="../common/footer.jsp" flush="true"/>
</body>
</html>