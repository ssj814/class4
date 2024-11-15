<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script type="text/javascript">
    $(function(){
        $("form").on("submit", function(event) {
            var userid = $("#userid").val();
            var passwd = $("#userpw").val();
            if (userid.length == 0) {
                alert("아이디는 필수 입력 항목입니다.");
                $("#userid").focus();
                event.preventDefault();
            } else if (passwd.length == 0) {
                alert("비밀번호는 필수 입력 항목입니다.");
                $("#userpw").focus();
                event.preventDefault();
            }
        });
        $("#member").click(function(){
            location.href = "UserWriteForm";
        });
    });
</script>

<!-- 부트스트랩 그리드 시스템을 사용하여 로고와 로그인 폼 중앙 정렬 -->
<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="row w-100">
        <!-- 로그인 박스 -->
        <div class="col-md-6 col-sm-8 col-10 mx-auto">
            <div class="card shadow-lg p-4">
                <div class="card-body">
                    <!-- 로고 -->
                    <div class="text-center mb-4">
                        <a href="/app/"><img src="<c:url value='/images/logo.png'/>" alt="로고" class="img-fluid" style="max-width: 200px;"></a>
                    </div>
                    <!-- 로그인 폼 -->
                    <h3 class="text-center mb-4">로그인</h3>
                    <form action="<c:url value='/login'/>" method="post">
                        <div class="form-group">
                            <label for="userid">아이디</label>
                            <input type="text" id="userid" name="userid" class="form-control" placeholder="아이디를 입력하세요">
                        </div>
                        <div class="form-group">
                            <label for="userpw">비밀번호</label>
                            <input type="password" id="userpw" name="userpw" class="form-control" placeholder="비밀번호를 입력하세요">
                        </div>
                        <button type="submit" class="btn btn-dark btn-block mt-2" style="width: 100%">로그인</button>
                    </form>
                    <!-- 회원가입 버튼 -->
                    <button id="member" class="btn btn-outline-dark btn-block" style="margin-top: 5px; width: 100%;">회원가입</button>
                </div>
                <!-- 소셜 로그인 -->
                <div class="social-login mt-4">
                    <!-- 간편 로그인 위 점선 추가 -->
                    <div class="text-center mb-3">
                        <hr style="border-top: 2px dashed #007bff; width: 50%; margin: 0 auto;">
                    </div>
                    <h5 class="text-center mb-4">간편 로그인</h5>
                    <!-- 소셜 로그인 버튼 중앙 정렬 및 동일 크기 -->
                    <div class="d-flex flex-column align-items-center">
                        <div class="text-center mb-4">
                            <a href="http://localhost:8090/app/oauth2/authorization/google?redirect_uri=http://localhost:8090/app&mode=login">
                                <button class="btn btn-danger btn-block">구글 로그인</button>
                            </a>
                        </div>
                        <div class="text-center mb-4">
                            <a href="http://localhost:8090/app/oauth2/authorization/naver?redirect_uri=http://localhost:8090/app&mode=login">
                                <button class="btn btn-success btn-block">네이버 로그인</button>
                            </a>
                        </div>
                        <div class="text-center mb-4">
                            <a href="http://localhost:8090/app/oauth2/authorization/kakao?redirect_uri=http://localhost:8090/app&mode=login">
                                <button class="btn btn-warning btn-block">카카오 로그인</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>