<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 상세보기</title>

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <style>
        main {
            margin-top: 70px; /* 헤더 높이만큼 여백 추가 */
        }

        /* 게시물 테이블 스타일 */
        .boardHeader {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .boardHeader th, .boardHeader td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
        }

        .boardHeader th {
            background-color: #f7f7f7;
            font-weight: bold;
            width: 15%; /* 각 항목의 균형을 위해 넓이를 조정 */
        }

        .boardHeader td {
            font-size: 1rem;
            width: 25%; /* 각 항목의 균형을 위해 넓이를 조정 */
        }

        /* 제목 스타일 */
        .post-header {
            background-color: #333;
            color: #fff;
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
            padding: 15px;
            border-radius: 5px 5px 0 0;
            margin-bottom: 20px;
        }

        /* 본문 텍스트 스타일 */
        #boardArticle_content {
            padding: 20px;
            margin-top: 10px;
            background-color: #f9f9f9;
            border-radius: 5px;
            font-size: 1.1rem;
            line-height: 1.6;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* 푸터 버튼 스타일 */
        #boardArticle_footer {
            margin-top: 20px;
            text-align: center; /* 가운데 정렬 */
        }

        #boardArticle_footer button {
            margin-right: 10px;
            padding: 10px 20px;
            border-radius: 4px;
            background-color: #333;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        #boardArticle_footer button:hover {
            background-color: #555;
        }
        html, body {
    height: 100%;
    margin: 0;
    display: flex;
    flex-direction: column;
}

#boardList {
    flex: 1;
    width: 80%;
    margin: 20px auto;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #f9f9f9;
    padding: 20px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
    </style>
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
        <button onclick="location.href='<c:url value='/sicdan/form?num=${retrive.sic_num}&currentPage=${currentPage}' />'">수정</button>
        <button onclick="location.href='<c:url value='/sicdan/delete?num=${retrive.sic_num}&currentPage=${currentPage}' />'">삭제</button>
        <button onclick="location.href='<c:url value='/sicdan/list?currentPage=${currentPage}' />'">목록</button>
    </div>
</div>

</body>
</html>
