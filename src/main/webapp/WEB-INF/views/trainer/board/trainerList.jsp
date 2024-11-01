<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.example.dto.TrainerDTO"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="resources/css/trainer/trainerList.css">

<!-- 메시지가 있으면 알림창 표시 -->
<c:if test="${not empty mesg}">
	<script type="text/javascript">
		alert('${mesg}');
	</script>
</c:if>

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
		</select> <input type="text" id="searchVal" name="searchVal"
			class="form-control w-auto"
			value="${searchVal != null ? searchVal : ''}">
		<button type="submit" id="searchBtn" class="btn">검색</button>
	</div>

	<!-- 트레이너 리스트 -->
	<div class="trainer-list">
		<c:forEach var="t" items="${list}">
			<div class="trainer-card">
				<div class="trainer-image">
					<img src="<c:url value='/images/trainer_images/${t.img_name}'/>"
						alt="Trainer Image">
				</div>
				<div class="trainer-info">
					<div class="trainer-name">
						<a href="trainer_info?idx=${t.trainer_id}">${t.name}</a>
					</div>
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
			<a
				href="trainer_list?page=${currentPage - 1}&field=${field}&searchType=${searchType}&searchVal=${searchVal}">&laquo;
				이전</a>
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<a
				href="trainer_list?page=${i}&field=${field}&searchType=${searchType}&searchVal=${searchVal}"
				class="${i == currentPage ? 'active' : ''}">${i}</a>
		</c:forEach>
		<c:if test="${currentPage < totalPages}">
			<a
				href="trainer_list?page=${currentPage + 1}&field=${field}&searchType=${searchType}&searchVal=${searchVal}">다음
				&raquo;</a>
			<a
				href="trainer_list?page=${totalPages}&field=${field}&searchType=${searchType}&searchVal=${searchVal}">마지막
				&raquo;</a>
		</c:if>
	</div>

	<!-- 트레이너 등록 버튼 -->
	<div class="trainerAdding">
		<a href="trainer_join">트레이너 등록</a>
	</div>
	
</div>

<script type="text/javascript">

	$(function() {
		
		// 필터 버튼 클릭 시 필터 적용
		$(".filter-button").on("click", function() {
			if ($(this).val() == 'all') {
				location.href = "trainer_list";
			} else {
				location.href = "trainer_list?field=" + $(this).val();
			}
		});

		// 검색 버튼 클릭 시 검색 적용
		$("#searchBtn").on( "click", function() {
			var params = new URL(location.href).searchParams;
			var field = params.get('field');

			if (field !== null) {
				location.href = "trainer_list?field=" + field
						+ "&searchType=" + $("#searchType").val()
						+ "&searchVal=" + $("#searchVal").val();
			} else {
				location.href = "trainer_list?searchType="
						+ $("#searchType").val() + "&searchVal="
						+ $("#searchVal").val();
			}
		});
		
		
	});
</script>

