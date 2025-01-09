<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Bootstrap CSS -->
<!-- 써머노트 호환성 때문에 4.5.2 일단 유지 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="resources/css/sicdan/sicdanRetrieve.css">
    
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
            <td colspan="3">${retrive.title}</td>
            <th>작성자</th>
            <td>${retrive.writer}</td>
        </tr>
        <tr>
            <th>글번호</th>
            <td>${retrive.postId}</td>
            <th>등록일</th>
            <td>${retrive.createdAt}</td>
            <th>조회수</th>
            <td>${retrive.viewCount}</td>
        </tr>
    </table>

    <div id="boardArticle_content">
        <p>${retrive.content}</p>
    </div>

    <div class="mb-3 d-flex justify-content-between" id="boardArticle_footer">  
    	<div class="">
    	    <c:if test="${retrive.writer == sessionScope.SPRING_SECURITY_CONTEXT.authentication.name 
	    		|| fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN')}">
	        <button onclick="location.href='<c:url value='/sicdan_form?num=${retrive.postId}&currentPage=${currentPage}' />'">수정</button>
	        <button onclick="location.href='<c:url value='/sicdan_delete?num=${retrive.postId}&currentPage=${currentPage}' />'">삭제</button>
	        </c:if>
	        <button onclick="location.href='<c:url value='/sicdan_list?currentPage=${currentPage}' />'">목록</button>
    	</div>
    	<div>
    		<button id="report">신고하기</button>
    	</div>
    </div>
</div>

<script>
	document.addEventListener("DOMContentLoaded", function () {
	    const reportButton = document.getElementById("report");
	
	    reportButton.addEventListener("click", function () {
	        let url = `${pageContext.request.contextPath}/user/reportWrite?targetType=POST&id=${retrive.postId}&category=SICDAN`;
	        url += '&previousUrl=' + encodeURIComponent(window.location.href);
	        location.href = url;
	    });
	});
</script>