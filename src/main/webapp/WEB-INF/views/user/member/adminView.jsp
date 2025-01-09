<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="content">
	<div class="container mt-3">
	    <h2 class="mb-3 pb-1 fw-bold border-bottom border-dark">회원 관리</h2>
	    <table class="table table-bordered table-striped">
	        <thead>
	            <tr>
	                <th class="text-nowrap">회원수</th>
	                <th class="text-nowrap">회원번호</th>
	                <th class="text-nowrap">아이디</th>
	                <th class="text-nowrap">가입날짜</th>
	                <th class="text-nowrap">수정일</th>
	                <th class="text-nowrap">마지막 로그인</th>
	                <th class="text-nowrap">권한 변경</th>
	                <th class="text-nowrap">수정</th>
	                <th class="text-nowrap">삭제</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="user" items="${users}" varStatus="status">
	                <tr>
	                    <td>${status.index + 1}</td>
	                    <td>${user.usernumber}</td>
	                    <td>${user.userid}</td>
	                    <td>${user.formattedCreated}</td>  <!-- String으로 변환된 날짜 출력 -->
	                    <td>${user.formattedUpdated}</td>  <!-- String으로 변환된 날짜 출력 -->
	                    <td>${user.formattedLastLogin}</td>  <!-- String으로 변환된 날짜 출력 -->
	                    
	                    <!-- 역할 변경 드롭다운 및 버튼을 가로로 나란히 배치 -->
	                    <td>
	                        <form action="/app/admin/changeRole/${user.usernumber}" method="post">
	                            <div class="input-group">
	                                <select name="newRole" class="form-control">
	                                    <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>USER</option>
	                                    <option value="TRAINER" ${user.role == 'TRAINER' ? 'selected' : ''}>TRAINER</option>
	                                    <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
	                                </select>
	                                <div class="input-group-append">
	                                    <button type="submit" class="btn btn-primary">권한 변경</button>
	                                </div>
	                            </div>
	                        </form>
	                    </td>
						<td>
	                        <a href="/app/admin/updateUser/${user.usernumber}" class="btn btn-warning text-nowrap">수정</a>
	                    <td>
	                        <a href="/app/admin/delete/${user.usernumber}" class="btn btn-danger text-nowrap">삭제</a>
	                    </td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	</div>
</div>