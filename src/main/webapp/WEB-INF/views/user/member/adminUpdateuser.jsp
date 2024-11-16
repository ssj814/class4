<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script type="text/javascript">
    function checkPasswordMatch() {
        var userpw = document.getElementById("userpw").value;
        var userpwConfirm = document.getElementById("userpwConfirm").value;
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
</script>

<div class="container mt-5" style="width: 50%;">
    <h1 class="text-center mb-4"><b>[ ${user.userid} 회원 정보 수정 ]</b></h1>
    <form action="<c:url value='/admin/updateUser/${usernumber}'/>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="usernumber" value="${usernumber}">
        <table class="table table-bordered table-striped">
            <tr>
                <td>프로필 사진:</td>
                <td>
                    <input type="file" id="profilePictureFile" name="profilePictureFile" accept="image/*" class="form-control" style="width:35%;">
                    <c:if test="${not empty validationUserDTO.profilePictureUrl}">
                        <img src="${validationUserDTO.profilePictureUrl}" alt="프로필 사진" width="100" height="100" class="mt-2">
                    </c:if>
                </td>
            </tr>
            <tr>
                <td>아이디:</td>
                <td>
                    <input type="text" id="userid" name="userid" value="${user.userid}" readonly class="form-control" style="width:35%;">
                </td>
            </tr>
            <tr>
                <td>실명:</td>
                <td>
                    <input type="text" id="realusername" name="realusername" value="${user.realusername}" readonly class="form-control"  style="width: 20%;">
                    <c:if test="${not empty validationUserDTO.realusernameError}">
                        <span class="text-danger">${validationUserDTO.realusernameError}</span>
                    </c:if>
                </td>
            </tr>
            <tr>
                <td>성별:</td>
                <td>
                    <input type="radio" id="male" name="gender" value="M" ${validationUserDTO.gender eq 'M' ? 'checked' : ''}>
                    <label for="male">남성</label>

                    <input type="radio" id="female" name="gender" value="F" ${validationUserDTO.gender eq 'F' ? 'checked' : ''}>
                    <label for="female">여성</label>

                    <input type="radio" id="other" name="gender" value="O" ${validationUserDTO.gender eq 'O' ? 'checked' : ''}>
                    <label for="other">기타</label>

                    <c:if test="${not empty validationUserDTO.gender}">
                        <span class="text-danger">${validationUserDTO.gender}</span>
                    </c:if>
                </td>
            </tr>
            <tr>
                <td>새 비밀번호:</td>
                <td>
                    <div style="position: relative; width: 35%;" >
                        <input type="password" id="userpw" name="userpw" class="form-control" style="padding-right: 30px;" onkeyup="checkPasswordMatch()">
                        <span id="toggleUserpwIcon" onclick="togglePasswordVisibility('userpw')" class="position-absolute" style="right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;">👁️</span>
                    </div>
                </td>
            </tr>
            <tr>
                <td>비밀번호 확인:</td>
                <td>
                    <div style="position: relative; width: 35%;">
                        <input type="password" id="userpwConfirm" name="userpwConfirm" class="form-control" style="padding-right: 30px;" onkeyup="checkPasswordMatch()">
                        <span id="toggleUserpwConfirmIcon" onclick="togglePasswordVisibility('userpwConfirm')" class="position-absolute" style="right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;">👁️</span>
                        <span id="passwordStatus" class="text-danger"></span>
                    </div>
                </td>
            </tr>
            <tr>
                <td>이메일:</td>
                <td style="display: flex;">
                    <input type="text" id="emailUsername" name="emailUsername" value="${validationUserDTO.emailUsername}" class="form-control" style="width: 30%;" required>&nbsp;&nbsp;@&nbsp;&nbsp;
                    <select id="emailDomain" name="emailDomain" class="form-control" style="width: 15%;" required>
                        <option value="gmail.com" ${validationUserDTO.emailDomain == 'gmail.com' ? 'selected' : ''}>gmail.com</option>
                        <option value="naver.com" ${validationUserDTO.emailDomain == 'naver.com' ? 'selected' : ''}>naver.com</option>
                        <option value="daum.net" ${validationUserDTO.emailDomain == 'daum.net' ? 'selected' : ''}>daum.net</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>전화번호:</td>
                <td style="display: flex;">
                    <input type="text" id="phone1" name="phone1" value="${validationUserDTO.phone1}" class="form-control"  style="width: 20%;" required> - 
                    <input type="text" id="phone2" name="phone2" value="${validationUserDTO.phone2}" class="form-control"  style="width: 20%;" required> - 
                    <input type="text" id="phone3" name="phone3" value="${validationUserDTO.phone3}" class="form-control"  style="width: 20%;" required>
                </td>
            </tr>
            <tr>
                <td>우편번호:</td>
                <td  style="display: flex;">
                    <input type="text" id="postalcode" name="postalcode" value="${validationUserDTO.postalcode}" class="form-control" style="width: 20%;" readonly required>
                    <button type="button" class="btn btn-secondary mt-2 ms-3" onclick="openPostcode()">주소 찾기</button>
                </td>
            </tr>
            <tr>
                <td>도로명 주소:</td>
                <td>
                    <input type="text" id="streetaddress" name="streetaddress" value="${validationUserDTO.streetaddress}" class="form-control" style="width:60%;" readonly required>
                </td>
            </tr>
            <tr>
                <td>상세 주소:</td>
                <td>
                    <input type="text" id="detailedaddress" name="detailedaddress" value="${validationUserDTO.detailedaddress}" class="form-control" style="width:60%;" required>
                </td>
            </tr>
            <tr>
                <td>약관 동의:</td>
                <td>
                    <input type="checkbox" id="termsagreed" name="termsagreed" value="1" ${validationUserDTO.termsagreed == 1 ? 'checked' : ''}> 동의합니다
                    <c:if test="${not empty validationUserDTO.termsagreedError}">
                        <span class="text-danger">${validationUserDTO.termsagreedError}</span>
                    </c:if>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="text-center">
                    <button type="submit" class="btn btn-dark">정보 수정</button>
                </td>
            </tr>
        </table>
    </form>
</div>