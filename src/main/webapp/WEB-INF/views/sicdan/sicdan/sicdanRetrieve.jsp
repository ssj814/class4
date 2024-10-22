<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 상세보기</title>

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="resources/css/sicdan/sicdanRetrieve.css">
    
</head>
<body>
<!-- SweetAlert 라이브러리 로드 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    // 메시지 내용이 있을 경우 SweetAlert로 알림 표시
    <c:if test="${not empty mesg}">
        Swal.fire({
            title: '알림',
            text: '${mesg}',
            icon: 'info',
            confirmButtonText: '확인'
        }).then(() => {
            // 히스토리 상태 변경
            history.replaceState(null, null, location.href);
        });
    </c:if>
 // 메시지 알림을 초기화하는 함수
    function resetAlertFlags() {
        sessionStorage.removeItem('mesgDisplayed');
    }
</script>

<div class="container">
    <h2 class="post-header">[식단게시판]</h2>
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

    <div id="boardArticle_footer">
        <button onclick="location.href='<c:url value='/sicdan_form?num=${retrive.sic_num}&currentPage=${currentPage}' />'">수정</button>
        <button onclick="location.href='<c:url value='/sicdan_delete?num=${retrive.sic_num}&currentPage=${currentPage}' />'">삭제</button>
        <button onclick="location.href='<c:url value='/sicdan_list?currentPage=${currentPage}' />'">목록</button>
    </div>
</div>

</body>
</html>
