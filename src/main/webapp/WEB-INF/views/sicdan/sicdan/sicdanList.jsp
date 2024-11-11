<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>운동 식단 게시판</title>
  
    <link rel="stylesheet" href="<c:url value='/resources/css/sicdan/sicdanList.css' />">
</head>
<body>

<!-- SweetAlert 라이브러리 로드 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    // 작성 완료 후 메시지를 SweetAlert로 바로 표시
    <c:if test="${not empty mesg}">
        Swal.fire({
            title: '알림',
            text: '${mesg}',
            icon: 'info',
            confirmButtonText: '확인'
        }).then(() => {
            // 알림이 표시된 후 세션 스토리지에 상태 저장
            sessionStorage.setItem('mesgDisplayed', 'true');
            // URL의 히스토리 상태 변경 (새로고침 시 메시지가 다시 뜨지 않도록 방지)
            history.replaceState(null, null, location.href);
        });
    </c:if>

    <c:if test="${not empty error}">
        Swal.fire({
            title: '오류',
            text: '${error}',
            icon: 'error',
            confirmButtonText: '확인'
        }).then(() => {
            sessionStorage.setItem('errorDisplayed', 'true');
            history.replaceState(null, null, location.href);
        });
    </c:if>

    // 세션 스토리지를 확실히 초기화하는 함수
    function resetAlertFlags() {
        sessionStorage.removeItem('mesgDisplayed');  // 작성 알림 초기화
        sessionStorage.removeItem('errorDisplayed'); // 오류 알림 초기화
    }

    // 페이지 로드 시 세션 스토리지 초기화
    window.onload = function() {
        resetAlertFlags(); // 새로고침 시 알림 상태 초기화
    };
</script>

<div id="boardList">
    <div id="boardList_title">[운동 식단 게시판]</div>
    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="sicdan" items="${list}" varStatus="status">
                <tr>
                    <td>${totalCount-(status.index+(currentPage-1)*pageSize)}</td>
                    <td><a href="<c:url value='/sicdan_retrieve?num=${sicdan.sic_num}&currentPage=${currentPage}' />">${sicdan.sic_title}</a></td>
                    <td>${sicdan.user_id}</td>
                    <td>${sicdan.writeday}</td>
                    <td>${sicdan.readCnt}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div id="pagination">
        <!-- 이전 버튼 -->
        <c:if test="${currentPage > 1}">
            <button onclick="location.href='<c:url value='/sicdan_list?currentPage=${currentPage - 1}' />'">이전</button>
        </c:if>

        <!-- 페이지 번호 버튼 -->
        <c:forEach begin="1" end="${totalPages}" var="page">
            <button onclick="location.href='<c:url value='/sicdan_list?currentPage=${page}' />'" class="${page == currentPage ? 'active' : ''}">${page}</button>
        </c:forEach>

        <!-- 다음 버튼 -->
        <c:if test="${currentPage < totalPages}">
            <button onclick="location.href='<c:url value='/sicdan_list?currentPage=${currentPage + 1}' />'">다음</button>
        </c:if>
    </div>

    <!-- Flexbox 적용한 검색과 글쓰기 버튼을 한 행에 배치 -->
    <div id="search-container">
        <div id="search">
            <form action="<c:url value='/sicdan_list' />" method="get">
                <select name="searchName">
                    <option value="title">제목</option>
                    <option value="user_id">작성자</option>
                </select>
                <input type="text" name="searchValue" placeholder="검색어를 입력하세요" />
                <input type="submit" value="검색" />
            </form>
        </div>

        <div id="write-btn">
            <button type="button" onclick="resetAlertFlags(); location.href='<c:url value='/sicdan_form' />'">글쓰기</button>
        </div>
    </div>
</div>

</body>
</html>
