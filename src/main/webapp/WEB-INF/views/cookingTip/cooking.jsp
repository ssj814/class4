<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>♥Cooking Tips♥</title>
  
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #ffffff; /* 흰색 배경 */
            font-family: 'Arial', sans-serif;
            color: #333333; /* 어두운 회색 텍스트 색상 */
            padding-top: 50px; /* 상단 여백 */
        }

        .clickable-image {
            width: 100%;
            max-width: 350px; /* 이미지의 최대 너비 */
            height: auto;
            border-radius: 10px; /* 부드러운 모서리 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 */
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .clickable-image:hover {
            transform: translateY(-10px); /* 마우스 오버 시 이미지가 살짝 떠오름 */
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* 그림자 확대 */
        }

        h1 {
            font-size: 2.5rem;
            margin-bottom: 50px; /* 타이틀과 이미지 사이의 간격 */
            color: #111111; /* 진한 검정색 */
            text-align: center;
        }

        p {
            margin-top: 15px;
            font-size: 1.25rem;
            color: #333333; /* 어두운 회색 텍스트 색상 */
        }

        .container {
            background-color: #f5f5f5; /* 옅은 회색 배경 */
            padding: 20px;
            border-radius: 10px; /* 컨테이너의 부드러운 모서리 */
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* 컨테이너에 부드러운 그림자 추가 */
            border: 1px solid #333333; /* 검정색 테두리 */
        }

        /* 이미지 설명을 가운데 정렬 */
        .text-center img {
            margin-bottom: 15px; /* 이미지와 텍스트 사이의 여백 */
        }

        /* 이미지와 텍스트를 담고 있는 박스를 가운데 정렬 */
        .img-text-container {
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Cooking Tips</h1>
    <div class="row">
        <div class="col-md-6 mb-4 img-text-container">
            <img src="resources/img/cookingTip/airfryer/1.jpg" class="img-fluid clickable-image" data-url="page1" alt="Air Fryer Tips">
            <p>에어프라이어 Tips</p>
        </div>
        <div class="col-md-6 mb-4 img-text-container">
            <img src="resources/img/cookingTip/fryingpan/1.jpg" class="img-fluid clickable-image" data-url="page2" alt="Frying Pan Tips">
            <p>프라이팬 Tips</p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6 mb-4 img-text-container">
            <img src="resources/img/cookingTip/microwave/1.jpg" class="img-fluid clickable-image" data-url="page3" alt="Microwave Tips">
            <p>전자레인지 Tips</p>
        </div>
        <div class="col-md-6 mb-4 img-text-container">
            <img src="resources/img/cookingTip/microwaveable bowl/1.jpg" class="img-fluid clickable-image" data-url="page4" alt="Microwaveable Bowl Tips">
            <p>전자레인지 용기 Tips</p>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>


<script>
    $(document).ready(function(){
        $('.clickable-image').on('click', function(){
            var url = $(this).data('url');
            window.location.href = "cookingTip_page?num="+url;
        });
    });
</script>

</body>
</html>