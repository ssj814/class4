<!-- mypage.jsp -->
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <!-- Bootstrap CSS -->
    <style>
        /* 사이드바 레이아웃 스타일 */
        .sidebar {
            width: 250px;
            height: 100vh;
            background-color: #f8f9fa;
            padding: 20px;
            position: fixed;
        }
        .content {
            margin-left: 270px;
            padding: 20px;
        }
           /* 푸터 스타일 */
        footer {
            background-color: #343a40;
            color: #ffffff;
            padding: 10px 20px;
            text-align: center;
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
        }
        footer a {
            color: #ffffff;
            text-decoration: none;
        }
        footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <!-- 사이드바 -->
    <div class="sidebar">
        <h4>마이페이지</h4>
        <!-- 회원정보 드롭다운 -->
        <div class="accordion" id="accordionSidebar">
            <div class="accordion-item">
                <h2 class="accordion-header" id="headingUser">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseUser" aria-expanded="true" aria-controls="collapseUser">
                        회원정보
                    </button>
                </h2>
                <div id="collapseUser" class="accordion-collapse collapse show" aria-labelledby="headingUser" data-bs-parent="#accordionSidebar">
                    <div class="accordion-body">
                        <a href="${pageContext.request.contextPath}/mypage?page=userInfo" class="nav-link">회원정보</a>
                        <a href="${pageContext.request.contextPath}/mypage?page=editInfo" class="nav-link">회원정보 수정</a>
                        <a href="${pageContext.request.contextPath}/mypage?page=deleteAccount" class="nav-link">회원탈퇴</a>
                    </div>
                </div>
            </div>

            <!-- 쇼핑정보 드롭다운 -->
            <div class="accordion-item">
                <h2 class="accordion-header" id="headingShopping">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseShopping" aria-expanded="false" aria-controls="collapseShopping">
                        쇼핑정보
                    </button>
                </h2>
                <div id="collapseShopping" class="accordion-collapse collapse" aria-labelledby="headingShopping" data-bs-parent="#accordionSidebar">
                    <div class="accordion-body">
                        <a href="${pageContext.request.contextPath}/user/cartList" class="nav-link">장바구니</a>
                    
                        <a href="${pageContext.request.contextPath}/mypage?page=wishlist" class="nav-link">위시리스트</a>
                    </div>
                </div>
            </div>

         
        </div>
    </div>

    <!-- 메인 콘텐츠 -->
    <div class="content">
        <jsp:include page="mainContent.jsp" />
    </div>

</body>
</html>
