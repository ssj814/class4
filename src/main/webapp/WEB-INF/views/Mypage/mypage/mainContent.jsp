<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String currentPage = request.getParameter("page");

    // 기본값 설정: currentPage가 null이거나 빈 문자열일 경우 "userInfo"로 설정
    if (currentPage == null || "".equals(currentPage)) {
        currentPage = "userInfo";
    }

    if ("userInfo".equals(currentPage)) {
%>
        <jsp:include page="userInfo.jsp" />
<%
    } else if ("editInfo".equals(currentPage)) {
%>
        <jsp:include page="../../user/member/UserWriteForm.jsp" />
<%
    } else if ("deleteAccount".equals(currentPage)) {
%>
        <jsp:include page="../../user/member/withdrawal.jsp" />
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
    } else {
%>
        <p>마이페이지에 오신 것을 환영합니다!</p>
<%
    }
%>
