<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script type="text/javascript">
    function checkPasswordMatch() {
        var userpw = document.getElementById("userpw").value;
        var userpwConfirm = document.getElementById("userpwConfirm").value;
        var passwordStatus = document.getElementById("passwordStatus");
        passwordStatus.innerHTML = userpw !== userpwConfirm ? "비밀번호가 일치하지 않습니다." : "";
        passwordStatus.style.color = userpw !== userpwConfirm ? "red" : "green";
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

        if (passwordField.type === "password") {
            passwordField.type = "text";
            toggleIcon.textContent = "🙈";
        } else {
            passwordField.type = "password";
            toggleIcon.textContent = "👁️";
        }
    }
</script>

<div class="container mt-5" style="width: 80%; margin-bottom: 200px;">
    <h1 class="text-center mb-4"><b>[ 회원 정보 수정 ]</b></h1>
    <form action="<c:url value='/mypage?page=editInfo'/>" method="post" enctype="multipart/form-data">
        <table class="table table-bordered table-striped">
            <tr>
                <td>프로필 사진:</td>
                <td>
                    <input type="file" id="profilePictureFile" name="profilePictureFile" accept="image/*" class="form-control" style="width: 40%;">
                    <c:if test="${not empty validationUserDTO.profilePictureUrl}">
                        <img src="<c:url value='${validationUserDTO.profilePictureUrl}' />" alt="프로필 사진" width="100" height="100" class="mt-2">
                    </c:if>
                </td>
            </tr>
            <tr>
                <td>아이디:</td>
                <td>
                    <input type="text" id="userid" name="userid" value="${validationUserDTO.userid}" readonly class="form-control" style="width: 35%;">
                </td>
            </tr>
            <tr>
                <td>실명:</td>
                <td>
                    <input type="text" id="realusername" name="realusername" value="${validationUserDTO.realusername}" readonly class="form-control" style="width: 35%;">
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
                </td>
            </tr>
            <tr>
                <td>새 비밀번호:</td>
                <td>
                    <div style="position: relative; width: 35%;">
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
                    <input type="text" id="emailUsername" name="emailUsername" value="${validationUserDTO.emailUsername}" class="form-control" style="width: 30%;">&nbsp;@&nbsp;
                    <select id="emailDomain" name="emailDomain" class="form-control" style="width: 30%;">
                        <option value="gmail.com" ${validationUserDTO.emailDomain == 'gmail.com' ? 'selected' : ''}>gmail.com</option>
                        <option value="naver.com" ${validationUserDTO.emailDomain == 'naver.com' ? 'selected' : ''}>naver.com</option>
                        <option value="daum.net" ${validationUserDTO.emailDomain == 'daum.net' ? 'selected' : ''}>daum.net</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>전화번호:</td>
                <td style="display: flex;">
                    <input type="text" id="phone1" name="phone1" value="${validationUserDTO.phone1}" class="form-control" style="width: 20%;"> - 
                    <input type="text" id="phone2" name="phone2" value="${validationUserDTO.phone2}" class="form-control" style="width: 20%;"> - 
                    <input type="text" id="phone3" name="phone3" value="${validationUserDTO.phone3}" class="form-control" style="width: 20%;">
                </td>
            </tr>
            <tr>
                <td>우편번호:</td>
                <td style="display: flex;">
                    <input type="text" id="postalcode" name="postalcode" value="${validationUserDTO.postalcode}" class="form-control" style="width: 20%;" readonly>
                    <button type="button" class="btn btn-secondary ms-2" onclick="openPostcode()">주소 찾기</button>
                </td>
            </tr>
            <tr>
                <td>도로명 주소:</td>
                <td>
                    <input type="text" id="streetaddress" name="streetaddress" value="${validationUserDTO.streetaddress}" class="form-control" style="width: 60%;" readonly>
                </td>
            </tr>
            <tr>
                <td>상세 주소:</td>
                <td>
                    <input type="text" id="detailedaddress" name="detailedaddress" value="${validationUserDTO.detailedaddress}" class="form-control" style="width: 60%;">
                </td>
            </tr>
            <tr>
                <td>약관 동의:</td>
                <td>
                    <input type="checkbox" id="termsagreed" name="termsagreed" value="1" ${validationUserDTO.termsagreed == 1 ? 'checked' : ''}> 동의합니다
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
