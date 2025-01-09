<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.table-title {
    background-color: #f1f1f1;
    white-space: nowrap;
    border-left: 1px solid grey;
    border-right: 1px solid grey;
}

.table-row {
    width: 100%;
    border-collapse: collapse;
    vertical-align: middle;
}

.table-row th, .table-row td {
    padding: 10px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

.table-row th {
    background-color: #333;
    color: white;
}

.status-in-progress-row td {
    background-color: #fff9c4;
}

.status-resolved-row td{
    background-color: #c8e6c9;
}

.status-rejected-row td{
    background-color: #ffcdd2;
}

.action-button {
    padding: 5px 10px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.action-button:hover {
    opacity: 0.8;
}

.edit-btn {
    background-color: #333;
    color: white;
}

.report_paging {
    text-align: center;
    margin: 20px 0;
}

.report_paging a, .report_paging span {
    display: inline-block;
    padding: 8px 12px;
    margin: 0 5px;
    border-radius: 4px;
    text-decoration: none;
    color: #333;
    background-color: #f1f1f1;
    transition: background-color 0.3s, color 0.3s;
}

.report_paging a:hover {
    background-color: #ddd;
    color: #000;
}

.report_paging .current {
    font-weight: bold;
    background-color: #333;
    color: #fff;
}
</style>

<div class="content">
    <div class="container mt-3">
        <h2 class="mb-3 pb-1 fw-bold border-bottom border-dark">신고 관리</h2>
        <table class="table">
            <thead>
                <tr class="table-row">
                    <th>번호</th>
                    <th>카테고리</th>
                    <th>신고 유형</th>
                    <th>신고 제목</th>
                    <th>신고자</th>
                    <th>날짜</th>
                    <th>상태</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="report" items="${reportList}" varStatus="status">
                    <tr class="table-row ${report.status == 'IN_PROGRESS' ? 'status-in-progress-row' :
                                    report.status == 'RESOLVED' ? 'status-resolved-row' :
                                    report.status == 'REJECTED' ? 'status-rejected-row' : ''}">
                        <td>${totalCount-(status.index+(currentPage-1) * perPage)}</td>
                        <td>${report.category}</td>
                        <td>    
	                        <c:forEach var="type" items="${reportTypes}">
						        <c:if test="${type.reportType == report.reportType}">
						            ${type.reportTypeName}
						        </c:if>
						    </c:forEach>
					    </td>
					    <td>${report.title}</td>
                        <td>${report.reporterName}</td>
                        <td>${report.createdAt}</td>
                        <td>${report.status}</td>
                        <td>
                            <button class="action-button edit-btn" onclick="handleReport(${report.reportId})">처리</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="report_paging">
            <c:if test="${currentPage > 1}">
                <a href="view_reports?currentPage=${currentPage - 1}">이전</a>
            </c:if>
            <c:forEach var="i" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span class="current">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="view_reports?currentPage=${i}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <a href="view_reports?currentPage=${currentPage + 1}">다음</a>
            </c:if>
        </div>
    </div>
</div>

<script>
    function handleReport(reportId) {
    	let url = `${pageContext.request.contextPath}/admin/handle_report?reportId=`;
    	url += reportId;
        location.href = url;
    }
</script>
