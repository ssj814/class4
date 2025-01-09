<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.report-container {
    max-width: 900px;
    margin: 0 auto;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

h4 {
    color: #333;
    margin-bottom: 20px;
    text-decoration: underline;
}

.report-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    background-color: #fff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.report-table th, .report-table td {
    padding: 12px 15px;
    border-bottom: 1px solid #ddd;
    text-align: left;
    color: #555;
}

.report-table th {
	width: 20%;
    background-color: #333;
    color: #fff;
    font-weight: bold;
    text-align:center;
    text-transform: uppercase;
}

.form-group {
    margin-bottom: 20px;
}

textarea {
    resize: none;
}

.btn-dark {
    color: #fff;
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s, box-shadow 0.3s;
}

.btn-dark:hover {
    background-color: #aaa;
}

.status-toggle-group {
    display: flex;
    justify-content: flex-start;
    margin-top: 10px;
}

.toggle-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background-color: #f9f9f9;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.3s;
}

.toggle-btn:hover {
    background-color: #f1f1f1;
}

.toggle-btn.active {
    background-color: #333;
    color: #fff;
    border-color: pink;
    font-weight: bold;
}
</style>

<div class="container report-container mt-3">
    <h2 class="mb-3 pb-1 fw-bold border-bottom border-dark">신고 처리</h2>

    <!-- 신고 정보 -->
    <div class="report-details">
        <h4>Report Info</h4>
        <table class="report-table">
            <tr>
                <th>신고자 이름</th>
                <td>${report.reporterName}</td>
                <th>신고자 이메일</th>
                <td>${report.reporterEmail}</td>
            </tr>
            <tr>
            	<th>신고자 전화번호</th>
            	<td>${report.reporterPhone}</td>
            	<th>신고 날짜</th>
            	<td>${report.createdAt}</td>
            </tr>
            <tr>
                <th>신고 제목</th>
                <td colspan="4">${report.title}</td>
            </tr>
            <tr>
                <th>신고 내용</th>
                <td colspan="4">${report.content}</td>
            </tr>
        </table>
    </div>

    <!-- 신고당한 대상 정보 -->
    <div class="target-details">
        <h4>Reported Target Info</h4>
        <c:choose>
            <c:when test="${report.targetType == 'PRODUCT'}">
                <table class="report-table">
                    <tr>
                        <th>상품명</th>
                        <td>${target.productName}</td>
                    </tr>
                    <tr>
                        <th>상품 설명</th>
                        <td>${target.description}</td>
                    </tr>
                </table>
            </c:when>
            <c:when test="${report.targetType == 'POST'}">
                <table class="report-table">
                    <tr>
                        <th>글 제목</th>
                        <td>${target.title}</td>
                    </tr>
                    <tr>
                        <th>글 내용</th>
                        <td>${target.content}</td>
                    </tr>
                </table>
            </c:when>
            <c:when test="${report.targetType == 'COMMENT'}">
            	<c:if test="${report.category == 'TRAINER'}">
	                <table class="report-table">
	                    <tr>
	                        <th>댓글 내용</th>
	                        <td>${target.commContent}</td>
	                    </tr>
	                </table>
                </c:if>
                <c:if test="${report.category == 'NOTICE'}">
	                <table class="report-table">
		                    <tr>
		                        <th>댓글 내용</th>
		                        <td>${target.content}</td>
		                    </tr>
		            </table>
	            </c:if>
            </c:when>
        </c:choose>
    </div>

    <!-- 신고 처리 -->
    <div class="report-actions">
        <h4>Report Processing</h4>
        <form action="<c:url value='/admin/handle_report'/>" method="post">
            <input type="hidden" name="reportId" value="${report.reportId}" />
            <input type="hidden" name="targetId" value="${report.targetId}" />
            
			<div class="form-group">
			    <div class="status-toggle-group">
			        <button type="button" class="toggle-btn ${report.status == 'PENDING' ? 'active' : ''}" data-status="PENDING">처리 대기</button>
			        <button type="button" class="toggle-btn ${report.status == 'IN_PROGRESS' ? 'active' : ''}" data-status="IN_PROGRESS">처리 중</button>
			        <button type="button" class="toggle-btn ${report.status == 'RESOLVED' ? 'active' : ''}" data-status="RESOLVED">처리 완료</button>
			        <button type="button" class="toggle-btn ${report.status == 'REJECTED' ? 'active' : ''}" data-status="REJECTED">거절</button>
			        <input type="hidden" name="status" id="status" value="${report.status}">
			    </div>
			</div>

            <div class="form-group">
                <label for="comments">관리자 의견</label>
                <textarea name="comments" id="comments" rows="3" class="form-control">${report.comments}</textarea>
            </div>

            <button type="submit" class="btn btn-dark">저장</button>
        </form>
    </div>
</div>

<script>
	document.querySelectorAll('.toggle-btn').forEach(button => {
	    button.addEventListener('click', function () {
	        document.querySelectorAll('.toggle-btn').forEach(btn => btn.classList.remove('active'));
	        this.classList.add('active');
	        document.getElementById('status').value = this.dataset.status; // 숨겨진 input에 값 설정
	    });
	});
</script>

