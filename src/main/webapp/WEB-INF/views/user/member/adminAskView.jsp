<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.ask-title {
	background-color: #f1f1f1 !important;
	white-space: nowrap;
	border-left: 1px solid grey;
	border-right: 1px solid grey;
}

.ask-number {
	width: 5%;
}
.ask-content {
	width: 10%;
}

.ask-question a {
	color: black;
}

.answer-container {
	display: none;
}

.answer-container td {
	text-align: right;
}

.answer-btn {
	border: none;
	background-color: #212529;
	color: #fff;
	padding: 5px 10px;
	border-radius: 4px;
	cursor: pointer;
}

.answer-btn:hover {
	background-color: pink;
	color: black;
}

.answer-container button {
	border: none;
	background-color: grey;
	color: #fff;
	border-radius: 4px;
	cursor: pointer;
}

.answer-container button:hover {
	background-color: black;
}

.ask-answer {
	resize: none;
	width: 95%;
	height: 80px;
}

.active-btn {
	background-color: pink;
	color: black;
}

.answered {
	background-color: #e9ecef !important;
}

/* 페이징 컨트롤 스타일 */
#ask_paging {
    text-align: center;
    margin: 20px 0;
}

#ask_paging a, #ask_paging span {
    display: inline-block;
    padding: 8px 12px;
    margin: 0 5px;
    border-radius: 4px;
    text-decoration: none;
    color: #333;
    background-color: #f1f1f1;
    transition: background-color 0.3s, color 0.3s;
}

#ask_paging a:hover{
    background-color: #ddd;
    color: #000;
}

#ask_paging .current {
    font-weight: bold;
    background-color: #333;
    color: #fff;
}

/* 이전/다음 버튼 스타일 */
#ask_paging a {
    padding: 8px 15px;
    font-weight: bold;
}

#ask_paging a:hover, #ask_paging span {
    background-color: #555;
    color: #fff;
}
</style>

<div class="content">
	<div class="container mt-3">
		<h2 class="mb-3 pb-1 fw-bold border-bottom border-dark">문의 관리</h2>
		<table class="table">
			<thead>
				<tr>
					<th class="ask-title ask-number">번호</th>
					<th class="ask-title ask-content">카테고리</th>
					<th class="ask-title ask-content">날짜</th>
					<th class="ask-title" colspan="2">질문</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="ask" items="${askList}" varStatus="status">
					<tr class="ask-container">
						<td class="text-nowrap <c:if test="${ask.answer != null}">answered</c:if>">
							${(currentPage - 1) * perPage + status.index + 1 }
						</td>
						<td class="text-nowrap <c:if test="${ask.answer != null}">answered</c:if>">${ask.category}</td>
						<td class="text-nowrap <c:if test="${ask.answer != null}">answered</c:if>">${ask.faq_qna_date}</td>
						<td class="text-nowrap ask-question <c:if test="${ask.answer != null}">answered</c:if>">
							<c:choose>
								<c:when test="${ask.product_id != 0}">
									<a href="<c:url value='/shopDetail?productId=${ask.product_id}'/>">${ask.question}</a>
								</c:when>
								<c:otherwise>
									<a href="<c:url value='/qna_content?faq_qna_id=${ask.faq_qna_id}'/>">${ask.question}</a>
								</c:otherwise>
							</c:choose>
						</td>
						<td style="text-align: right;" class="<c:if test="${ask.answer != null}">answered</c:if>"><button class="answer-btn">답변하기</button></td>
					</tr>
					<tr class="answer-container">
						<td colspan="5">
							<form>
								<input type="hidden" name="faq_qna_id" value="${ask.faq_qna_id}">
								<textarea class="ask-answer" name="answer">${ask.answer}</textarea><br>
								<button>완료</button>
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="ask_paging">
            <c:choose>
                <c:when test="${currentPage > 1}">
                    <a class="page-link" href="view_ask?currentPage=${currentPage - 1}">이전</a>
                </c:when>
            </c:choose>
            <c:forEach var="i" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span>${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="view_ask?currentPage=${i}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:choose>
                <c:when test="${currentPage < totalPages}">
                    <a class="page-link" href="view_ask?currentPage=${currentPage + 1}">다음</a>
                </c:when>
            </c:choose>
        </div>
	</div>
</div>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(document).ready( function() {

		$(".answer-btn").on("click",function() {
			//현재상태
			const isActive = $(this).hasClass("active-btn");
			//초기화
			$(".answer-btn").removeClass("active-btn");
			$(".answer-container").css("display", "none");
			//활성화
			if (!isActive) {
				$(this).addClass("active-btn");
				$(this).closest(".ask-container").next(".answer-container").css("display","table-row");
			}
		});
		
	    $("form").on("submit", function(event) {
	        event.preventDefault();
	        const formData = $(this).serialize();

	        $.ajax({
	            url: "/app/qna_save",
	            type: "PATCH",
	            data: formData,
	            success: function(response) {
	                alert(response);
	                location.reload();
	            },
	            error: function(xhr, status, error) {
	                alert("답변 저장 중 오류가 발생했습니다.");
	                console.error(error);
	            }
	        });
	    });

	});
</script>