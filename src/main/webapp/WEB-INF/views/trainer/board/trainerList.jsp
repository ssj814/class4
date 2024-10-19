<%@page import="com.example.dto.TrainerDTO"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 메시지가 있으면 알림창 표시 -->
<c:if test="${not empty mesg}">
    <script type="text/javascript">
        alert('${mesg}');
    </script>
</c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>트레이너 목록</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }
        .title {
            font-weight: bold;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2rem;
        }
        .filter-group {
            text-align: center;
            margin-bottom: 20px;
        }
        .filter-group button {
            margin-right: 5px;
            margin-bottom: 5px;
            font-size: 0.9rem;
            padding: 7px 15px;
            border: none;
            background-color: #6c757d; /* 중성적 회색 */
            color: white;
            transition: background-color 0.3s ease;
        }
        .filter-group button:hover {
            background-color: #495057; /* 호버 시 약간 어두운 회색 */
        }
        .search-bar {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .search-bar input, .search-bar select {
            margin-right: 10px;
            border: 1px solid #ced4da;
        }
        .search-bar button {
            background-color: #343a40; /* 진한 회색 */
            color: white;
            border: none;
            padding: 8px 16px;
            transition: background-color 0.3s ease;
        }
        .search-bar button:hover {
            background-color: #23272b; /* 호버 시 약간 더 어두운 색 */
        }
        .trainer-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .trainer-card {
            background-color: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .trainer-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        .trainer-image img {
            width: 150px;
            height: 150px;
            border-radius: 12px;
            object-fit: cover;
            margin-right: 30px;
        }
        .trainer-info {
            flex-grow: 1;
        }
        .trainer-name {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .trainer-intro {
            font-size: 1rem;
            color: #666;
            margin-bottom: 10px;
        }
        .trainer-spec {
            font-size: 0.9rem;
        }
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .pagination a {
            margin: 0 5px;
            padding: 10px;
            border-radius: 5px;
            background-color: #adb5bd; /* 세련된 회색 */
            color: white;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .pagination a:hover {
            background-color: #6c757d; /* 호버 시 조금 더 어두운 회색 */
        }
        .trainerAdding {
            position: fixed;
            right: 20px;
            bottom: 20px;
            z-index: 1000;
        }
        .trainerAdding a {
            padding: 12px 20px;
            background-color: #007bff; /* 모던한 파란색 */
            color: white;
            text-decoration: none;
            border-radius: 50px; /* 둥근 버튼 */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }
        .trainerAdding a:hover {
            background-color: #0056b3; /* 호버 시 더 진한 파란색 */
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="title">트레이너 목록</h2>

        <!-- 필터 버튼 -->
        <div class="filter-group">
            <button class="btn filter-button" value="all">전체</button>
            <button class="btn filter-button" value="웨이트">웨이트</button>
            <button class="btn filter-button" value="재활">재활</button>
            <button class="btn filter-button" value="다이어트">다이어트</button>
            <button class="btn filter-button" value="대회준비">대회준비</button>
            <button class="btn filter-button" value="맨몸운동">맨몸운동</button>
            <button class="btn filter-button" value="바디프로필">바디프로필</button>
            <button class="btn filter-button" value="건강관리">건강관리</button>
        </div>

        <!-- 검색 기능 -->
        <div class="search-bar">
            <select name="searchType" id="searchType" class="form-control w-auto">
                <option value="intro" ${searchType == 'intro' ? 'selected' : ''}>제목</option>
                <option value="gender" ${searchType == 'gender' ? 'selected' : ''}>성별</option>
                <option value="loc" ${searchType == 'loc' ? 'selected' : ''}>지역</option>
            </select>
            <input type="text" id="searchVal" name="searchVal" class="form-control w-auto" value="${searchVal != null ? searchVal : ''}">
            <button type="submit" id="searchBtn" class="btn">검색</button>
        </div>

        <!-- 트레이너 리스트 -->
        <div class="trainer-list">
            <c:forEach var="t" items="${list}">
                <div class="trainer-card">
                    <div class="trainer-image">
                        <img src="<c:url value='/images/trainer_images/${t.img_name}'/>" alt="Trainer Image"> <!-- 임시 이미지 -->
                    </div>
                    <div class="trainer-info">
                        <div class="trainer-name"><a href="trainer_info?idx=${t.trainer_id}">${t.name}</a></div>
                        <div class="trainer-intro">${t.intro}</div>
                        <div class="trainer-spec">
                            <c:forTokens items="${t.field}" delims="," var="field">
                                <span class="badge badge-secondary">${field}</span>
                            </c:forTokens>
                        </div>
                        <div class="trainer-date text-muted">${t.reg_date}</div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- 페이징 -->
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="trainer_list?page=1">&laquo; 처음</a>
                <a href="trainer_list?page=${currentPage - 1}&field=${field}&searchType=${searchType}&searchVal=${searchVal}">&laquo; 이전</a>
            </c:if>
            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <a href="trainer_list?page=${i}&field=${field}&searchType=${searchType}&searchVal=${searchVal}" class="${i == currentPage ? 'active' : ''}">${i}</a>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <a href="trainer_list?page=${currentPage + 1}&field=${field}&searchType=${searchType}&searchVal=${searchVal}">다음 &raquo;</a>
                <a href="trainer_list?page=${totalPages}&field=${field}&searchType=${searchType}&searchVal=${searchVal}">마지막 &raquo;</a>
            </c:if>
        </div>

        <!-- 트레이너 등록 버튼 -->
        <div class="trainerAdding">
            <a href="trainer_join">트레이너 등록</a>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            // 필터 버튼 클릭 시 필터 적용
            $(".filter-button").on("click", function () {
                if ($(this).val() == 'all') {
                    location.href = "trainer_list";
                } else {
                    location.href = "trainer_list?field=" + $(this).val();
                }
            });

            // 검색 버튼 클릭 시 검색 적용
            $("#searchBtn").on("click", function () {
                var params = new URL(location.href).searchParams;
                var field = params.get('field');

                if (field !== null) {
                    location.href = "trainer_list?field=" + field + "&searchType=" + $("#searchType").val() + "&searchVal=" + $("#searchVal").val();
                } else {
                    location.href = "trainer_list?searchType=" + $("#searchType").val() + "&searchVal=" + $("#searchVal").val();
                }
            });
        });
    </script>
</body>
</html>
