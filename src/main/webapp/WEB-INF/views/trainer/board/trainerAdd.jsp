<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" type="text/css" href="resources/css/trainer/traineradd.css">  <!-- CSS 파일 링크 -->

<div class="trainerContainer">

    <form action="trainer_join" method="post" enctype="multipart/form-data">
        <div class="bodyContainer">
            <h2>트레이너 등록</h2>
        </div>
        
        <div class="bodyContainer">
            <label class="compulsory">실명</label>
            <input type="text" id="name" name="name" placeholder="실명을 입력해주세요." required>
        </div>
        
        <div class="bodyContainer">
            <label class="compulsory">닉네임</label>
            <input type="text" id="nickname" name="nickname" placeholder="센터에서 사용하는 이름을 입력해주세요." required>
        </div>
        
        <div class="bodyContainer">
            <label class="compulsory">성별</label>
            <div class="inputGroup">
                <label>
                    <input type="radio" id="male" name="gender" value="남자"><span>남자</span>
                </label>
                <label>
                    <input type="radio" id="female" name="gender" value="여자" class="ms-3"><span>여자</span>
                </label>
            </div>
        </div>
        
        <div class="bodyContainer">
	         <label class="compulsory">지도종목</label>
	         <div class="inputGroup">
	         	<c:forEach var="field" items="${fieldOptions}" begin="1" end="${fieldOptions.size() - 1}" varStatus="status">
					<input type="checkbox" class="field me-1" name="field" value="${field}" id="${status.index}"><label for="${status.index}" class="me-3">${field}</label>
				</c:forEach>
	         </div>
        </div>
                
        <div class="bodyContainer">
            <label class="compulsory">소속 센터명</label>
            <input type="text" id="center" name="center_name" placeholder="활동중인 센터명을 입력해주세요." required>
        </div>
        
        <div class="bodyContainer">
            <label class="compulsory">소속 센터 주소</label>
            <div>
                <input type="text" id="postcode" name="center_postcode" placeholder="우편번호" required>
                <input type="button" onclick="findpostcode()" value="우편번호 찾기"><br>
                <input type="text" id="centerAddress" name="center_address1" placeholder="주소" required><br>
                <input type="text" id="centerAddressDetail" name="center_address2" placeholder="상세주소" required>
            </div>
        </div>
        
        <div class="bodyContainer">
            <label class="compulsory">한줄 소개글 (대표 소개글로 설정됩니다.)</label>
            <input type="text" id="intro" name="intro" required>
        </div>
        
        <div class="bodyContainer">
            <label class="compulsory">소개글 및 소개사진</label>
            <textarea id="introDetail" name="content" cols="30" rows="8" required></textarea>
            <div class="notice">*최소 30자 이상</div>
            
            <!-- 이미지 파일 업로드 -->
            <input class="imgButton" name="trainer_img_url" type="file"> 사진 추가하기
            <div class="notice">*첫 장이 프로필 사진으로 설정됩니다.</div>
        </div>
        
        <div class="bodyContainer">
            <label class="compulsory">검증된 자격사항</label>
            <div id="certContainer">
                <select class="certSelect" name="certificate_type">
                    <option>자격증</option>
                    <option>학력</option>
                    <option>수상경력</option>
                </select>
                <input type="text" class="cert" name="certificate" placeholder="내용을 입력해주세요." required>
                <button id="certAddButton">추가하기</button>
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
            <input type="checkbox" name="lesson_program" value="개인PT">개인PT
            <input type="checkbox" name="lesson_program" value="그룹PT">그룹PT
            <input type="checkbox" name="lesson_program" value="방문PT">방문PT
        </div>
        
        <button type="submit">등록</button>
    </form>
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$('document').ready(function() {
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
    
    // 시/도 선택 박스 초기화
    $("select[name=lesson_area1]").each(function() {
        $selsido = $(this);
        $.each(area0, function(index, value) {
            $selsido.append("<option value='" + value + "'>" + value + "</option>");
        });
        $selsido.next().append("<option value=''>구/군</option>");
    });

    // 시/도 선택시 구/군 설정
    $("select[name=lesson_area1]").change(function() {
        const selectedSido = $(this).val();
        const $gugun = $(this).next();
        $gugun.empty(); // 기존 구/군 옵션 제거

        if (selectedSido === "시/도") {
            $gugun.append("<option value=''>구/군 선택</option>");
        } else {
            const gugunList = areaData[selectedSido]; // 선택된 시/도의 구/군 목록
            if (gugunList) {
                $.each(gugunList, function(index, value) {
                    $gugun.append("<option value='" + value + "'>" + value + "</option>");
                });
            }
        }
    });
});

// 우편번호 찾기
function findpostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = '';
            var extraAddr = '';
            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
            } else {
                addr = data.jibunAddress;
            }

            if(data.userSelectedType === 'R'){
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
            }

            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("centerAddress").value = addr + " " + extraAddr;
            document.getElementById("centerAddressDetail").focus();
        }
    }).open();
}

$("#certAddButton").on("click", function(event) {
    event.preventDefault();
    $("#certContainer").append(
        "<select class='certSelect' name='certificate_type'>" +
        "<option>자격증</option><option>학력</option><option>수상경력</option></select>" +
        "<input type='text' class='cert' name='certificate' placeholder='내용을 입력해주세요.'>");
    return false;
});
</script>

