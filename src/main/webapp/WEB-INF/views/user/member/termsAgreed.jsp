<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>서비스 이용 약관</title>
    <!-- 부트스트랩 CDN 추가 -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .terms-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }
        h3 {
            color: #333;
        }
        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        /* 버튼을 오른쪽 아래에 고정 */
        .agree-button {
            position: fixed;
            right: 30px;
            bottom: 30px;
            z-index: 1000;
        }
    </style>
    
    <script>
	// 동의 버튼 클릭 시 자식 창 닫기
        function agreeAndClose() {
            window.close(); // 창 닫기
        }
</script>
</head>
<body>
    <div class="container">
        <div class="terms-container">
            <h3>이용 약관</h3>
            <p>본 약관은 <strong>핑크덤벨(PKDB)</strong> 웹사이트의 서비스 이용에 관한 조건과 절차, 권리와 의무를 규정합니다.</p>

            <h4>제 1 조 (목적)</h4>
            <p>이 약관은 <strong>핑크덤벨(PKDB)</strong> (이하 "회사"라 한다)에서 제공하는 온라인 쇼핑몰 및 커뮤니티 서비스(이하 "서비스")의 이용에 관한 조건과 절차, 회원과 회사 간의 권리와 의무를 규정함을 목적으로 합니다.</p>

            <h4>제 2 조 (약관의 효력)</h4>
            <p>1. 본 약관은 이용자가 동의하고 회원 가입을 완료한 후부터 효력을 발생합니다.<br>
            2. 회사는 본 약관을 사전 고지 없이 변경할 수 있으며, 변경된 약관은 공지된 날로부터 효력을 발생합니다. 변경된 약관에 동의하지 않는 이용자는 서비스 이용을 중단할 수 있습니다.</p>

            <h4>제 3 조 (서비스의 제공)</h4>
            <p>1. 회사는 쇼핑몰 및 커뮤니티 서비스, 상품 구매 및 판매, 온라인 상담 등의 서비스를 제공합니다.<br>
            2. 회사는 언제든지 서비스의 내용이나 운영 방식을 변경할 수 있습니다.</p>

            <h4>제 4 조 (회원 가입)</h4>
            <p>1. 이용자는 회사가 정한 절차에 따라 회원 가입을 신청할 수 있으며, 회원 가입을 완료한 후 서비스를 이용할 수 있습니다.<br>
            2. 회원 가입 시 제공하는 정보는 정확하고 사실이어야 하며, 이용자는 회원 정보가 변경될 경우 이를 즉시 업데이트해야 합니다.</p>

            <h4>제 5 조 (회원의 의무)</h4>
            <p>1. 이용자는 본 약관 및 회사가 정한 규정을 준수해야 합니다.<br>
            2. 이용자는 서비스 이용 중 다른 이용자의 권리를 침해하거나 불법적인 활동을 하지 않도록 해야 합니다.</p>

            <h4>제 6 조 (개인정보 보호)</h4>
            <p>1. 회사는 이용자의 개인정보 보호를 위해 최선을 다하며, 개인정보 처리 방침에 따라 개인정보를 수집, 이용, 보관합니다.<br>
            2. 이용자는 개인정보 처리 방침에 동의함으로써 회사가 개인정보를 수집하고 이용하는 것에 동의한 것으로 간주됩니다.</p>

            <h4>제 7 조 (상품의 구매)</h4>
            <p>1. 이용자는 사이트를 통해 상품을 구매할 수 있으며, 결제 후 배송을 받게 됩니다.<br>
            2. 상품의 가격, 세금, 배송비 등 모든 비용은 상품 구매 시 명시된 내용을 기준으로 합니다.<br>
            3. 상품 구매 후에는 일정 기간 이내에 취소, 교환, 환불을 요청할 수 있으며, 이는 회사의 교환 및 환불 정책에 따라 처리됩니다.</p>

            <h4>제 8 조 (서비스의 중단 및 제한)</h4>
            <p>1. 회사는 시스템 점검, 정기 점검, 통신 회선 장애 등의 이유로 일시적으로 서비스 이용을 제한할 수 있습니다.<br>
            2. 서비스의 중단이나 제한은 사전에 공지되며, 긴급한 경우 예고 없이 이루어질 수 있습니다.</p>

            <h4>제 9 조 (회사의 면책)</h4>
            <p>1. 회사는 이용자 간의 거래에서 발생한 문제에 대해 책임을 지지 않으며, 이용자는 거래 전 충분히 확인하고 동의한 후 거래를 진행해야 합니다.<br>
            2. 회사는 불가항력적인 사유로 서비스 제공을 하지 못하는 경우 책임을 지지 않습니다.</p>

            <h4>제 10 조 (분쟁 해결)</h4>
            <p>1. 회사와 이용자 간에 발생한 모든 분쟁은 우선적으로 원만한 해결을 위해 상호 협의합니다.<br>
            2. 협의가 이루어지지 않는 경우, 서울중앙지방법원을 제1심 법원으로 하여 해결합니다.</p>

            <h4>제 11 조 (기타)</h4>
            <p>1. 본 약관에 명시되지 않은 사항은 관련 법령 및 회사의 정책에 따릅니다.<br>
            2. 본 약관은 2024년 11월 20일부터 시행됩니다.</p>

            <!-- 동의 버튼을 오른쪽 아래에 고정 -->
            <button class="agree-button" type="button" onclick="agreeAndClose()">동의합니다</button>
        </div>
    </div>

    <!-- 부트스트랩 JS 및 Popper.js 추가 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
