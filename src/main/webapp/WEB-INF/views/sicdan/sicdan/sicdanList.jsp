<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>운동 식단 게시판</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">
        <script>
        // 페이지가 로드되면 메시지를 확인하고 알림창을 띄웁니다.
        window.onload = function() {
            var mesg = "${mesg}";
            if (mesg !== "") {
                alert(mesg);
            }
        };
    </script>
</head>
<body>
    <h1>운동 식단 게시판</h1>

    <div id="boardList">
        <div id="boardList_list">
            <table>
                <thead>
                    <tr>
                        <th>글번호</th>
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
                            <td>
                                <a href="<c:url value='/sicdan/retrieve?num=${sicdan.sic_num}&currentPage=${currentPage}' />">${sicdan.sic_title}</a>
                            </td>
                            <td>${sicdan.user_id}</td>
                            <td>${sicdan.writeday}</td>
                            <td>${sicdan.readCnt}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div id="pagination">
            <c:if test="${currentPage > 1}">
                <button onclick="location.href='<c:url value="/sicdan/list?currentPage=${currentPage - 1}"/>'">이전</button>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="page">
                <button onclick="location.href='<c:url value="/sicdan/list?currentPage=${page}"/>'" 
                        class="${page == currentPage ? 'active' : ''}">${page}</button>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <button onclick="location.href='<c:url value="/sicdan/list?currentPage=${currentPage + 1}"/>'">다음</button>
            </c:if>
        </div>
    </div>

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

    <div>
        <!-- 글쓰기 버튼 -->
        <button type="button" onclick="location.href='<c:url value='/sicdan/form' />'">글쓰기</button>
    </div>
</body>
</html>
