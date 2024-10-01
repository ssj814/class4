<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>BMI 계산기 결과</title>
<style>
    main {
        margin-top: 70px; /* 헤더 높이만큼 여백 추가 */
    }

    body {
        background-color: #f8f9fa;
        font-family: 'Roboto', sans-serif;
    }

    .bmi-container {
        background-color: #fff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        max-width: 800px;
        margin: 50px auto;
    }

    .bmi-title {
        text-align: left;
        font-size: 1.5rem;
        font-weight: bold;
        color: #007bff;
        border-bottom: 2px solid #ddd;
        padding-bottom: 10px;
        margin-bottom: 20px;
    }

    .bmi-result-text {
        font-size: 1.25rem;
        color: #333;
        margin-bottom: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .bmi-result-text span {
        font-weight: bold;
        color: #ff6b6b;
    }

    /* 비만도 차트 스타일 */
    .obesity_box {
        width: 100%;
        padding: 10px;
        background-color: #f0f0f0;
        border-radius: 10px;
        position: relative; /* 그래프를 상대적으로 위치시킴 */
    }

    .obesity_bar ul {
        list-style-type: none;
        display: flex;
        padding: 0;
        margin: 0;
        justify-content: space-between;
        position: relative;
    }

    .obesity_bar ul li {
        flex: 1;
        text-align: center;
        padding: 10px 5px;
        font-size: 0.9rem;
        color: #fff;
        position: relative;
    }

    /* 각 BMI 구간의 색상 */
    .lv1 { background-color: #a3d3ff; } /* 저체중 */
    .lv2 { background-color: #7fcdbb; } /* 정상 */
    .lv3 { background-color: #f0b27a; } /* 과체중 */
    .lv4 { background-color: #ff6b6b; } /* 비만 */
    .lv5 { background-color: #ff3f34; } /* 고도비만 */

    /* BMI 표시 인디케이터 */
    .obesity_box_inner {
        position: absolute;
        top: 0; /* 인디케이터를 차트 상단에 고정 */
        width: 100%;
        height: 40px; /* 인디케이터 높이를 맞추기 위해 높이 조정 */
        background-color: transparent;
        margin-bottom: 10px; /* 하단 여백 추가하여 그래프가 인디케이터 아래에 위치 */
    }

    .bmi-indicator {
        position: absolute;
        bottom: 0; /* 인디케이터를 차트 하단에 고정 */
        width: 2px;
        height: 100%; /* 인디케이터 높이 */
        background-color: #000;
    }

    /* BMI 수치 라벨 */
    .bmi-indicator-label {
        position: absolute;
        bottom: 45px; /* 인디케이터 위로 라벨이 표시되도록 위치 조정 */
        left: 50%; /* 라벨 위치를 조정하여 중앙으로 고정 */
        transform: translateX(-50%); /* 중앙 정렬을 위해 변환 */
        font-size: 0.9rem;
        background-color: #fff;
        padding: 2px 5px;
        border-radius: 5px;
        font-weight: bold;
        color: #333;
        border: 1px solid #ccc;
    }

    .range-labels {
        display: flex;
        justify-content: space-between;
        position: absolute;
        bottom: -30px; /* 숫자를 하단에 표시 */
        width: 100%;
        font-size: 0.8rem;
        color: #333;
    }

    .range-labels span {
        flex: 1;
        text-align: center;
    }

    .range-labels span:first-child {
        text-align: left;
    }

    .range-labels span:last-child {
        text-align: right;
    }

    .btn-custom {
        background-color: #007bff;
        color: #fff;
        padding: 10px 20px;
        font-size: 16px;
        border-radius: 30px;
        box-shadow: 0px 4px 12px rgba(0, 123, 255, 0.3);
        transition: all 0.3s ease;
        margin-top: 20px;
    }

    .btn-custom:hover {
        background-color: #0056b3;
        box-shadow: 0px 6px 16px rgba(0, 86, 179, 0.4);
    }
</style>

</head>
<body>

<div class="container">
    <div class="bmi-container">
        <h2 class="bmi-title">비만도 계산 결과</h2>

        <!-- BMI 결과 텍스트 -->
        <div class="bmi-result-text">
            <span>나의 신체질량지수(BMI): <fmt:formatNumber value="${bmi}" type="number" maxFractionDigits="2" /></span>
            <span>${result}</span>
        </div>

        <!-- 비만도 차트 -->
        <div class="obesity_box">
            <div class="obesity_bar">
                <ul class="step5">
                    <li class="lv1">
                        저체중 <br>
                    </li>
                    <li class="lv2">
                        정상 <br>
                    </li>
                    <li class="lv3">
                        과체중 <br>
                    </li>
                    <li class="lv4">
                        비만 <br>
                    </li>
                    <li class="lv5">
                        고도비만 <br>
                    </li>
                </ul>
            </div>

            <!-- BMI 인디케이터 -->
            <div class="obesity_box_inner">
                <div class="bmi-indicator" style="left: calc(${(bmi < 18.5 ? (bmi / 18.5 * 20) : 
                                                          bmi < 23 ? 20 + ((bmi - 18.5) / (23 - 18.5) * 20) : 
                                                              bmi < 25 ? 40 + ((bmi - 23) / (25 - 23) * 20) : 
                                                              bmi < 30 ? 60 + ((bmi - 25) / (30 - 25) * 20) : 
                                                              80 + ((bmi - 30) / (40 - 30) * 20))}%);">
                </div>
                <div class="bmi-indicator-label" style="left: calc(${(bmi < 18.5 ? (bmi / 18.5 * 20) : 
                                                                 bmi < 23 ? 20 + ((bmi - 18.5) / (23 - 18.5) * 20) : 
                                                                      bmi < 25 ? 40 + ((bmi - 23) / (25 - 23) * 20) : 
                                                                      bmi < 30 ? 60 + ((bmi - 25) / (30 - 25) * 20) : 
                                                                      80 + ((bmi - 30) / (40 - 30) * 20))}%);">
                    나의 BMI 지수 <fmt:formatNumber value="${bmi}" type="number" maxFractionDigits="2" />
                </div>
            </div>
        </div>

        <!-- 다시 계산하기 버튼 -->
        <div class="text-center">
            <a href="bmiForm" class="btn btn-custom">다시 계산하기</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS 추가 -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3-alpha3/dist/js/bootstrap.min.js"></script>
</body>
</html>
