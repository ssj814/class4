<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
function checkUserId() {
    var userId = document.getElementById("userid").value;  // 입력된 아이디 값 가져오기
    console.log("아이디 중복 체크 요청 아이디: " + userId);  // 클라이언트에서 요청하는 아이디 출력
    
    // 아이디 입력 여부 확인
    if (userId.trim() === "") {
        document.getElementById("userIdStatus").innerHTML = "아이디를 입력하세요.";
        return;
    }

    var xhr = new XMLHttpRequest();
    // 요청 URL
    xhr.open("GET", "${pageContext.request.contextPath}/checkUserId?userid=" + encodeURIComponent(userId), true);
    console.log("요청 URL: " + "${pageContext.request.contextPath}/checkUserId?userid=" + encodeURIComponent(userId));
    
    xhr.onload = function () {
        if (xhr.status === 200) {  // 요청이 성공했을 때
            console.log("서버 응답: " + xhr.responseText);  // 응답 확인
            
            if (xhr.responseText.trim() === "Available") {  // "Available"과 비교
                document.getElementById("userIdStatus").innerHTML = "사용 가능한 아이디입니다.";
                document.getElementById("userIdStatus").style.color = "green";
            }
        } else if (xhr.status === 409) { // 아이디 중복 시 409 처리
            console.log("서버 응답(중복): " + xhr.responseText); // 중복 아이디 확인
            document.getElementById("userIdStatus").innerHTML = xhr.responseText;  // 응답 메시지 출력
            document.getElementById("userIdStatus").style.color = "red";
        }
    };
    
    xhr.onerror = function () {
        console.error("네트워크 오류 발생");  // 네트워크 오류 메시지
        document.getElementById("userIdStatus").innerHTML = "아이디 중복체크 중 오류가 발생했습니다.";
        document.getElementById("userIdStatus").style.color = "red";
    };
    
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status !== 200 && xhr.status !== 409) {
            console.error("아이디 중복체크 오류: " + xhr.status);  // 에러 코드 확인
            document.getElementById("userIdStatus").innerHTML = "아이디 중복체크 중 오류가 발생했습니다.";
            document.getElementById("userIdStatus").style.color = "red";
        }
    };

    xhr.send();  // 요청을 보냄
}


	function checkPasswordMatch() {
	    var password = document.getElementById("userpw").value; // 수정된 부분
	    var confirmPassword = document.getElementById("userpwConfirm").value;
	    
	    if (password !== confirmPassword) {
	        document.getElementById("passwordMatchStatus").textContent = "비밀번호가 일치하지 않습니다.";
	        document.getElementById("passwordMatchStatus").style.color = "red";
	        
	    } else {
	        document.getElementById("passwordMatchStatus").textContent = "비밀번호가 일치합니다.";
	        document.getElementById("passwordMatchStatus").style.color = "green";
	    }
	}


	function checkEmail() {
	    var emailUsername = document.getElementById("emailUsername").value;
	    var emailDomain = document.getElementById("emailDomain").value;
	    var email = emailUsername + "@" + emailDomain;
	    
	    console.log("이메일 중복 체크 요청 이메일: " + email);
	    
	    // 이메일 입력 여부 확인
	    if (emailUsername.trim() === "" || emailDomain.trim() === "") {
	        document.getElementById("emailUsernameStatus").innerHTML = "이메일을 입력하세요.";
	        return;
	    }

	    var xhr = new XMLHttpRequest();
	    // 요청 URL
	    xhr.open("GET", "${pageContext.request.contextPath}/checkEmail?emailUsername=" + encodeURIComponent(emailUsername) + "&emailDomain=" + encodeURIComponent(emailDomain), true);
	    console.log("요청 URL: " + "${pageContext.request.contextPath}/checkEmail?emailUsername=" + encodeURIComponent(emailUsername) + "&emailDomain=" + encodeURIComponent(emailDomain));
	    
	    xhr.onload = function () {
	        if (xhr.status === 200) {  // 요청이 성공했을 때
	            console.log("서버 응답: " + xhr.responseText);
	            
	            if (xhr.responseText.trim() === "Available") {  // "Available"과 비교
	                document.getElementById("emailUsernameStatus").innerHTML = "사용 가능한 이메일입니다.";
	                document.getElementById("emailUsernameStatus").style.color = "green";
	            }
	        } else if (xhr.status === 409) { // 이메일 중복 시 409 처리
	            console.log("서버 응답(중복): " + xhr.responseText);
	            document.getElementById("emailUsernameStatus").innerHTML = xhr.responseText;
	            document.getElementById("emailUsernameStatus").style.color = "red";
	        }
	    };

	    xhr.onerror = function () {
	        console.error("네트워크 오류 발생");
	        document.getElementById("emailUsernameStatus").innerHTML = "이메일 중복체크 중 오류가 발생했습니다.";
	        document.getElementById("emailUsernameStatus").style.color = "red";
	    };

	    xhr.onreadystatechange = function () {
	        if (xhr.readyState === 4 && xhr.status !== 200 && xhr.status !== 409) {
	            console.error("이메일 중복체크 오류: " + xhr.status);
	            document.getElementById("emailUsernameStatus").innerHTML = "이메일 중복체크 중 오류가 발생했습니다.";
	            document.getElementById("emailUsernameStatus").style.color = "red";
	        }
	    };

	    xhr.send();  // 요청을 보냄
	}

	

    function openPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById("postalcode").value = data.zonecode;
                document.getElementById("streetaddress").value = data.roadAddress;
            }
        }).open();
    }

    function togglePasswordVisibility(passwordFieldId) {
        var passwordField = document.getElementById(passwordFieldId);
        
        // 비밀번호와 비밀번호 확인을 구별하여 아이콘 ID를 설정
        var toggleIconId = (passwordFieldId === 'userpw') ? 'toggleUserpwIcon' : 'toggleConfirmPasswordIcon';
        var toggleIcon = document.getElementById(toggleIconId);

        if (!toggleIcon) {
            console.error("Toggle icon not found with ID: " + toggleIconId);
            return;
        }

        // 비밀번호 필드 타입을 텍스트 또는 패스워드로 전환
        if (passwordField.type === "password") {
            passwordField.type = "text";
            toggleIcon.textContent = "🙈"; // 텍스트 모드로 전환
        } else {
            passwordField.type = "password";
            toggleIcon.textContent = "👁️"; // 패스워드 모드로 전환
        }
    }


    function checkPasswordStrength() {
        var password = document.getElementById("userpw").value;
        var strengthText = document.getElementById("passwordStrength");

        var strength = "약함";
        var colorClass = "text-danger";  // 기본적으로 약함은 빨강(경고)

        if (password.length >= 8) {
            let hasUpper = /[A-Z]/.test(password);
            let hasLower = /[a-z]/.test(password);
            let hasNumber = /[0-9]/.test(password);
            let hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(password);

            var strengthCount = (hasUpper ? 1 : 0) + (hasLower ? 1 : 0) + (hasNumber ? 1 : 0) + (hasSpecial ? 1 : 0);

            if (strengthCount === 4) {
                strength = "강함";
                colorClass = "text-success";  // 강함은 초록색
            } else if (strengthCount === 3) {
                strength = "보통";
                colorClass = "text-warning";  // 보통은 노랑(주황)
            }
        }

        // 비밀번호 강도 텍스트 변경
        strengthText.textContent = "비밀번호 강도: " + strength;

        // 글자 색상만 변경
        strengthText.className = "mt-2 " + colorClass;  // 강도에 따른 색상만 변경
    }

	 // 자식 창 객체 전역으로 설정
	    let termsWindow = null;
	
	    // 자식 창 열기
	    function openTermsWindow() {
	        // 자식 창 열기
	        termsWindow = window.open("${pageContext.request.contextPath}/termsAgreed", "termsWindow", "width=800,height=600");
	       	
	        /*
	        // 자식 창 로드 후 초기화
	        termsWindow.onload = function() {
	            console.log("Terms window loaded.");
	            termsWindow.isAgreed = false; // 초기 동의 상태 설정
	            console.log("Initial isAgreed value:", termsWindow.isAgreed);
	        };
			*/
	        /*
	        // 자식 창이 닫힐 때 상태 반영
	        termsWindow.onunload = function() {
	            console.log("termsWindow onunload triggered");
	            if (termsWindow && termsWindow.isAgreed !== undefined) {
	                console.log("termsWindow isAgreed value on parent:", termsWindow.isAgreed);
	                if (termsWindow.isAgreed) {
	                	console.log("isAgreed: ",termsWindow.isAgreed);
	                    document.getElementById("termsagreed").checked = true;
	                } else {
	                	console.log("! isAgreed: ",termsWindow.isAgreed);
	                    document.getElementById("termsagreed").checked = false;
	                }
	            } else {
	                console.log("termsWindow or isAgreed is undefined");
	            }
	        };
	        */
	    }
	
	    // 동의합니다 버튼 클릭 시 체크박스 체크
	    function agreeToTerms() {
	        document.getElementById("termsagreed").checked = true;
	    }

