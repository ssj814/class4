<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Air Fryer Cooking Guide</title>
  
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 전체 페이지 스타일 */
        body {
            background-color: #ffffff; /* 흰색 배경 */
            color: #333333; /* 검정에 가까운 어두운 회색 텍스트 */
            font-family: Arial, sans-serif;
            padding-top: 20px;
            text-align: center; /* 텍스트와 이미지를 중앙 정렬 */
        }

        /* 제목 스타일 */
        h1 {
            font-size: 2.5rem; /* 큰 폰트 크기 */
            color: #2c3e50; /* 어두운 블루 그레이 톤 */
            margin-bottom: 40px; /* 제목 아래 여백 */
            font-weight: bold; /* 두꺼운 글꼴 */
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.2); /* 부드러운 그림자 효과 */
        }

        /* 컨테이너 스타일 */
        .container {
            background-color: #f5f5f5; /* 옅은 회색 배경 */
            padding: 20px;
            border-radius: 10px; /* 부드러운 모서리 */
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 효과 */
            border: 2px solid #000000; /* 검정색 테두리 */
            max-width: 500px; /* 최대 너비 설정 */
            margin: auto; /* 가운데 정렬 */
        }

        /* 이미지 스타일 */
        #image {
            width: 100%; /* 이미지가 컨테이너의 너비에 맞게 조정됨 */
            height: auto;
            border-radius: 10px; /* 이미지 모서리를 부드럽게 처리 */
        }

        /* 지침 텍스트 스타일 */
        #instruction {
            font-size: 1.25rem;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<!-- 제목 삽입 -->
<h1>Air Fryer Tips</h1>

<div class="container mt-5">
    <div class="img-container">
        <img id="image" src="resources/img/cookingTip/airfryer/2.jpg" alt="Step 1">
    </div>
    <div id="instruction" class="instruction-text">
        1. 해동된 생선을 흐르는 물에 씻어 주세요
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>


<script>
    const images = [
        {
            src: 'resources/img/cookingTip/airfryer/2.jpg',
            text: '1. 해동된 생선을 흐르는 물에 씻어 주세요'
        },
        {
            src: 'resources/img/cookingTip/airfryer/3.jpg',
            text: '2. 물기를 제거해 주세요'
        },
        {
            src: 'resources/img/cookingTip/airfryer/4.jpg',
            text: '3. 종이 호일을 깔고 생선을 올려주세요'
        },
        {
            src: 'resources/img/cookingTip/airfryer/5.jpg',
            text: '4. 레몬즙이나 소금, 후추로 밑간을 해주세요<br>(레몬즙은 비린내를 잡아주는 효과가 있어요!)'
        },
        {
            src: 'resources/img/cookingTip/airfryer/6.jpg',
            text: '5. 에어프라이어 180도에서 15-20분 조리해주면 완성 :)<br>(냉동 생선은 20-25분 조리!)'
        }
    ];

    let currentIndex = 0;

    function showNextImage() {
        currentIndex++;
        if (currentIndex >= images.length) {
            currentIndex = 0; // 마지막 이미지 후 처음 이미지로 돌아감
        }
        document.getElementById('image').src = images[currentIndex].src;
        document.getElementById('instruction').innerHTML = images[currentIndex].text;
    }

    // 1.5초마다 이미지와 텍스트를 교체
    setInterval(showNextImage, 1500);
</script>

</body>
</html>
    