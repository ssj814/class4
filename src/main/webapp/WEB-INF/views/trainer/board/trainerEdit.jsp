<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.example.dto.TrainerDTO"%>
<%@page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
TrainerDTO dto = (TrainerDTO) request.getAttribute("info");

String[] fieldOptions = {"웨이트", "재활", "다이어트", "대회준비", "맨몸운동", "바디프로필", "건강관리"};
List<String> fieldlist = Arrays.asList(dto.getField().split(","));

String[] lsProgramOptions = {"개인PT", "그룹PT", "방문PT"};
List<String> lsProgramlist = Arrays.asList(dto.getLesson_program().split(","));

pageContext.setAttribute("fieldOptions", fieldOptions);
pageContext.setAttribute("fieldlist", fieldlist);
pageContext.setAttribute("lsProgramOptions", lsProgramOptions);
pageContext.setAttribute("lsProgramlist", lsProgramlist);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>트레이너 수정</title>
<link rel="stylesheet" type="text/css" href="resources/css/trainer/traineradd.css">  <!-- CSS 파일 링크 -->
</head>
<body>
<div class="trainerContainer">
    <form action="trainer_modify" method="post" enctype="multipart/form-data">
        <input type="hidden" name="trainer_id" value="${info.trainer_id}">
        <!-- 숨겨진 name 필드 추가 -->
        <input type="hidden" name="name" value="${info.name}">
        
        <div class="bodyContainer">
            <h2>트레이너 수정</h2>
        </div>

        <div class="bodyContainer">
            <label class="compulsory">실명</label>
            <input type="text" id="name" name="name_display" value="${info.name}" disabled="disabled">
        </div>

        <div class="bodyContainer">
            <label class="compulsory">닉네임</label>
            <input type="text" id="nickname" name="nickname" value="${info.nickname}">
        </div>

           <div class="bodyContainer">
            <label class="compulsory">지도종목</label>
            <div class="inputGroup">
                <label>
                    <input type="checkbox" class="field" name="field" value="웨이트"><span>웨이트</span>
                </label>
                <label>
                    <input type="checkbox" class="field" name="field" value="재활"><span>재활</span>
                </label>
                <label>
                    <input type="checkbox" class="field" name="field" value="다이어트"><span>다이어트</span>
                </label>
                <label>
                    <input type="checkbox" class="field" name="field" value="대회준비"><span>대회준비</span>
                </label>
                <label>
                    <input type="checkbox" class="field" name="field" value="맨몸운동"><span>맨몸운동</span>
                </label>
                <label>
                    <input type="checkbox" class="field" name="field" value="바디프로필"><span>바디프로필</span>
                </label>
                <label>
                    <input type="checkbox" class="field" name="field" value="건강관리"><span>건강관리</span>
                </label>
            </div>
        </div>

        <div class="bodyContainer">
            <label class="compulsory">소속 센터명</label>
            <input type="text" id="center" name="center_name" value="${info.center_name}">
        </div>

        <div class="bodyContainer">
            <label class="compulsory">소속 센터 주소</label>
            <div>
                <input type="text" id="postcode" name="center_postcode" value="${info.center_postcode}">
                <input type="button" onclick="findpostcode()" value="우편번호 찾기"><br>
                <input type="text" id="centerAddress" name="center_address1" value="${info.center_address1}"><br>
                <input type="text" id="centerAddressDetail" name="center_address2" value="${info.center_address2}">
            </div>
        </div>

        <div class="bodyContainer">
            <label class="compulsory">한줄 소개글 (대표 소개글로 설정됩니다.)</label>
            <input type="text" id="intro" name="intro" value="${info.intro}">
        </div>

        <div class="bodyContainer">
            <label class="compulsory">소개글 및 소개사진</label>
            <textarea id="introDetail" name="content" cols="30" rows="8">${info.content}</textarea>
            <div class="notice">*최소 30자 이상</div>

            <!-- 이미지 업로드 처리 -->
            <input class="imgButton" name="trainer_img_url" type="file"> 사진 추가하기
            <div class="notice">*첫 장이 프로필 사진으로 설정됩니다.</div>
        </div>

        <div class="bodyContainer">
            <label class="compulsory">검증된 자격사항</label>
            <div>
                <select id="certSelect" name="certificate_type">
                    <option value="자격증" <c:if test="${info.certificate_type == '자격증'}">selected</c:if>>자격증</option>
                    <option value="학력" <c:if test="${info.certificate_type == '학력'}">selected</c:if>>학력</option>
                    <option value="수상경력" <c:if test="${info.certificate_type == '수상경력'}">selected</c:if>>수상경력</option>
                </select>
                <input type="text" id="cert" name="certificate" value="${info.certificate}">
            </div>
        </div>

        <div class="bodyContainer">
            <label class="compulsory">레슨 가능 지역</label>
            <div>
                <select name="lesson_area1" id="locSelect"></select>
                <select name="lesson_area2" id="locSelect2"></select>
            </div>
        </div>

        <div class="bodyContainer">
            <label class="compulsory">레슨 프로그램</label>
            <c:forEach items="${lsProgramOptions}" var="lsProgram">
                <label>
                    <input type="checkbox" class="lesson_program" name="lesson_program[]" value="${lsProgram}"
                        <c:if test="${lsProgramlist.contains(lsProgram)}">checked</c:if>> ${lsProgram}
                </label>
            </c:forEach>
        </div>

        <button type="submit">저장</button>
    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	   const areaData = {
	    		  "서울": ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"],
	    		  "인천": ["계양구", "남동구", "동구", "미추홀구", "부평구", "서구", "연수구", "중구"],
	    		  "대전": ["동구", "중구", "서구", "유성구", "대덕구"],
	    		  "광주": ["광산구", "남구", "동구", "북구", "서구"],
	    		  "대구": ["남구", "달서구", "동구", "북구", "서구", "수성구", "중구", "달성군"],
	    		  "울산": ["남구", "동구", "북구", "중구", "울주군"],
	    		  "부산": ["강서구", "금정구", "기장군", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구"],
	    		  "경기도": ["가평군", "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시", "양평군", "여주시", "연천군", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"],
	    		  "강원도": ["강릉시", "고성군", "동해시", "삼척시", "속초시", "양구군", "양양군", "영월군", "원주시", "인제군", "정선군", "철원군", "춘천시", "태백시", "평창군", "홍천군", "화천군", "횡성군"],
	    		  "충청북도": ["괴산군", "단양군", "보은군", "영동군", "옥천군", "음성군", "제천시", "증평군", "진천군", "청주시", "충주시"],
	    		  "충청남도": ["계룡시", "공주시", "금산군", "논산시", "당진시", "보령시", "부여군", "서산시", "서천군", "아산시", "예산군", "천안시", "청양군", "태안군", "홍성군"],
	    		  "전라북도": ["고창군", "군산시", "김제시", "남원시", "무주군", "부안군", "순창군", "완주군", "익산시", "임실군", "장수군", "전주시", "정읍시", "진안군"],
	    		  "전라남도": ["강진군", "고흥군", "곡성군", "광양시", "구례군", "나주시", "담양군", "목포시", "무안군", "보성군", "순천시", "신안군", "여수시", "영광군", "영암군", "완도군", "장성군", "장흥군", "진도군", "함평군", "해남군", "화순군"],
	    		  "경상북도": ["경산시", "경주시", "고령군", "구미시", "군위군", "김천시", "문경시", "봉화군", "상주시", "성주군", "안동시", "영덕군", "영양군", "영주시", "영천시", "예천군", "울릉군", "울진군", "의성군", "청도군", "청송군", "칠곡군", "포항시"],
	    		  "경상남도": ["거제시", "거창군", "고성군", "김해시", "남해군", "밀양시", "사천시", "산청군", "양산시", "의령군", "진주시", "창녕군", "창원시", "통영시", "하동군", "함안군", "함양군", "합천군"],
	    		  "제주도": ["서귀포시", "제주시"]
	    		};

    const area0 = ["시/도", "서울", "인천", "대전", "광주", "대구", "울산", "부산", "경기도", "강원도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주도"];

    // 시/도 선택 초기화
    $("select[name=lesson_area1]").each(function() {
        const $selsido = $(this);
        $.each(area0, function(index, value) {
            $selsido.append("<option value='" + value + "'>" + value + "</option>");
        });
        $selsido.val('${info.lesson_area1}');
    });

    $("select[name=lesson_area2]").each(function() {
        const $gugun = $(this);
        const area = areaData[$("select[name=lesson_area1]").val()];
        $.each(area, function(index, value) {
            $gugun.append("<option value='" + value + "'>" + value + "</option>");
        });
        $gugun.val('${info.lesson_area2}');
    });

    $("select[name=lesson_area1]").change(function() {
        const area = areaData[$(this).val()];
        const $gugun = $(this).next();
        $gugun.empty();  // 기존 옵션 제거

        $.each(area, function(index, value) {
            $gugun.append("<option value='" + value + "'>" + value + "</option>");
        });
    });
});

// 우편번호 찾기
function findpostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            const addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("centerAddress").value = addr;
            document.getElementById("centerAddressDetail").focus();
        }
    }).open();
}
</script>
</html>