</script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container-fluid" style="max-width: 1300px;">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-6">
            <form action="<c:url value='/register'/>" method="post" modelAttribute="validationUserDTO">
                <h4 class="text-center my-4"> 회원가입 </h4>
                <table class="table table-bordered mx-auto" style="font-size: 15px;">
                    <tr>
                        <tr>
						    <td style="vertical-align: middle; white-space: nowrap; min-height: 1.5em;">아이디:</td>
						    <td>
						        <div class="input-group">
						            <input type="text" id="userid" name="userid" class="form-control" style="font-size: 12px;" value="${validationUserDTO.userid}" placeholder="4~20자리 영문 소문자와 숫자만 사용 가능합니다." required title="아이디를 입력하세요.">
						            <button type="button" class="btn btn-outline-secondary" style="font-size: 13px;" onclick="checkUserId()">중복체크</button>
						        </div>
						        <div id="userIdStatus" class="mt-1" style="min-height: 1.5em;">
						        <c:if test="${not empty validationUserDTO.useridError}">
						            <span class="text-danger">${validationUserDTO.useridError}</span>
						        </c:if>
						        </div>
						    </td>
						</tr>
						
						<tr>
						    <td style="vertical-align: middle; white-space: nowrap; min-height: 1.5em;">비밀번호:</td>
						    <td>
						        <div class="position-relative">
						            <input type="password" id="userpw" name="userpw" class="form-control" style="font-size: 12px;" value="${validationUserDTO.userpw}" placeholder="8~20자, 영문 대소문자, 숫자, 특수문자 포함" required title="비밀번호를 입력하세요." oninput="checkPasswordStrength()">
						            <span id="toggleUserpwIcon" class="position-absolute" style="right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer;" onclick="togglePasswordVisibility('userpw')">👁️</span>
						        </div>
						        <div id="passwordStrength" class="mt-2 text-muted" style="min-height: 1.5em;">
						        <c:if test="${not empty validationUserDTO.userpwError}">
						            <span class="text-danger">${validationUserDTO.userpwError}</span>
						        </c:if>
						        </div>
						    </td>
						</tr>
						
						<tr>
						    <td style="vertical-align: middle; white-space: nowrap; min-height: 1.5em;">비밀번호 확인:</td>
						    <td>
						        <div class="position-relative">
						            <input type="password" id="userpwConfirm" name="userpwConfirm" class="form-control" style="font-size: 12px;" value="${validationUserDTO.userpwConfirm}" placeholder="비밀번호를 다시 입력하세요" required title="비밀번호를 입력하세요." oninput="checkPasswordMatch()">
						            <span id="toggleConfirmPasswordIcon" class="position-absolute" style="right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer;" onclick="togglePasswordVisibility('confirm_password')">👁️</span>
						        </div>
						        <div id="passwordMatchStatus" class="mt-1" style="min-height: 1.5em;">
						        <c:if test="${not empty validationUserDTO.confirmPasswordError}">
						            <span class="text-danger">${validationUserDTO.confirmPasswordError}</span>
						        </c:if>
						        </div>
						    </td>
						</tr>
						
						<tr>
						    <td style="vertical-align: middle; white-space: nowrap; min-height: 1.5em;">이메일:</td>
						    <td>
						        <div class="input-group">
						            <input type="text" id="emailUsername" name="emailUsername" class="form-control" value="${validationUserDTO.emailUsername}" required title="이메일을 입력하세요."> 
						            <span class="input-group-text">@</span>
						            <select id="emailDomain" name="emailDomain" class="form-select" value="${validationUserDTO.emailDomain}" required title="도메인을 선택하세요.">
						                <option value="" style="font-size: 13px;">선택하세요</option>
						                <option value="gmail.com" ${validationUserDTO.emailDomain == 'gmail.com' ? 'selected' : ''}>gmail.com</option>
						                <option value="naver.com" ${validationUserDTO.emailDomain == 'naver.com' ? 'selected' : ''}>naver.com</option>
						                <option value="daum.net" ${validationUserDTO.emailDomain == 'daum.net' ? 'selected' : ''}>daum.net</option>
						            </select>
						            <button type="button" class="btn btn-outline-secondary" style="font-size: 13px;" onclick="checkEmail()">중복체크</button>
						        </div>
						        <div id="emailUsernameStatus" class="mt-1" style="min-height: 1.5em;">
						        <c:if test="${not empty validationUserDTO.emailUsernameError}">
						            <span class="text-danger">${validationUserDTO.emailUsernameError}</span>
						        </c:if>
						        </div>
						    </td>
						</tr>
                    
                    <tr>
                        <td style="vertical-align: middle; white-space: nowrap; min-height: 1.5em;">전화번호:</td>
                        <td>
                            <div class="input-group">
                                <input type="text" id="phone1" name="phone1" class="form-control" value="010" required readonly> -
                                <input type="text" id="phone2" name="phone2" class="form-control" value="${validationUserDTO.phone2}" required title="전화번호를 입력하세요."> -
                                <input type="text" id="phone3" name="phone3" class="form-control" value="${validationUserDTO.phone3}" required title="전화번호를 입력하세요.">
                            </div>
						        <!-- phone2 오류 메시지 -->
						        <div id="phoneStatus" class="mt-1" style="min-height: 1.5em;">
						        <c:if test="${not empty validationUserDTO.phone2Error}">
						            <span class="text-danger">${validationUserDTO.phone2Error}</span>
						        </c:if>
						        <!-- phone3 오류 메시지 -->
						        <c:if test="${not empty validationUserDTO.phone3Error}">
						            <span class="text-danger">${validationUserDTO.phone3Error}</span>
						        </c:if>
						        </div>
                        </td>
                    </tr>

                    <tr>
                        <td style="vertical-align: middle; white-space: nowrap; min-height: 1.5em;">실명:</td>
                        <td>
                            <input type="text" id="realusername" name="realusername" class="form-control" value="${validationUserDTO.realusername}" required title="이름을 입력하세요.">
                            <div id="realusernameStatus" class="mt-1" style="min-height: 1.5em;">
                            <c:if test="${not empty validationUserDTO.realusernameError}">
                                <span class="text-danger">${validationUserDTO.realusernameError}</span>
                            </c:if>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td style="vertical-align: middle; white-space: nowrap; min-height: 1.5em;">우편번호:</td>
                        <td>
                            <div class="input-group">
                                <input type="text" id="postalcode" name="postalcode" class="form-control" value="${validationUserDTO.postalcode}" readonly required title="주소 찾기를 눌러주세요.">
                                <button type="button" class="btn btn-outline-secondary" style="font-size: 13px;" onclick="openPostcode()">주소 찾기</button>
                            </div>
                            <c:if test="${not empty validationUserDTO.postalcodeError}">
                                <span class="text-danger">${validationUserDTO.postalcodeError}</span>
                            </c:if>
                        </td>
                    </tr>

                    <tr>
                        <td style="vertical-align: middle; white-space: nowrap; min-height: 1.5em;">도로명 주소:</td>
                        <td>
                            <input type="text" id="streetaddress" name="streetaddress" class="form-control" value="${validationUserDTO.streetaddress}" readonly required title="주소를 입력하세요.">
                            <c:if test="${not empty validationUserDTO.streetaddressError}">
                                <span class="text-danger">${validationUserDTO.streetaddressError}</span>
                            </c:if>
                        </td>
                    </tr>

                    <tr>
                        <td style="vertical-align: middle; white-space: nowrap; min-height: 1.5em;">상세 주소:</td>
                        <td>
                            <input type="text" id="detailedaddress" name="detailedaddress" class="form-control" value="${validationUserDTO.detailedaddress}" required title="상세 주소를 입력하세요.">
                            <div id="detailedaddressStatus" class="mt-1" style="min-height: 1.5em;">
                            <c:if test="${not empty validationUserDTO.detailedaddressError}">
                                <span class="text-danger">${validationUserDTO.detailedaddressError}</span>
                            </c:if>
                            </div>
                        </td>
                    </tr>

                    <tr>
					    <td style="vertical-align: middle; white-space: nowrap; min-height: 1.5em;">약관 동의:</td>
					    <td>
					        <div class="form-check">
					            <!-- 약관 동의 체크박스 -->
					            <label id="termsagreed">
							        <input type="checkbox" id="termsagreed" name="termsagreed" value="1" class="form-check-input"
							               required title="약관 동의 필수" onclick="openTermsWindow()">
							        약관에 동의합니다.
							    </label>
					        </div>
					        <!-- 약관 동의 에러 메시지 표시 -->
					        <c:if test="${not empty validationUserDTO.termsagreedError}">
					            <span class="text-danger">${validationUserDTO.termsagreedError}</span>
					        </c:if>
					    </td>
					</tr>

                    <tr>
                        <td colspan="2" class="text-center">
                            <button type="submit" class="btn btn-primary">회원가입</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>
