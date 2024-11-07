<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
    function checkUserId() {
        var userId = document.getElementById("userid").value;
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "${pageContext.request.contextPath}/user/CheckUserIdServlet?userid=" + encodeURIComponent(userId), true);
        xhr.onload = function () {
            if (xhr.responseText.trim() === "Available") {
                document.getElementById("userIdStatus").innerHTML = "사용 가능한 아이디입니다.";
            } else {
                document.getElementById("userIdStatus").innerHTML = "이미 사용 중인 아이디입니다.";
            }
        };
        xhr.send();
    }

    function checkPasswordMatch() {
        var userpw = document.getElementById("userpw").value;
        var userpwConfirm = document.getElementById("userpw_confirm").value;
        if (userpw !== userpwConfirm) {
            document.getElementById("passwordStatus").innerHTML = "비밀번호가 일치하지 않습니다.";
        } else {
            document.getElementById("passwordStatus").innerHTML = "";
        }
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
        var toggleIconId = 'toggleUserpw' + (passwordFieldId === 'userpw' ? '' : 'Confirm') + 'Icon';
        var toggleIcon = document.getElementById(toggleIconId);

        if (!toggleIcon) {
            console.error("Toggle icon not found with ID: " + toggleIconId);
            return;
        }

        if (passwordField.type === "password") {
            passwordField.type = "text";
            toggleIcon.textContent = "🙈";
        } else {
            passwordField.type = "password";
            toggleIcon.textContent = "👁️";
        }
    }

    function checkPasswordStrength() {
        var password = document.getElementById("userpw").value;
        var strengthText = document.getElementById("passwordStrength");
        var strengthBar = document.getElementById("strengthBar");

        var strength = "약함";
        var className = "weak";

        if (password.length >= 8) {
            let hasUpper = /[A-Z]/.test(password);
            let hasLower = /[a-z]/.test(password);
            let hasNumber = /[0-9]/.test(password);
            let hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(password);

            var strengthCount = (hasUpper ? 1 : 0) + (hasLower ? 1 : 0) + (hasNumber ? 1 : 0) + (hasSpecial ? 1 : 0);

            if (strengthCount === 4) {
                strength = "강함";
                className = "strong";
            } else if (strengthCount === 3) {
                strength = "보통";
                className = "medium";
            }
        }

        strengthText.textContent = "비밀번호 강도: " + strength;
        strengthBar.className = "strengthBar " + className;
    }

    function showPasswordTooltip() {
        var tooltip = document.getElementById("passwordTooltip");
        tooltip.style.display = "block";

        var input = document.getElementById("userpw");
        var rect = input.getBoundingClientRect();

        // 툴팁을 입력 필드 바로 아래에 위치
        tooltip.style.top = (rect.bottom + window.scrollY + 5) + "px"; // 입력 필드 아래에 위치 (margin 추가)
        tooltip.style.left = (rect.left + window.scrollX) + "px"; // 입력 필드의 왼쪽 위치
    }

    function hidePasswordTooltip() {
        document.getElementById("passwordTooltip").style.display = "none";
    }



</script>

