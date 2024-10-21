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

/*         function checkEmail() {
            var emailUsername = document.getElementById("emailusername").value;
            var emailDomain = document.getElementById("emaildomain").value;
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "${pageContext.request.contextPath}/user/CheckEmailServlet?emailusername=" + encodeURIComponent(emailUsername) + "&emaildomain=" + encodeURIComponent(emailDomain), true);
            xhr.onload = function () {
                if (xhr.responseText.trim() === "Available") {
                    document.getElementById("emailStatus").innerHTML = "사용 가능한 이메일입니다.";
                } else {
                    document.getElementById("emailStatus").innerHTML = "이미 사용 중인 이메일입니다.";
                }
            };
            xhr.send();
        } */

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

/*         function fillBirthDateAndGender() {
            var ssn1 = document.getElementById("ssn1").value;
            var ssn2 = document.getElementById("ssn2").value;
            if (ssn1.length === 6 && ssn2.length === 7) {
                var birthYear = ssn2.charAt(0) <= '2' ? '19' + ssn1.substring(0, 2) : '20' + ssn1.substring(0, 2);
                var birthMonth = ssn1.substring(2, 4);
                var birthDay = ssn1.substring(4, 6);
                var gender = (ssn2.charAt(0) === '1' || ssn2.charAt(0) === '3') ? 'M' : 'F';

                document.getElementById("birthdate").value = birthYear + '-' + birthMonth + '-' + birthDay;
                document.getElementById("gender").value = gender;
            }
        } */
    </script>
    <form action="<c:url value="/register"/>" method="post">
    <b>[ 회원 등록 ]</b>
        <table border="1">
            <tr>
                <td>아이디:</td>
                <td>
                    <input type="text" id="userid" name="userid">
<!--                     <button type="button" onclick="checkUserId()">중복 검사</button>
                    <span id="userIdStatus"></span> -->
                </td>
            </tr>
            <tr>
                <td>비밀번호:</td>
                <td>
                    <input type="password" id="userpw" name="userpw">
                </td>
            </tr>
            <tr>
                <td>비밀번호 확인:</td>
                <td>
                    <input type="password" id="userpw_confirm" name="userpw_confirm" onkeyup="checkPasswordMatch()">
                    <span id="passwordStatus"></span>
                </td>
            </tr>
            <tr>
                <td>이메일:</td>
                <td>
                    <input type="text" id="emailusername" name="emailusername"> @ 
                    <select id="emaildomain" name="emaildomain">
                        <option value="gmail.com">gmail.com</option>
                        <option value="naver.com">naver.com</option>
                        <option value="daum.net">daum.net</option>
                    </select>
<!--                     <button type="button" onclick="checkEmail()">중복 검사</button>
                    <span id="emailStatus"></span> -->
                </td>
            </tr>
            <tr>
                <td>전화번호:</td>
                <td>
                    <input type="text" id="phone1" name="phone1"> - 
                    <input type="text" id="phone2" name="phone2"> - 
                    <input type="text" id="phone3" name="phone3">
                </td>
            </tr>
            <tr>
                <td>실명:</td>
                <td><input type="text" id="realname" name="realname"></td>
            </tr>
            <tr>
                <td>우편번호:</td>
                <td>
                    <input type="text" id="postalcode" name="postalcode" readonly>
                    <button type="button" onclick="openPostcode()">주소 찾기</button>
                </td>
            </tr>
            <tr>
                <td>도로명 주소:</td>
                <td><input type="text" id="streetaddress" name="streetaddress" readonly></td>
            </tr>
            <tr>
                <td>상세 주소:</td>
                <td><input type="text" id="detailedaddress" name="detailedaddress"></td>
            </tr>
            <tr>
                <td>약관 동의:</td>
                <td><input type="checkbox" id="termsagreed" name="termsagreed" value="1"></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="회원가입">
                </td>
            </tr>
        </table>
    </form>
