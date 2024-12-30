<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<style>

#ask-container {
	margin-top: 80px;
}

.ask-answer {
	background-color: #FAFAFA;
}

.ask-answer-input {
	background-color: #eee;
	display: none;

}

.ask-answer-input textarea {
	resize: none;
}

.ask-saveAnswer{
	margin-left: 30px;
}

.textarea-container {
    width: 96%;
    margin-left: 30px;
    text-align: right;
}

.textarea-container .textarea-btn {
    background-color: white; /* 버튼 색상 */
    color: black;
    border: 1px solid black;
    border-radius: 4px;
    padding: 5px 10px;
    font-size: 10px;
    cursor: pointer;
}

.textarea-container .textarea-btn:hover {
    background-color: black; /* 버튼 hover 색상 */
    color: white;
}

</style>

<div id="ask-container" class="container mb-5">
	
	<input type="hidden" class="ProductId"
		value="${product.getProduct_id()}">

	<div class="d-flex justify-content-between align-items-center">
		<h3 class="align-items-center fw-bold">상품문의</h3>
		<c:if test="${!empty sessionScope.SPRING_SECURITY_CONTEXT.authentication }"> 
			<button id="product-ask-openWindow"
				class="btn btn-link fst-italic text-dark mb-0">
				<i class="fa-solid fa-pen"></i>문의하기
			</button>
		</c:if>
	</div>
	
	<hr class="mt-0">
	
	<div class="container p-4">
	    <div>
	    	<ul>
	    		<li>상품문의 및 후기게시판을 통해 취소나 환불, 반품 등은 처리되지 않습니다.</li>
	    		<li>가격, 판매자, 교환/환불 및 배송 등 해당 상품 자체와 관련 없는 문의는 고객센터 내 Q&A 문의하기를 이용해주세요.</li>
	    		<li>"해당 상품 자체"와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출 제한, 삭제 등의 조치가 취해질 수 있습니다.</li>
	    		<li>공개 게시판으로 전화번호, 메일 주소 등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.</li>
	    	</ul>
	    </div>
	</div>
	
	<!-- 상품 문의 리스트 -->
	<div class="card">
		<div class="list-group list-group-flush">
			<c:set var="nowAskCount" value="0" />
			<c:set var="totalAskCount" value="0" />
			<c:forEach var="ask" items="${askList}">
				<c:set var="totalAskCount" value="${totalAskCount + 1}"/>
			</c:forEach>
			
			<c:forEach var="ask" items="${askList}">
				<div class="m-2 ask-item ${nowAskCount > 4 ? 'd-none' : ''}">
					<c:set var="nowAskCount" value="${nowAskCount + 1}" />
					<div class="ask-question d-flex justify-content-between border p-3 te">
						<div class="ask-question-content">
							<span class="badge text-bg-dark rounded-0 me-2">질문</span>
							<span>${ask.question}</span>
						</div>
						<div class="ask-question-right">
							<c:if test="${fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN')}">
								<c:choose>
									<c:when test="${empty ask.answer}">
										<button class="ask-answer-btn btn btn-outline-dark m-0 me-2 btn-sm">답변</button>
									</c:when>
									<c:otherwise>
										<button class="ask-answer-btn btn m-0 me-2 btn-sm btn-dark">수정</button>
									</c:otherwise>
								</c:choose>
							</c:if>
							<span class="text-muted">${ask.faq_qna_date}</span>
						</div>
					</div>
					
					<c:if test="${!empty ask.answer}">
						<div class="ask-answer border p-3 border-top-0 d-flex">
							<span class="badge bg-primary rounded-0 ms-3 me-2 h-50">답변</span>
							<p style="white-space: pre-wrap;">${ask.answer}</p>
						</div>
					</c:if>

					<c:if test="${fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN')}">
						<form action="shop_productAsk_saveAnswer" method="post" class="ask-answer-input border p-3 border-top-0">
							<input type="hidden" name="faq_qna_id" value="${ask.faq_qna_id}">
							<input type="hidden" name="product_id" value="${ask.product_id}">
							<c:choose>
								<c:when test="${!empty ask.answer}">
									<span class="ask-saveAnswer">답변 수정</span>
								</c:when>
								<c:otherwise>
									<span class="ask-saveAnswer">답변 등록</span>
								</c:otherwise>
							</c:choose>
							<div class="textarea-container">
								<hr>
								<textarea name="answer" rows="4" class="w-100 border">${ask.answer}</textarea>
								<button type="submit" class="textarea-btn">등록</button>
							</div>
						</form>
					</c:if>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<!-- 문의 페이징 -->
	<!-- (질문+답변 세트로)5개 보여주고, 전체보기 -->
	<c:if test="${totalAskCount > 5 }">
		<c:set var="totalAskView" value="false" />
		<div class="askBtn-container text-center mt-3">
			<button type="button" class="btn btn-dark" onclick="allAskList()">
				<i class="fa-solid fa-chevron-down"></i>
				<span> 전체보기</span>
			</button>
		</div>
	</c:if>

	
	<!-- 상품 신고 -->
	<div class="report-container">
		<h5>상품 신고</h5>
		<div class="d-flex justify-content-between">
			<span>부적절한 상품이나 지적재산권을 침해하는 상품의 경우 신고하여 주시기 바랍니다.</span>
			<button class="btn text-dark m-0 p-0 opacity-50 text-decoration-underline">신고하기</button>
		</div>
	</div>

</div>

<script>

	$(function() {
		
		// 로그인 유저 정보
		const loginUser = `${sessionScope.SPRING_SECURITY_CONTEXT.authentication.name }`;
		const isAdmin =  ${fn:contains(sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities, 'ADMIN')};
		
		// 문의 등록
		$('#product-ask-openWindow').on('click',function() {
			console.log("새창열기");
			var productId = $(".ProductId").val();
			var width = 600;
			var height = 700;
			var left = Math.ceil((window.screen.width - width) / 2);
			var top = Math.ceil((window.screen.height - height) / 2);
			window.open('/app/user/shop_productAsk/' + productId,
					'_blank', "width=" + width + ", height=" + height
							+ ", left=" + left + ",top=" + top
							+ "scrollbars=yes");
		});
		
		// 관리자 답변창 토글
		$(".ask-answer-btn").on("click",function() {
			var answerInput = $(this).closest(".ask-question").siblings(".ask-answer-input");
		    if (answerInput.is(":visible")) {
		        answerInput.hide(); 
		    } else {
		        $(".ask-answer-input").hide(); 
		        answerInput.show(); 
		    }
		});
		
	})
	
	function allAskList(){
	    $(".ask-item").removeClass("d-none"); 
	    $(".askBtn-container").hide(); 
	}

</script>