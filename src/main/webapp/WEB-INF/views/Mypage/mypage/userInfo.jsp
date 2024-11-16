<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 정보</title>
</head>
<body>
<div class="container my-5" style="width: 60%;">
        <div class="card shadow">
            <div class="card-header bg-dark text-white">
                <h1 class="h3 mb-0">회원 정보</h1>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4 text-center">
                        <img src="<c:url value='${userInfo.profilepicture}' />" alt="프로필 사진" class="img-thumbnail rounded-circle" style="width: 215px; height: 215px;">
                    </div>
                    <div class="col-md-8">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item"><strong>회원 번호:</strong> ${userInfo.usernumber}</li>
                            <li class="list-group-item"><strong>실명:</strong> ${userInfo.realusername}</li>
                            <li class="list-group-item"><strong>사용자 ID:</strong> ${userInfo.userid}</li>
                            <li class="list-group-item"><strong>이메일:</strong> ${userInfo.emailUsername}@${userInfo.emailDomain}</li>
                            <li class="list-group-item"><strong>성별:</strong> ${userInfo.gender}</li>
                            <li class="list-group-item"><strong>전화번호:</strong> ${userInfo.phone1}-${userInfo.phone2}-${userInfo.phone3}</li>
                            <li class="list-group-item"><strong>우편번호:</strong> ${userInfo.postalcode}</li>
                            <li class="list-group-item"><strong>주소:</strong> ${userInfo.streetaddress} ${userInfo.detailedaddress}</li>
                            <li class="list-group-item"><strong>계정 활성 여부:</strong> ${userInfo.isactive}</li>
                            <li class="list-group-item"><strong>최근 로그인:</strong> ${userInfo.lastlogin}</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>