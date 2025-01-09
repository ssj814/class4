<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/general/reportWrite.css">
    <div class="report_container">
        <h1>신고하기</h1>
        <form action="<c:url value='/user/reportWrite' />" method="post">
            <!-- 신고 정보 -->
            <div class="section">
                <label class="sectionHeader">신고 정보 (필수)</label>
                <div>
                    <label for="reportTypeId">신고분류</label>
                    <select id="reportTypeId" name="reportTypeId" required>
                        <option value="">선택하세요</option>
                        <c:forEach var="type" items="${reportTypes}">
                            <c:if test="${targetType == 'PRODUCT' && type.targetType == 'PRODUCT'}">
                                <option value="${type.reportTypeId}">${type.reportTypeName}</option>
                            </c:if>
                            <c:if test="${(targetType == 'POST' || targetType == 'COMMENT') && type.targetType == 'CONTENT'}">
                                <option value="${type.reportTypeId}">${type.reportTypeName}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>
                <div>
                	<c:if test="${targetType == 'PRODUCT'}">
	                    <label for="productName">상품명</label>
	                    <div id="content" class="content-view">
					        <c:out value="${dto.getProduct_name()}" escapeXml="false" />
					    </div>
                    </c:if>
                	<c:if test="${targetType == 'POST' || targetType == 'COMMENT'}">
	                    <label for="content">신고 글 내용</label>
	                    <div id="content" class="content-view">
					        <c:out value="${content}" escapeXml="false" />
					    </div>
                    </c:if>
                </div>
            </div>

            <!-- 답변 받을 분 -->
            <div class="section">
                <label class="sectionHeader">답변 받으실 분</label>
                <div>
                    <label for="reporterName">성명</label>
                    <input type="text" id="reporterName" name="reporterName" value="${user.realname }" required readonly>
                </div>
                <div>
                    <label for="reporterEmail">이메일</label>
                    <input type="email" id="reporterEmail" name="reporterEmail" value="${user.email }" required readonly>
                </div>
                <div>
                    <label for="reporterPhone">연락처</label>
                    <input type="tel" id="reporterPhone" name="reporterPhone" value="${user.phone }">
                </div>
            </div>

            <!-- 신고 내용 -->
            <div class="section">
                <label class="sectionHeader">신고 내용 (필수)</label>
                <div>
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required>
                </div>
                <div>
                    <label for="content">내용</label>
                    <textarea id="content" name="content" rows="5" placeholder="신고 사유, 권리 침해 상황에 대해 구체적으로 입력하세요. 신고 사유가 불명확한 경우 신고 처리가 어려울 수 있습니다." required></textarea>
                </div>
            </div>

            <!-- 제출 버튼 -->
            <div class="section">
                <button type="submit" class="submit-btn">신고하기</button>
            </div>
            
            <input type="hidden" name="targetType" value="${targetType}">
        	<input type="hidden" name="targetId" value="${targetId}">
        	<c:if test="${not empty category}">
			    <input type="hidden" name="category" value="${category}">
			</c:if>
			<input type="hidden" name="previousUrl" value="${previousUrl}">
        </form>
    </div>
<script>
	function adjustHeight(element) {
	    element.style.height = 'auto'; // 기존 높이를 초기화
	    element.style.height = (element.scrollHeight) + 'px'; // 컨텐츠 높이에 맞게 조정
	}
	
	// 페이지 로드 시 초기 높이 조정
	document.addEventListener("DOMContentLoaded", function () {
	    const textareas = document.querySelectorAll('textarea[readonly]');
	    textareas.forEach(textarea => adjustHeight(textarea));
	});
</script>