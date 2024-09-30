<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ECharts 예제 - 그래프 비교</title>

<!-- ECharts 라이브러리와 jQuery를 사용하기 위해 CDN을 통해 스크립트를 불러옵니다. -->
<script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f7f7f7;
    }

    h3 {
        margin-top: 0;
        color: #333;
    }

    .container {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-bottom: 20px;
    }

    #chart {
        width: 100%;
        height: 450px;
        margin-bottom: 20px;
        border: 1px solid #e7e7e7;
        border-radius: 5px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        background-color: #fff;
    }

    .form-wrapper {
        display: flex;
        justify-content: space-between;
        width: 100%;
        max-width: 1200px;
    }

    .form-container, .user-input-container {
        background: #fff;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        width: 48%; /* 양쪽에 배치된 폼의 너비 */
        min-width: 300px; /* 입력 필드 크기 고정 */
    }

    label {
        display: inline-block;
        margin-bottom: 5px;
        font-weight: bold;
        color: #555;
        font-size: 12px;
    }

    input, select {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 12px;
    }

    select {
        background-color: #f9f9f9;
        cursor: pointer;
    }

    button {
        background-color: #007bff;
        color: white;
        padding: 8px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 12px;
    }

    button:hover {
        background-color: #0056b3;
    }

    .gender-and-button {
        display: flex;
        gap: 10px;
        align-items: center;
        margin-bottom: 10px;
    }

    .gender-and-button select {
        flex: 1;
    }

    .gender-and-button button {
        flex: 1;
        max-width: 100px;
    }

</style>
</head>
<body>

<div class="container">
    <!-- 차트가 표시될 영역 -->
    <div id="chart"></div>

    <!-- 폼들을 좌우로 배치하기 위한 wrapper -->
    <div class="form-wrapper">
        <!-- 기존 데이터 표시 영역 -->
        <div class="form-container">
            <h3>하루 일일 권장 섭취량</h3>
            <!-- 서버로부터 받아온 데이터를 표시하기 위한 입력 필드들 (읽기 전용) -->
            <label for="dbEnergy">에너지(kcal):</label> 
            <input type="number" id="dbEnergy" readonly><br>
            <label for="dbCarbohydrate">탄수화물(g):</label>
            <input type="number" id="dbCarbohydrate" readonly><br>
            <label for="dbSugars">당류(g):</label>
            <input type="number" id="dbSugars" readonly><br>
            <label for="dbProtein">단백질(g):</label>
            <input type="number" id="dbProtein" readonly><br>
            <label for="dbFat">지방(g):</label>
            <input type="number" id="dbFat" readonly><br>
            <label for="dbSaturatedFat">포화지방(g):</label>
            <input type="number" id="dbSaturatedFat" readonly><br>
            <label for="dbSodium">나트륨(mg):</label>
            <input type="number" id="dbSodium" readonly><br>

            <!-- 성별 선택과 발행 버튼을 같은 줄에 배치 -->
            <div class="gender-and-button">
                <select id="genderSelect" name="gender">
                    <option value="1">남자</option>
                    <option value="2">여자</option>
                </select>

                <button type="button" onclick="fetchData()">발행</button> <!-- 버튼 클릭 시 fetchData() 함수 실행 -->
            </div>
        </div>

        <!-- 사용자 입력 영역 -->
        <div class="user-input-container">
            <h3>사용자 일일 섭취량</h3>
            <!-- 사용자가 직접 입력할 수 있는 필드들 -->
            <label for="energy">에너지(kcal):</label> 
            <input type="number" id="energy"><br>
            <label for="carbohydrate">탄수화물(g):</label>
            <input type="number" id="carbohydrate"><br>
            <label for="sugars">당류(g):</label>
            <input type="number" id="sugars"><br>
            <label for="protein">단백질(g):</label>
            <input type="number" id="protein"><br>
            <label for="fat">지방(g):</label>
            <input type="number" id="fat"><br>
            <label for="saturatedFat">포화지방(g):</label>
            <input type="number" id="saturatedFat"><br>
            <label for="sodium">나트륨(mg):</label>
            <input type="number" id="sodium"><br>

            <!-- 버튼 클릭 시 updateChart() 함수 실행 -->
            <button type="button" onclick="updateChart()">차트 업데이트</button>
        </div>
    </div>
