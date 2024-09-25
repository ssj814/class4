<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Microwave Cooking Guide</title>
 
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #dcdcdc;
            color: #000000;
            font-family: Arial, sans-serif;
            padding-top: 20px;
        }

        h1 {
            font-size: 2rem;
            color: #000000;
            margin-bottom: 40px;
            font-weight: bold;
            text-align: center;
        }

        .container {
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: auto;
            border: 2px solid #000000;
            background-color: #f0f0f0;
        }

        .img-fluid {
            max-width: 100%; /* 이미지의 최대 너비를 컨테이너에 맞춤 */
            height: auto; /* 이미지 비율 유지 */
            border-radius: 4px;
            margin-bottom: 15px;
        }

        .instruction-text {
            font-size: 1rem;
            margin-top: 10px;
            padding: 10px;
            border: 1px solid #000000;
            border-radius: 4px;
            background-color: #f9f9f9;
            box-sizing: border-box;
        }

        .row {
            margin-bottom: 20px;
        }

        .col-md-6 {
            padding: 10px; /* 이미지와 텍스트 간격 */
        }

    </style>
</head>
<body>

<h1>Microwave Cooking Guide</h1>

<div class="container">
    <div class="row">
        <div class="col-md-6">
            <img src="resources/img/cookingTip/microwave/2.jpg" class="img-fluid" alt="Step 1">
        </div>
        <div class="col-md-6">
            <p class="instruction-text">1. 해동된 생선을 흐르는 물에 씻어 주세요</p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <img src="resources/img/cookingTip/microwave/3.jpg" class="img-fluid" alt="Step 2">
        </div>
        <div class="col-md-6">
            <p class="instruction-text">2. 물기를 제거해 주세요</p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <img src="resources/img/cookingTip/microwave/4.jpg" class="img-fluid" alt="Step 3">
        </div>
        <div class="col-md-6">
            <p class="instruction-text">3. 레몬즙이나 소금, 후추로 밑간을 해주세요<br>(레몬즙은 비린내를 잡아주는 효과가 있습니다)</p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <img src="resources/img/cookingTip/microwave/4.jpg" class="img-fluid" alt="Step 4">
        </div>
        <div class="col-md-6">
            <p class="instruction-text">4. 랩을 씌우고 포크로 구멍을 뚫어주세요</p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <img src="resources/img/cookingTip/microwave/5.jpg" class="img-fluid" alt="Step 5">
        </div>
        <div class="col-md-6">
            <p class="instruction-text">5. 전자레인지로 3분 조리해주면 완성</p>
        </div>
    </div>
</div>

</body>
</html>
