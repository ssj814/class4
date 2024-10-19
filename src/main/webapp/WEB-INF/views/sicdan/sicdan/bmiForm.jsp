<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>BMI 계산기</title>

<!-- Bootstrap CSS 추가 -->

<style>

    main {
        margin-top: 70px; /* 헤더 높이만큼 여백 추가 */
    }

  body {
    background-color: #f8f9fa;
  }
  .bmi-form-container {
    max-width: 600px;
    margin: 50px auto;
    background-color: #fff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
  }
  h2 {
    text-align: center;
    margin-bottom: 20px;
    font-weight: 600;
    color: #007bff;
  }
</style>
</head>
<body>

<div class="container">
  <div class="bmi-form-container">
    <h2>BMI 계산기</h2>

    <form action="calculateBMI" method="post" class="row g-3">
        <!-- 성별 선택 -->
        <div class="col-12">
            <label for="gender" class="form-label">성별:</label>
            <div class="form-check form-check-inline">
                <input type="radio" name="gender" value="male" id="male" class="form-check-input" required>
                <label class="form-check-label" for="male">남자</label>
            </div>
            <div class="form-check form-check-inline">
                <input type="radio" name="gender" value="female" id="female" class="form-check-input">
                <label class="form-check-label" for="female">여자</label>
            </div>
        </div>

        <!-- 신장 입력 -->
        <div class="col-md-6">
            <label for="height" class="form-label">신장(cm):</label>
            <input type="text" name="height" id="height" class="form-control" required>
        </div>

        <!-- 체중 입력 -->
        <div class="col-md-6">
            <label for="weight" class="form-label">체중(kg):</label>
            <input type="text" name="weight" id="weight" class="form-control" required>
        </div>

        <!-- 나이 입력 -->
        <div class="col-12">
            <label for="age" class="form-label">나이:</label>
            <input type="text" name="age" id="age" class="form-control" required>
        </div>

        <!-- 버튼들 -->
        <div class="col-12 d-flex justify-content-center">
            <button type="submit" class="btn btn-primary mx-2">계산</button>
            <button type="reset" class="btn btn-secondary mx-2">초기화</button>
        </div>
    </form>
  </div>
</div>

<!-- Bootstrap JS 추가 (Popper.js 포함) -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3-alpha3/dist/js/bootstrap.min.js"></script>
</body>
</html>
