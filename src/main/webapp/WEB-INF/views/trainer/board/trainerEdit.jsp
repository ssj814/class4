<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.example.dto.TrainerDTO"%>
<%@page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
TrainerDTO dto = (TrainerDTO)request.getAttribute("info");

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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="resources/css/trainer/traineradd.css">  <!-- CSS 파일 링크 -->
</head>
<body>
<div class="trainerContainer">
	<form action="trainer_modify" method="post">
	<!-- 트레이너 아이디 히든으로 넘기기 -> 수정 시 where idx 선택 -->
	<input type="hidden" name="trainer_id" value="${info.trainer_id}">
	<input type="hidden" name="name" value="${info.trainer_id}">
	<input type="hidden" name="gender" value="${info.gender}">
		<div class="bodyContainer">
		<h2>트레이너 수정</h2>
		</div>
		
		<div class="bodyContainer">
		<label class="compulsory">실명</label>
		<input type="text" id="name" name="name" value="${info.name}" disabled="disabled">
		</div>
		
		<div class="bodyContainer">
		<label class="compulsory">닉네임</label>
		<input type="text" id="nickname" name="nickname" value="${info.nickname}">
		</div>
		
		<div class="bodyContainer">
			<label class="compulsory">지도종목</label>
			<div class="inputGroup">
				<c:forEach items="${fieldOptions}" var="field">
					<label>
				        <input type="checkbox" class="field" name="field" value="${field}"
				        	 <c:if test="${fieldlist.contains(field)}">checked</c:if>><span>${field}</span>
				    </label>
				</c:forEach>
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
				<textarea id="introDetail" name="content" cols="30" rows="8" >${info.content}</textarea>
				<div class="notice">*최소 30자 이상</div>
				
				<input class="imgButton" name="img_url" type="file">사진 추가하기
				<div class="notice">*첫 장이 프로필 사진으로 설정됩니다.</div>
	  </div>
	  
	  <div class="bodyContainer">
			<label class="compulsory">검증된 자격사항</label>
			<div>
				<select id="certSelect" name="certificate_type">
					<option <c:if test="$info.certificate_type.equals('자격증'))">selected</c:if>>자격증</option>
					<option <c:if test="$info.certificate_type.equals('학력'))">selected</c:if>>학력</option>
					<option <c:if test="$info.certificate_type.equals('수상경력'))">selected</c:if>>수상경력</option>
				</select>
				<input type="text" id="cert" name="certificate" value="${info.certificate}">
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
				<c:forEach items="${lsProgramOptions}" var="lsProgram">
					<label>
				        <input type="checkbox" class="lesson_program" name="lesson_program" value="${lsProgram}"
				        	 <c:if test="${lsProgramlist.contains(lsProgram)}">checked</c:if>><span>${lsProgram}</span>
				    </label>
				</c:forEach>
		</div>
		
		<button type="submit">저장</button>
	</form>
	</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$('document').ready(function() {
	 var area0 = ["시/도","서울","인천","대전","광주","대구","울산","부산","경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주도"];
	  var area1 = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
	   var area2 = ["계양구","남구","남동구","동구","부평구","서구","연수구","중구","강화군","옹진군"];
	   var area3 = ["대덕구","동구","서구","유성구","중구"];
	   var area4 = ["광산구","남구","동구","북구","서구"];
	   var area5 = ["남구","달서구","동구","북구","서구","수성구","중구","달성군"];
	   var area6 = ["남구","동구","북구","중구","울주군"];
	   var area7 = ["강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구","기장군"];
	   var area8 = ["고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시","가평군","양평군","여주군","연천군"];
	   var area9 = ["강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시","고성군","양구군","양양군","영월군","인제군","정선군","철원군","평창군","홍천군","화천군","횡성군"];
	   var area10 = ["제천시","청주시","충주시","괴산군","단양군","보은군","영동군","옥천군","음성군","증평군","진천군","청원군"];
	   var area11 = ["계룡시","공주시","논산시","보령시","서산시","아산시","천안시","금산군","당진군","부여군","서천군","연기군","예산군","청양군","태안군","홍성군"];
	   var area12 = ["군산시","김제시","남원시","익산시","전주시","정읍시","고창군","무주군","부안군","순창군","완주군","임실군","장수군","진안군"];
	   var area13 = ["광양시","나주시","목포시","순천시","여수시","강진군","고흥군","곡성군","구례군","담양군","무안군","보성군","신안군","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"];
	   var area14 = ["경산시","경주시","구미시","김천시","문경시","상주시","안동시","영주시","영천시","포항시","고령군","군위군","봉화군","성주군","영덕군","영양군","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군"];
	   var area15 = ["거제시","김해시","마산시","밀양시","사천시","양산시","진주시","진해시","창원시","통영시","거창군","고성군","남해군","산청군","의령군","창녕군","하동군","함안군","함양군","합천군"];
	   var area16 = ["서귀포시","제주시","남제주군","북제주군"];
	   
	 $("select[name=lesson_area1]").each(function() {
		  $selsido = $(this);
		  $.each(eval(area0), function() {
		   $selsido.append("<option value='"+this+"'>"+this+"</option>");
		  });
		  $selsido.val('${info.lesson_area1}');
		  
		 });
	 $("select[name=lesson_area2]").each(function() {
		  $gugun = $(this);
		  var area = "area"+area0.indexOf($("select[name=lesson_area1]").val()); // 선택지역의 구군 Array
		  
		  $gugun.append("<option value=''>구/군</option>");
		  
		  
		  $.each(eval(area), function() {
			  $gugun.append("<option value='"+this+"'>"+this+"</option>");
		  });
		  
		  $gugun.val('${info.lesson_area2}');
	 });

	 //////////////////
	  $("select[name=lesson_area1]").on("change", function () {
		 console.log("lessenArea value:", $("select[name=lesson_area1]").val());
		 console.log("lessenArea2 value:", $("select[name=lesson_area2]").val());
	}) 
	 
	 // 시/도 선택시 구/군 설정
	 $("select[name=lesson_area1]").change(function() {
	  var area = "area"+$("option",$(this)).index($("option:selected",$(this))); // 선택지역의 구군 Array
	  
	  var $gugun = $(this).next(); // 선택영역 군구 객체
	  $("option",$gugun).remove(); // 구군 초기화

	  if(area == "area0")
	   $gugun.append("<option value=''>구/군 선택</option>");
	  else {
	   $.each(eval(area), function() {
	    $gugun.append("<option value='"+this+"'>"+this+"</option>");
	   });
	  }
	 });

	});
	/////////////////////////////////////////////////////////////////
	function findpostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                //document.getElementById("extraAddress").value = extraAddr;
	            
	            } //else {
	                //document.getElementById("extraAddress").value = '';
	            //}
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('postcode').value = data.zonecode;
	            document.getElementById("centerAddress").value = addr + " " + extraAddr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("centerAddressDetail").focus();
	        }
	    }).open();
	}

</script>
</html>