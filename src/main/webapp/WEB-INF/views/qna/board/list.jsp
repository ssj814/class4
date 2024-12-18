<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="container">
	<div id="boardList">
		<div id="boardList_title">[ Q & A ]</div>
		<div id="boardList_list">
			<div id="postTitle">
				<dl class="horizontal">
					<dt class="faq_qna_id">번호</dt>
					<dt class="category dropdown">
						<a class="nav-link dropdown-toggle" href="#" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"> 카테고리 </a>
						<ul class="dropdown-menu">
							<!-- 이거 카테고리 테이블 하나로 빼기. -->
							<li><a class="dropdown-item" href="qna">전체질문</a></li>
							<li><a class="dropdown-item" href="?category=member">회원</a></li>
							<li><a class="dropdown-item" href="?category=trainer">트레이너</a></li>
							<li><a class="dropdown-item" href="?category=product">상품</a></li>
							<li><a class="dropdown-item" href="?category=mealplan">식단</a></li>
							<li><a class="dropdown-item" href="?category=other">기타</a></li>
						</ul>
					</dt>
					<dt class="question">질문</dt>
					<dt class="questioner">작성자</dt>
					<dt class="faq_qna_date">작성일</dt>
					<dt class="answer">답변여부</dt>
				</dl>
			</div>

			<div id="lists">
				<c:forEach var="dto" items="${list}" varStatus="status">
					<dl class="horizontal">
						<dd class="faq_qna_id">${totalCount-(status.index+(currentPage-1)*perPage)}</dd>
						<dd class="category">${dto.category}</dd>
						<dd class="question">
							<c:choose>
							    <c:when test="${dto.is_secret == 1}">
							        <i class="fa-solid fa-lock"></i>
							        <c:if test="${fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN') 
							                     || sessionScope.SPRING_SECURITY_CONTEXT.authentication.name == dto.questioner}">
							            <a href="qna_content?faq_qna_id=${dto.faq_qna_id}&currentPage=${currentPage}">${dto.question}</a>
							        </c:if>
							        <c:if test="${!(fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN') 
							                        || sessionScope.SPRING_SECURITY_CONTEXT.authentication.name == dto.questioner)}">
							            <span>${dto.question}</span>
							        </c:if>
							    </c:when>
							    <c:otherwise>
							        <a href="qna_content?faq_qna_id=${dto.faq_qna_id}&currentPage=${currentPage}">${dto.question}</a>
							    </c:otherwise>
							</c:choose>
						</dd>
						<dd class="questioner">${dto.questioner}</dd>
						<dd class="faq_qna_date">${dto.faq_qna_date}</dd>
						<c:choose>
							<c:when test="${dto.answer != null}">
								<dd class="answer fw-bold">답변완료</dd>
							</c:when>
							<c:otherwise>
								<dd class="answer">답변대기</dd>
							</c:otherwise>
						</c:choose>
					</dl>
				</c:forEach>
			</div>
		</div>

        <div id="boardList_paging">
            <c:choose>
                <c:when test="${currentPage > 1}">
                    <a class="page-link"
                        href="qna?currentPage=${currentPage - 1}
                        <c:if test='${not empty search.searchKey && not empty search.searchValue}'>
                            &searchKey=${search.searchKey}&searchValue=${search.searchValue}
                        </c:if>
                    ">이전</a>
                </c:when>
            </c:choose>
            <c:forEach var="i" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span>${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a
                            href="qna?currentPage=${i}<c:if test='${not empty search.searchKey && not empty search.searchValue}'>
                        &searchKey=${search.searchKey}&searchValue=${search.searchValue}
                    </c:if>">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:choose>
                <c:when test="${currentPage < totalPages}">
                    <a class="page-link"
                        href="qna?currentPage=${currentPage + 1}
                        <c:if test='${not empty search.searchKey && not empty search.searchValue}'>
                            &searchKey=${search.searchKey}&searchValue=${search.searchValue}
                        </c:if>
                    ">다음</a>
                </c:when>
            </c:choose>
        </div>

		<div id="boardList_footer">
			<div>
				<form action="#" method="get" name="searchForm">
					<input type="hidden" name="category" value="${category}"> <select
						name="searchKey" class="selectField">
						<option value="question">질문</option>
						<option value="questioner">작성자</option>
					</select> <input type="text" name="searchValue" class="textField" /> <input
						type="button" value=" 검 색 " id="boardSearch" />
				</form>
			</div>
			<div>
				<input type="button" value=" 글쓰기 " id="writing" />
			</div>
		</div>

	</div>
</div>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
    	
		//제목 길이 처리
		$(".question a").each(function(idx,data) {
			let productName = $(data).text();
			let len = 20;
			if(productName.length < len){
				return
			}
		    let sliceName = $(data).text().slice(0,len) + "...";
		    $(data).text(sliceName);
		});
		
        $("#writing").on("click", function() {
            location.href = 'qna_write';
        });

        $("#boardSearch").on("click", function() {
            $("form").attr("action", "qna").submit();
        });

    });
</script>
