<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Footer Example</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
        }
        .content {
            flex: 1;
        }
        footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 20px 0;
        }
    </style>
</head>
<body>

<div class="content">
    <!-- 여기에 페이지 내용이 들어갑니다 -->
</div>

<footer class="bg-dark text-white text-center py-4">
    <div class="container">
        <p class="mb-0">© 2024 Your Company Name. All rights reserved.</p>
        <ul class="list-inline mt-2">
            <li class="list-inline-item"><a href="#" class="text-white">Privacy Policy</a></li>
            <li class="list-inline-item"><a href="#" class="text-white">Terms of Service</a></li>
            <li class="list-inline-item"><a href="#" class="text-white">Contact Us</a></li>
        </ul>
    </div>
</footer>

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"></script>

</body>
</html>
