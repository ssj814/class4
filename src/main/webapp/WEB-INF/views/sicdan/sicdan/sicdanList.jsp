<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>운동 식단 게시판</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">
    <style>
        /* 전체 스타일 초기화 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #f8f9fa;
        }

        #boardList {
            width: 80%;
            margin: 20px auto;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        #boardList_title {
            background-color: #333;
            color: #fff;
            padding: 10px;
            font-size: 2em;
            font-weight: bold;
            text-align: center;
            border-radius: 8px 8px 0 0;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f1f1f1;
            font-weight: bold;
        }

        td a {
            text-decoration: none;
            color: #333;
            transition: color 0.3s;
        }

        td a:hover {
            color: #007bff;
        }

        #pagination {
            text-align: center;
            margin: 20px 0;
        }

        #pagination button {
            margin: 0 5px;
            padding: 8px 15px;
            border: none;
            background-color: #333;
            color: white;
            cursor: pointer;
            border-radius: 4px;
        }

        #pagination button:hover {
            background-color: #555;
        }

        /* Flexbox로 검색과 글쓰기 버튼을 한 행에 배치 */
        #search-container {
            display: flex;
            justify-content: space-between; /* 좌우 정렬 */
            align-items: center;
            margin-bottom: 20px;
        }

        #search {
            display: flex;
            align-items: center;
        }

        #search select, #search input[type="text"], #search input[type="submit"] {
            padding: 10px;
            margin-right: 10px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        #search input[type="submit"] {
            background-color: #333;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        #search input[type="submit"]:hover {
            background-color: #555;
        }

        #write-btn {
            text-align: right;
        }

        #write-btn button {
            padding: 10px 20px;
            border-radius: 4px;
            background-color: #333;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        #write-btn button:hover {
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
            width: 53%;
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
<!-- SweetAlert 라이브러리 로드 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- SweetAlert 라이브러리 로드 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
<!-- SweetAlert 라이브러리 로드 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    // 메시지 내용이 있을 경우 SweetAlert로 알림 표시
    <c:if test="${not empty mesg}">
        if (!sessionStorage.getItem('mesgDisplayed')) {
            Swal.fire({
                title: '알림',
                text: '${mesg}',
                icon: 'info',
                confirmButtonText: '확인'
            }).then(() => {
                // 메시지가 표시된 후에 세션 스토리지에 상태 저장
                sessionStorage.setItem('mesgDisplayed', 'true');
                // 히스토리 상태 변경
                history.replaceState(null, null, location.href);
            });
        }
    </c:if>

    <c:if test="${not empty error}">
        if (!sessionStorage.getItem('errorDisplayed')) {
            Swal.fire({
                title: '오류',
                text: '${error}',
                icon: 'error',
                confirmButtonText: '확인'
            }).then(() => {
                // 오류 메시지가 표시된 후에 세션 스토리지에 상태 저장
                sessionStorage.setItem('errorDisplayed', 'true');
                // 히스토리 상태 변경
                history.replaceState(null, null, location.href);
            });
        }
    </c:if>

    // 알림 상태를 초기화하는 함수
    function resetAlertFlags() {
        sessionStorage.removeItem('mesgDisplayed');
        sessionStorage.removeItem('errorDisplayed');
    }
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
                <c:forEach var="sicdan" items="${list}">
                    <tr>
                        <td>${sicdan.sic_num}</td>
                        <td><a href="<c:url value='/sicdan/retrieve?num=${sicdan.sic_num}&currentPage=${currentPage}' />">${sicdan.sic_title}</a></td>
                        <td>${sicdan.user_id}</td>
                        <td>${sicdan.writeday}</td>
                        <td>${sicdan.readCnt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagination">
            <c:if test="${currentPage > 1}">
                <button onclick="location.href='<c:url value='/sicdan/list?currentPage=${currentPage - 1}' />'">이전</button>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="page">
                <button onclick="location.href='<c:url value='/sicdan/list?currentPage=${page}' />'" class="${page == currentPage ? 'active' : ''}">${page}</button>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <button onclick="location.href='<c:url value='/sicdan/list?currentPage=${currentPage + 1}' />'">다음</button>
            </c:if>
        </div>

        <!-- Flexbox 적용한 검색과 글쓰기 버튼을 한 행에 배치 -->
        <div id="search-container">
            <div id="search">
                <form action="<c:url value='/sicdan/list' />" method="get">
                    <select name="searchName">
                        <option value="title">제목</option>
                        <option value="user_id">작성자</option>
                    </select>
                    <input type="text" name="searchValue" placeholder="검색어를 입력하세요" />
                    <input type="submit" value="검색" />
                </form>
            </div>

            <div id="write-btn">
                <button type="button" onclick="resetAlertFlags(); location.href='<c:url value='/sicdan/form' />'">글쓰기</button>

            </div>
        </div>
    </div>

</body>
</html>