</div>

<!-- 서버로 POST 요청을 보내는 성별 선택 -->

<script>
// 차트를 표시할 DOM 요소와 초기화 설정
var dom = document.getElementById('chart');
var myChart = echarts.init(dom);

// 초기 데이터 설정
var dbData = [0, 0, 0, 0, 0, 0, 0];  // 서버에서 받아오는 데이터
var userInputData = [0, 0, 0, 0, 0, 0, 0]; // 사용자가 입력한 데이터를 저장하는 배열
var maxValues = [3000, 200, 100, 100, 100, 100, 3000]; // 각 영양성분의 최대값 설정

// 차트의 기본 옵션 설정
var option = {
    title: {
        text: '1일 영양성분 기준치(%) 비교 그래프'
    },
    legend: {
        data: ['기존 섭취량', '사용자 입력 섭취량'] // 차트 범례
    },
    radar: {
        indicator: [
            {name: '에너지 (kcal): 일일 섭취량:0 사용자 섭취량: 0', max: 3000},
            {name: '탄수화물 (g): 일일 섭취량:0 사용자 섭취량: 0', max: 200},
            {name: '당류 (g): 일일 섭취량:0 사용자 섭취량: 0', max: 100},
            {name: '단백질 (g): 일일 섭취량:0 사용자 섭취량: 0', max: 100},
            {name: '지방 (g): 일일 섭취량:0 사용자 섭취량: 0', max: 100},
            {name: '포화지방 (g): 일일 섭취량:0 사용자 섭취량: 0', max: 100},
            {name: '나트륨 (mg): 일일 섭취량:0 사용자 섭취량: 0', max: 3000}
        ]
    },
    series: [{
        name: '영양성분 섭취량 비교',
        type: 'radar',
        data: [
            {
                value: dbData,  // 기존 섭취량 데이터
                name: '기존 섭취량'
            },
            {
                value: userInputData,  // 사용자 입력 데이터
                name: '사용자 입력 섭취량'
            }
        ]
    }]
};

// 차트에 옵션 설정 적용
myChart.setOption(option);

// 서버에서 데이터를 가져오는 함수
function fetchData() {
    var gender = $('#genderSelect').val(); // 선택된 성별을 가져옵니다.
    $.ajax({
        url: 'Chart', // 요청할 URL
        method: 'POST', // 요청 방법
        data: { gender: gender }, // 전송할 데이터
        success: function(response) {
            console.log("서버 응답 데이터:", response); // 디버그용 로그
            var data = response;  // 서버로부터 받은 응답 데이터
            updateDbFields(data);  // 받은 데이터로 입력 필드 업데이트
            updateChartWithData(data); // 차트를 업데이트
        },
        error: function(xhr, status, error) {
            console.error("Error fetching data:", error); // 에러 발생 시 로그 출력
        }
    });
}

// 서버에서 받은 데이터를 입력 필드에 표시하는 함수
function updateDbFields(data) {
    // 서버에서 받은 데이터를 필드에 표시
    $('#dbEnergy').val(data.energy);
    $('#dbCarbohydrate').val(data.carbs);
    $('#dbSugars').val(data.sugar);
    $('#dbProtein').val(data.protein);
    $('#dbFat').val(data.fat);
    $('#dbSaturatedFat').val(data.satFat);
    $('#dbSodium').val(data.sodium);

    // 데이터베이스 값 업데이트 (최대값 초과 방지)
    dbData = [
        Math.min(data.energy, maxValues[0]),
        Math.min(data.carbs, maxValues[1]),
        Math.min(data.sugar, maxValues[2]),
        Math.min(data.protein, maxValues[3]),
        Math.min(data.fat, maxValues[4]),
        Math.min(data.satFat, maxValues[5]),
        Math.min(data.sodium, maxValues[6])
    ];
}

