<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 정보</title>
</head>
<body>
    <h1>회원 정보</h1>
    
    <p>회원 번호: ${userInfo.usernumber}</p>
    <p>실명: ${userInfo.realusername}</p>
    <p>사용자 ID: ${userInfo.userid}</p>
    <p>이메일: ${userInfo.emailusername}@${userInfo.emaildomain}</p>
    <p>생년월일: ${userInfo.birthdate}</p>
    <p>성별: ${userInfo.gender}</p>
    <p>전화번호: ${userInfo.phone1}-${userInfo.phone2}-${userInfo.phone3}</p>
    <p>우편번호: ${userInfo.postalcode}</p>
    <p>주소: ${userInfo.streetaddress} ${userInfo.detailedaddress}</p>
    <p>닉네임: ${userInfo.nickname}</p>
    <p>프로필 사진: <img src="${userInfo.profilepicture}" alt="프로필 사진"></p>
    <p>포인트: ${userInfo.mileage}</p>
    <p>계정 활성 여부: ${userInfo.isactive}</p>
    <p>최근 로그인: ${userInfo.lastlogin}</p>
</body>
</html>
