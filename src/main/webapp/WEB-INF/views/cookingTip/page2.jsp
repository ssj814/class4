<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Frying Pan Cooking Guide</title>
    
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 전체 페이지 스타일 */
        body {
            background-color: #ffffff; /* 흰색 배경 */
            color: #000000; /* 검정색 텍스트 */
            font-family: Arial, sans-serif;
            margin: 0; /* 페이지 기본 여백 제거 */
            padding: 0;
            display: flex;
            flex-direction: column; /* 세로 방향으로 레이아웃 설정 */
            align-items: center; /* 수평 중앙 정렬 */
            min-height: 100vh; /* 최소 높이 설정 */
            overflow-x: hidden; /* 수평 스크롤 비활성화 */
        }

        /* 제목 스타일 */
        h1 {
            font-size: 2.5rem; /* 큰 폰트 크기 */
            color: #000000; /* 검정색 텍스트 */
            margin: 40px 0; /* 제목 위와 아래 여백 */
            font-weight: bold; /* 두꺼운 글꼴 */
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.5); /* 부드러운 검정색 그림자 효과 */
            text-align: center; /* 중앙 정렬 */
        }

        /* 중앙에 위치한 컨테이너 스타일 */
        .container-wrapper {
            display: flex;
            justify-content: center; /* 수평 중앙 정렬 */
            width: 100%;
            margin-top: 20px; /* 제목 아래 여백 */
        }

        .container {
            background-color: #f5f5f5; /* 옅은 회색 배경 */
            padding: 20px;
            border-radius: 10px; /* 부드러운 모서리 */
            border: 2px solid #000000; /* 검정색 테두리 */
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2); /* 부드러운 검정색 그림자 효과 */
            max-width: 800px; /* 최대 너비 설정 */
            width: 100%; /* 너비 비율 설정 */
            position: relative; /* 상대적 위치 */
            min-height: 800px; /* 최소 높이 설정 */
            overflow: auto; /* 내용이 박스를 넘을 때 스크롤 표시 */
        }

        /* 이미지와 텍스트를 담는 박스 스타일 */
        .content {
            width: 100%;
            height: auto; /* 내용에 맞춰 높이 조정 */
        }

        /* 이미지 스타일 */
        .img-fluid {
            width: 100%; /* 박스에 맞춰 이미지 크기 조정 */
            height: auto; /* 이미지 비율 유지 */
            border-radius: 8px; /* 이미지 모서리를 부드럽게 처리 */
            margin-bottom: 15px; /* 이미지와 텍스트 사이 여백 */
        }

        /* 지침 텍스트 스타일 */
        .instruction-text {
            font-size: 1rem; /* 기본 폰트 크기 설정 */
            color: #000000; /* 검정색 텍스트 */
            margin-top: 10px;
            padding: 10px; /* 텍스트 박스 내부 여백 */
            border: 1px solid #000000; /* 검정색 테두리 */
            border-radius: 5px; /* 텍스트 박스 모서리를 부드럽게 처리 */
            background-color: #ffffff; /* 텍스트 박스 배경 색상 */
            box-sizing: border-box; /* 테두리와 패딩을 박스 크기에 포함 */
            width: 100%; /* 박스에 맞춰 텍스트 박스 크기 조정 */
        }

        /* 크기 조절 핸들 스타일 */
        .resize-handle {
            width: 15px;
            height: 15px;
            background: #cccccc; /* 옅은 회색 배경 */
            border: 2px solid #000000; /* 검정색 테두리 */
            position: absolute;
            right: 0;
            bottom: 0;
            cursor: nwse-resize; /* 크기 조절 커서 */
            border-radius: 0 0 0 10px; /* 핸들의 모서리 처리 */
        }
    </style>
</head>
<body>

<!-- 제목 삽입 -->
<h1>Frying Pan Cooking Guide</h1>

<!-- 크기 조절 가능한 박스를 가운데 정렬한 래퍼 -->
<div class="container-wrapper">
    <div class="container" id="resizable-container">
        <!-- 크기 조절 핸들 -->
        <div class="resize-handle"></div>

        <div class="content">
            <!-- 이미지와 텍스트를 나란히 배치 -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <img src="resources/img/cookingTip/fryingpan/2.jpg" class="img-fluid" alt="Step 1">
                </div>
                <div class="col-md-6 d-flex align-items-center">
                    <p class="instruction-text">1. 해동된 생선을 흐르는 물에 씻어 주세요</p>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-6">
                    <img src="resources/img/cookingTip/fryingpan/3.jpg" class="img-fluid" alt="Step 2">
                </div>
                <div class="col-md-6 d-flex align-items-center">
                    <p class="instruction-text">2. 물기를 제거해 주세요</p>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-6">
                    <img src="resources/img/cookingTip/fryingpan/4.jpg" class="img-fluid" alt="Step 3">
                </div>
                <div class="col-md-6 d-flex align-items-center">
                    <p class="instruction-text">3. 레몬즙이나 소금, 후추로 밑간을 해주세요<br>(레몬즙은 비릿내를 잡아주는 효과가 있습니다)</p>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-6">
                    <img src="resources/img/cookingTip/fryingpan/5.jpg" class="img-fluid" alt="Step 4">
                </div>
                <div class="col-md-6 d-flex align-items-center">
                    <p class="instruction-text">4. 달궈진 프라이팬에 기름을 적당량 둘러주세요</p>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-6">
                    <img src="resources/img/cookingTip/fryingpan/7.jpg" class="img-fluid" alt="Step 5">
                </div>
                <div class="col-md-6 d-flex align-items-center">
                    <p class="instruction-text">5. 중불에서 노릇하게 구워주면 완성입니다 ~!</p>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>


<script>
    $(document).ready(function() {
        var $container = $('#resizable-container');
        var $handle = $container.find('.resize-handle');
        var isResizing = false;

       
        $handle.on('mousedown', function(e) {
            e.preventDefault();
            isResizing = true;
            $(document).on('mousemove', function(e) {
                var width = e.pageX - $container.offset().left;
                var height = e.pageY - $container.offset().top;

                $container.css({
                    width: Math.max(width, 300) + 'px', // 최소 너비 설정
                    height: Math.max(height, 300) + 'px' // 최소 높이 설정
                });
            }).on('mouseup', function() {
                $(document).off('mousemove mouseup');
                isResizing = false;
            });
        });

        function centerContainer() {
            var containerWrapper = $('.container-wrapper');
            containerWrapper.css({
                marginTop: $('h1').outerHeight() + 20 + 'px' // 제목 아래 여백 추가
            });
        }

        
        $(window).on('resize', centerContainer).trigger('resize');
    });
</script>

</body>
</html>
    