// 차트를 서버에서 받은 데이터로 업데이트하는 함수
function updateChartWithData(data) {
    // 기존 사용자 입력 값을 유지한 상태에서 차트를 업데이트
    myChart.setOption({
        radar: {
            indicator: [
                {name: '에너지 (kcal): 일일 섭취량 ' + dbData[0] + ' 사용자 섭취량 ' + userInputData[0], max: 3000},
                {name: '탄수화물 (g): 일일 섭취량 ' + dbData[1] + ' 사용자 섭취량 ' + userInputData[1], max: 200},
                {name: '당류 (g): 일일 섭취량 ' + dbData[2] + ' 사용자 섭취량 ' + userInputData[2], max: 100},
                {name: '단백질 (g): 일일 섭취량 ' + dbData[3] + ' 사용자 섭취량 ' + userInputData[3], max: 100},
                {name: '지방 (g): 일일 섭취량 ' + dbData[4] + ' 사용자 섭취량 ' + userInputData[4], max: 100},
                {name: '포화지방 (g): 일일 섭취량 ' + dbData[5] + ' 사용자 섭취량 ' + userInputData[5], max: 100},
                {name: '나트륨 (mg): 일일 섭취량 ' + dbData[6] + ' 사용자 섭취량 ' + userInputData[6], max: 3000}
            ]
        },
        series: [{
            data: [
                {value: dbData, name: '기존 섭취량'},
                {value: userInputData, name: '사용자 입력 섭취량'}
            ]
        }]
    });
}

// 사용자가 입력한 데이터로 차트를 업데이트하는 함수
function updateChart() {
    // 사용자가 입력한 데이터를 가져와 전역 변수에 저장
    var energy = Math.min(parseFloat($('#energy').val()) || 0, maxValues[0]);
    var carbohydrate = Math.min(parseFloat($('#carbohydrate').val()) || 0, maxValues[1]);
    var sugars = Math.min(parseFloat($('#sugars').val()) || 0, maxValues[2]);
    var protein = Math.min(parseFloat($('#protein').val()) || 0, maxValues[3]);
    var fat = Math.min(parseFloat($('#fat').val()) || 0, maxValues[4]);
    var saturatedFat = Math.min(parseFloat($('#saturatedFat').val()) || 0, maxValues[5]);
    var sodium = Math.min(parseFloat($('#sodium').val()) || 0, maxValues[6]);

    userInputData = [energy, carbohydrate, sugars, protein, fat, saturatedFat, sodium];

    // 차트의 이름을 동적으로 업데이트
    myChart.setOption({
        radar: {
            indicator: [
                {name: '에너지 (kcal): 일일 섭취량 ' + dbData[0] + ' 사용자 섭취량 ' + userInputData[0], max: 3000},
                {name: '탄수화물 (g): 일일 섭취량 ' + dbData[1] + ' 사용자 섭취량 ' + userInputData[1], max: 200},
                {name: '당류 (g): 일일 섭취량 ' + dbData[2] + ' 사용자 섭취량 ' + userInputData[2], max: 100},
                {name: '단백질 (g): 일일 섭취량 ' + dbData[3] + ' 사용자 섭취량 ' + userInputData[3], max: 100},
                {name: '지방 (g): 일일 섭취량 ' + dbData[4] + ' 사용자 섭취량 ' + userInputData[4], max: 100},
                {name: '포화지방 (g): 일일 섭취량 ' + dbData[5] + ' 사용자 섭취량 ' + userInputData[5], max: 100},
                {name: '나트륨 (mg): 일일 섭취량 ' + dbData[6] + ' 사용자 섭취량 ' + userInputData[6], max: 3000}
            ]
        },
        series: [{
            data: [
                {
                    value: dbData, // 기존 섭취량 유지
                    name: '기존 섭취량'
                },
                {
                    value: userInputData, // 사용자가 입력한 섭취량
                    name: '사용자 입력 섭취량'
                }
            ]
        }]
    });
}

// 브라우저 창 크기 변경 시 차트를 리사이징
window.addEventListener('resize', function() {
    myChart.resize();
});
</script>

</body>
</html>
