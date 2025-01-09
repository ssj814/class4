<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
	.black {
		color: black;
	}
    body {
        display: flex;
    }
    .sidebar {
        min-width: 200px;
        max-width: 250px;
        background-color: #212529;
        color: #fff;
        height: 100vh;
        position: fixed;
        padding-top: 8px;
    }
    .sidebar-title {
    	margin-bottom: 20px;
    	padding-top: 10px;
    	padding-bottom: 10px;
    	border-bottom: 1px solid #fff;
    	border-top: 1px solid #fff;
    	color: white;
    }
    .sidebar a {
        color: #fff;
        text-decoration: none;
        padding: 10px;
        display: block;
        text-align: center;
    }
    .sidebar a:hover {
        background-color: #495057;
    }
    .content {
    	margin-left: 250px;
        padding: 20px;
        width: 80%;
    }
    .active-menu{
    	background-color: #495057;
    }
</style>

<div class="sidebar">
    <h4 class="sidebar-title text-center">관리자 메뉴</h4>
    <a href="<c:url value='/admin/view'/>">회원관리</a>
    <a href="<c:url value='/admin/view_ask'/>">문의관리</a>
    <a href="#">신고관리</a>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		const currentPath = window.location.pathname;
		$(".sidebar a").each(function() {
			const linkPath = $(this).attr("href");
			if (currentPath === linkPath) {
				$(this).addClass("active-menu");
			}
		});
	})
</script>