<form action="<c:url value='/register'/>" method="post" modelAttribute="validationUserDTO">
    <b>[ 회원 등록 ]</b>
    <table border="1">
        <tr>
            <td>아이디:</td>
            <td>
                <input type="text" id="userid" name="userid" required>
                <span>* 4~20자리 영문 소문자와 숫자만 사용 가능합니다.</span>
                <span id="userIdStatus"></span>
                <c:if test="${not empty validationUserDTO.useridError}">
                    <span style="color:red;">${validationUserDTO.useridError}</span>
                </c:if>
            </td>
        </tr>
        <tr>
		    <td>비밀번호:</td>
		    <td>
		        <div style="position: relative; display: inline-block;">
		            <!-- 비밀번호 입력 필드 -->
		            <input type="password" id="userpw" name="userpw" required style="padding-right: 30px;"
		                   oninput="checkPasswordStrength()" onfocus="showPasswordTooltip()" onblur="hidePasswordTooltip()">
		            
		            <!-- 비밀번호 강도 툴팁 -->
		            <div id="passwordTooltip">
		                <div id="passwordStrength">비밀번호 강도: 약함</div>
		                <div id="strengthBar" class="strengthBar"></div>
		            </div>
		
		            <!-- 비밀번호 가시성 토글 아이콘 -->
		            <span id="toggleUserpwIcon" onclick="togglePasswordVisibility('userpw')"
		                  style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;">
		                👁️
		            </span>
		            <span>* 8~20자, 영문 대소문자, 숫자, 특수문자 포함</span>
		
		            <c:if test="${not empty validationUserDTO.userpwError}">
		                <span style="color:red;">${validationUserDTO.userpwError}</span>
		            </c:if>
		        </div>
		    </td>
		</tr>

		<tr>
		    <td>비밀번호 확인:</td>
		    <td>
		        <div style="position: relative; display: inline-block;">
		            <input type="password" id="userpw_confirm" name="userpwConfirm" onkeyup="checkPasswordMatch()" required style="padding-right: 30px;">
		            <span id="toggleUserpwConfirmIcon" onclick="togglePasswordVisibility('userpw_confirm')" 
		                  style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;">
		                👁️
		            </span>
		            <span id="passwordStatus"></span>
		            
		            <c:if test="${not empty validationUserDTO.userpwConfirmError}">
		                <span style="color:red;">${validationUserDTO.userpwConfirmError}</span>
		            </c:if>
		        </div>
		    </td>
		</tr>


        <tr>
            <td>이메일:</td>
            <td>
                <input type="text" id="emailUsername" name="emailUsername" required> @ 
                <select id="emailDomain" name="emailDomain" required>
                    <option value="">선택하세요</option>
                    <option value="gmail.com">gmail.com</option>
                    <option value="naver.com">naver.com</option>
                    <option value="daum.net">daum.net</option>
                </select>
                <c:if test="${not empty validationUserDTO.emailUsernameError}">
                    <span style="color:red;">${validationUserDTO.emailUsernameError}</span>
                </c:if>
            </td>
        </tr>
        <tr>
            <td>전화번호:</td>
            <td>
                <input type="text" id="phone1" name="phone1" required> - 
                <input type="text" id="phone2" name="phone2" required> - 
                <input type="text" id="phone3" name="phone3" required>
                <c:if test="${not empty validationUserDTO.phone1Error}">
                    <span style="color:red;">${validationUserDTO.phone1Error}</span>
                </c:if>
            </td>
        </tr>
        <tr>
            <td>실명:</td>
            <td>
                <input type="text" id="realusername" name="realusername" required>
                <c:if test="${not empty validationUserDTO.realusernameError}">
                    <span style="color:red;">${validationUserDTO.realusernameError}</span>
                </c:if>
            </td>
        </tr>
        <tr>
            <td>우편번호:</td>
            <td>
                <input type="text" id="postalcode" name="postalcode" readonly required>
                <button type="button" onclick="openPostcode()">주소 찾기</button>
                <c:if test="${not empty validationUserDTO.postalcodeError}">
                    <span style="color:red;">${validationUserDTO.postalcodeError}</span>
                </c:if>
            </td>
        </tr>
        <tr>
            <td>도로명 주소:</td>
            <td>
                <input type="text" id="streetaddress" name="streetaddress" readonly required>
                <c:if test="${not empty validationUserDTO.streetaddressError}">
                    <span style="color:red;">${validationUserDTO.streetaddressError}</span>
                </c:if>
            </td>
        </tr>
        <tr>
            <td>상세 주소:</td>
            <td>
                <input type="text" id="detailedaddress" name="detailedaddress" required>
                <c:if test="${not empty validationUserDTO.detailedaddressError}">
                    <span style="color:red;">${validationUserDTO.detailedaddressError}</span>
                </c:if>
            </td>
        </tr>
        <tr>
            <td>약관 동의:</td>
            <td>
                <input type="checkbox" id="termsagreed" name="termsagreed" value="1" required> 동의합니다
                <c:if test="${not empty validationUserDTO.termsagreedError}">
                    <span style="color:red;">${validationUserDTO.termsagreedError}</span>
                </c:if>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="회원가입">
            </td>
        </tr>
    </table>
</form>
