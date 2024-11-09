<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String currentPage = request.getParameter("page");

    if ("userInfo".equals(currentPage)) {
%>
        <jsp:include page="userInfo.jsp" />
<%
    } else if ("editInfo".equals(currentPage)) {
%>
        <jsp:include page="user/member/UserWriteForm.jsp" />
<%
    } else if ("deleteAccount".equals(currentPage)) {
%>
        <jsp:include page="Mypage/mypage/deleteAccount.jsp" />
<%
    } else if ("orderList".equals(currentPage)) {
%>
        <jsp:include page="shoppingMall/cart/cartList.jsp" />
<%
    } else if ("returns".equals(currentPage)) {
%>
        <jsp:include page="shoppingMall/returns.jsp" />
<%
    } else if ("wishlist".equals(currentPage)) {
%>
        <jsp:include page="shoppingMall/wishList.jsp" />
<%
    } else if ("inquiries".equals(currentPage)) {
%>
        <jsp:include page="Mypage/mypage/inquiries.jsp" />
<%
    } else {
%>
        <p>마이페이지에 오신 것을 환영합니다!</p>
<%
    }
%>
