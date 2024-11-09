<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>♥Cooking Tips♥</title>
  
    
    
<style>
    /* 전체 페이지 높이와 레이아웃 설정 */
    html, body {
        height: 100%;
        margin: 0;
        display: flex;
        flex-direction: column;
        background-color: #f5f5f5; 
    }

    /* 콘텐츠 영역이 남은 공간을 차지하도록 설정 */
    main {
        flex: 1;
        padding: 20px 20px 10px; 
        margin-bottom: 0; 
    }

    body {
        font-family: 'Arial', sans-serif;
        color: #000000; 
    }

    .clickable-image {
        width: 100%;
        max-width: 350px; 
        height: auto;
        border-radius: 10px; 
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .clickable-image:hover {
        transform: translateY(-10px); 
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); 
    }

    h1 {
        font-size: 2.5rem;
        margin-bottom: 30px; 
        color: #000000; 
        text-align: center;
    }

    p {
        margin-top: 15px;
        font-size: 1.0rem;
       /* color: #000000;  */
    }

    /* 이미지와 텍스트를 담고 있는 박스를 가운데 정렬 */
    .img-text-container {
        text-align: center;
        margin-bottom: 10px; 
    }
    
   footer.bg-dark {
        padding-top: 8.5px !important;
        padding-bottom: 25.5px !important;
    }
    
</style>


</head>
<body>
<main>
    <h1>Cooking Tips</h1>
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-4 img-text-container">
            <img src="resources/img/cookingTip/airfryer/1.jpg" class="img-fluid clickable-image" data-url="page1" alt="Air Fryer Tips">
            <p>에어프라이어 Tip</p>
        </div>
        <div class="col-md-6 col-lg-4 img-text-container">
            <img src="resources/img/cookingTip/fryingpan/1.jpg" class="img-fluid clickable-image" data-url="page2" alt="Frying Pan Tips">
            <p>프라이팬 Tip</p>
        </div>
    </div>
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-4 img-text-container">
            <img src="resources/img/cookingTip/microwave/1.jpg" class="img-fluid clickable-image" data-url="page3" alt="Microwave Tips">
            <p>전자레인지 Tip</p>
        </div>
        <div class="col-md-6 col-lg-4 img-text-container">
            <img src="resources/img/cookingTip/microwaveable bowl/1.jpg" class="img-fluid clickable-image" data-url="page4" alt="Microwaveable Bowl Tips">
            <p>전자레인지 용기 Tip</p>
        </div>
    </div>
</main>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

<script>
    $(document).ready(function(){
        $('.clickable-image').on('click', function(){
            var url = $(this).data('url');
            window.location.href = "cookingTip_page?num=" + url;
        });
    });
</script>

</body>
</html>
