<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.example.dto.TrainerDTO"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${mesg != null}">
	<script type="text/javascript">
     alert('${mesg}');
   </script>
</c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">-->
  
  <title>트레이너 프로필</title>
  <style>
    body {
      background-color: #f9f9f9;
    }
    .profile-container {
      background-color: white;
      padding: 2rem;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      margin-top: 20px;
    }
    h2 {
      font-weight: 700;
      color: #2c3e50;
    }
    dt {
      font-weight: bold;
      margin-top: 1rem;
      color: #34495e;
    }
    dd {
      margin-left: 0;
      font-size: 1rem;
      color: #2c3e50;
    }
    .badge {
      margin-right: 0.5rem;
      font-size: 0.9rem;
    }
    .action-buttons {
      margin-top: 2rem;
      text-align: right;
    }
    .btn {
      margin-right: 0.5rem;
    }
    .btn-outline-danger {
      background-color: red;
      color: white;
      border-color: red;
    }
    .btn-outline-danger:hover {
      background-color: darkred;
      border-color: darkred;
    }
    .btn-outline-info, .btn-outline-secondary {
      background-color: black;
      color: white;
      border-color: black;
    }
    .btn-outline-info:hover, .btn-outline-secondary:hover {
      background-color: grey;
      border-color: grey;
    }
    .profile-header {
    display: flex;
    align-items: center; /* 수직 중앙 정렬 */
    justify-content: center; /* 수평 중앙 정렬 추가 */
    gap: 2rem; /* 이미지와 텍스트 사이에 일정 간격 추가 */
}

.profile-content {
    flex-grow: 1; /* 텍스트 영역이 남은 공간을 차지하게 함 */
}

.profile-image {
    width: 300px;
    height: 300px;
    border-radius: 50%;
    object-fit: cover;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin-right: 20px; /* 이미지와 텍스트 사이의 간격을 더 조정 */
}
</style>
</head>
<body>
  <div class="container mt-4">
    <div class="profile-container">
      <!-- Trainer Profile Header -->
      <div class="profile-header">
        <div class="profile-content">
          <h2>${info.name}</h2>
          <p><strong>센터:</strong> ${info.lesson_area1} ${info.lesson_area2}</p>
        </div>
        <!-- Optional Trainer Image (if available) -->
        <img src="<c:url value='/images/trainer_images/${info.img_name}'/>" alt="Trainer Image" class="profile-image">
      </div>

      <!-- Trainer Information -->
      <dl class="row mt-4">
        <dt class="col-sm-3">소개글</dt>
        <dd class="col-sm-9">${info.intro}</dd>

        <dt class="col-sm-3">등록일</dt>
        <dd class="col-sm-9">${info.reg_date}</dd>

        <dt class="col-sm-3">상세 소개</dt>
        <dd class="col-sm-9">${info.content}</dd>

        <dt class="col-sm-3">전문 수업</dt>
        <dd class="col-sm-9">
          <c:forEach items="${info.field}"  var="field">
            <span class="badge bg-primary">${field}</span>
          </c:forEach>
          <c:if test="${info.field == null}">
          	<span class="badge bg-secondary">x</span>
          </c:if>
        </dd>

        <dt class="col-sm-3">활동 중인 센터</dt>
        <dd class="col-sm-9">${info.center_name}</dd>

        <dt class="col-sm-3">자격 사항</dt>
        <dd class="col-sm-9">${info.certificate_type} ${info.certificate}</dd>

        <dt class="col-sm-3">레슨 프로그램</dt>
        <dd class="col-sm-9">
          <c:forEach items="${info.lesson_program}"  var="program">
            <span class="badge bg-secondary">${program}</span>
          </c:forEach>
          <c:if test="${info.lesson_program == null}">
          	<span class="badge bg-secondary">x</span>
          </c:if>
        </dd>
      </dl>

      <!-- Action Buttons -->
      <div class="action-buttons">
        <a href="trainer_list" class="btn btn-outline-secondary">목록</a>
        <a href="trainer_modify?idx=${info.trainer_id}" class="btn btn-outline-info">수정</a>
        <a href="trainer_deletion?idx=${info.trainer_id}" class="btn btn-outline-danger">삭제</a>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
</body>
</html>
