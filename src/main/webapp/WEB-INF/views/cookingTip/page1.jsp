<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="../common/header.jsp" flush="true"></jsp:include>

<style>
    body {
        color: #000000;
        font-family: Arial, sans-serif;
        padding-top: 80px; 
        margin: 0;
    }

    h1 {
        font-size: 2rem;
        color: #000000;
        margin-bottom: 40px;
        font-weight: bold;
        text-align: center;
    }

    .container1 {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        padding: 20px;
        max-width: 100%;
        margin: 0 auto; 
    }

    .item {
        text-align: center;
        margin: 10px;
    }

    .img-fluid {
        max-width: 100%;
        height: auto;
        border-radius: 4px;
    }

    .instruction-text {
        font-size: 1rem;
        margin-top: 10px;
        padding: 10px;
        border: 1px solid #000000;
        border-radius: 4px;
        background-color: #f9f9f9;
    }

    .item-container {
        width: calc(20% - 20px); 
        min-width: 200px;
        box-sizing: border-box;
    }

    /* footer 높이 및 중앙 정렬 조정 */
    footer.bg-dark {
        padding-top: 23.3px !important;
        padding-bottom: 25.5px !important;
    }
</style>
</head>
<body>

<h1>에어프라이어 조리법🧡</h1>

<div class="container1">
    <div class="item item-container">
        <img src="resources/img/cookingTip/airfryer/2.jpg" class="img-fluid" alt="Step 1">
        <p class="instruction-text">1. 해동된 생선을 흐르는 물에 씻어 주세요</p>
    </div>
    <div class="item item-container">
        <img src="resources/img/cookingTip/airfryer/3.jpg" class="img-fluid" alt="Step 2">
        <p class="instruction-text">2. 물기를 제거해 주세요</p>
    </div>
    <div class="item item-container">
        <img src="resources/img/cookingTip/airfryer/4.jpg" class="img-fluid" alt="Step 3">
        <p class="instruction-text">3. 종이 호일을 깔고 생선을 올려주세요</p>
    </div>
    <div class="item item-container">
        <img src="resources/img/cookingTip/airfryer/5.jpg" class="img-fluid" alt="Step 4">
        <p class="instruction-text">4. 레몬즙이나 소금, 후추로 밑간을 해주세요<br>(레몬즙은 비린내를 잡아주는 효과가 있어요!)</p>
    </div>
    <div class="item item-container">
        <img src="resources/img/cookingTip/airfryer/6.jpg" class="img-fluid" alt="Step 5">
        <p class="instruction-text">5. 에어프라이어 180도에서 15-20분 조리해주면 완성 :)<br>(냉동 생선은 20-25분 조리!)</p>
    </div>
</div>

<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>

</body>
</html>
