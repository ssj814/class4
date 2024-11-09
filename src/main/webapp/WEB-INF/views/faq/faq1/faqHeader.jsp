<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Frequently Asked Questions</title>
    <style>
        /* 컨테이너 스타일 */
        .container {
            max-width: 800px; 
            margin: 0 auto; 
            padding: 20px;
            padding-top: 0cm;  
    		padding-bottom: 0cm;  
        }
        

       
        body {
            font-family: Arial, sans-serif;
            font-size: 16px;
            color: black;
       
        }

        /* 제목 스타일 */
        h1 {
            color: black;
            text-align: center;
            font-size: 3em; 
            font-weight: normal;
            margin-bottom: 40px;
            margin-top: 1.5cm; 
    	
        }
        


        /* 질문 스타일 */
        .question {
            cursor: pointer;
            background-color: #f5f5f5; 
            font-weight: bold;
            padding: 15px;
            margin: 10px 0;
            text-align: left;
            border: 1px solid #ddd; 
            font-size: 1.2em;
            position: relative; 
        }

        /* 아이콘 스타일 */
        .question::after {
            content: '\25BC'; 
            font-size: 1em;
            position: absolute;
            right: 15px; 
            top: 50%;
            transform: translateY(-50%); 
            transition: transform 0.3s; 
        }

        /* 질문이 열릴 때 화살표 회전 */
        .question.open::after {
            transform: translateY(-50%) rotate(180deg); 
        }

        /* 답변 스타일 */
        .answer {
            display: none;
            color: black;
            font-size: 1em;
            padding: 15px;
            border-left: 1px solid #ddd;
            border-right: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            background-color: white;
            text-align: left; 
        }

        /* 버튼 스타일 */
        .button-container button {
            background-color: #d3d3d3; 
            color: black;
            border: none;
            padding: 10px 15px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 1em;
        }

        .button-container button:hover {
            background-color: #a9a9a9; 
        }

        /* 버튼들을 가운데 정렬 */
        .button-container {
            text-align: center;
            margin-bottom: 20px;
        }
        
        .button-container + div {
    margin-bottom: 3.5cm; 
	}
   
        
        
    </style>

    <script>
        // 특정 답변을 토글하는 함수
        function toggleAnswer(answerId) {
            const answer = document.getElementById(answerId);
            const question = answer.previousElementSibling;

            if (answer.style.display === "none" || answer.style.display === "") {
                answer.style.display = "block";
                question.classList.add("open");
            } else {
                answer.style.display = "none";
                question.classList.remove("open");
            }
        }

        // 모든 질문과 답변을 표시하는 함수
        function toggleQuestions() {
            const allQuestions = document.querySelectorAll('.question');
            const allAnswers = document.querySelectorAll('.answer');

            allQuestions.forEach(question => question.style.display = "block");
            allAnswers.forEach(answer => answer.style.display = "none"); 
        }

        // FAQ_QNA_ID가 1, 2, 3인 질문만 보이도록 설정하는 함수
        function showMemberQuestions() {
            const allQuestions = document.querySelectorAll('.question');
            const allAnswers = document.querySelectorAll('.answer');

            allQuestions.forEach((question, index) => {
                const answer = allAnswers[index];
                const faqQnaId = question.getAttribute('data-faq-qna-id');

                if (faqQnaId === "1" || faqQnaId === "2" || faqQnaId === "3") {
                    question.style.display = "block";
                    answer.style.display = "none"; 
                } else {
                    question.style.display = "none";
                    answer.style.display = "none";
                }
            });
        }

        // FAQ_QNA_ID가 4, 5, 6인 질문만 보이도록 설정하는 함수
        function showTrainerQuestions() {
            const allQuestions = document.querySelectorAll('.question');
            const allAnswers = document.querySelectorAll('.answer');

            allQuestions.forEach((question, index) => {
                const answer = allAnswers[index];
                const faqQnaId = question.getAttribute('data-faq-qna-id');

                if (faqQnaId === "4" || faqQnaId === "5" || faqQnaId === "6") {
                    question.style.display = "block";
                    answer.style.display = "none"; 
                } else {
                    question.style.display = "none";
                    answer.style.display = "none";
                }
            });
        }

        // FAQ_QNA_ID가 7, 8, 9인 질문만 보이도록 설정하는 함수
        function showProductQuestions() {
            const allQuestions = document.querySelectorAll('.question');
            const allAnswers = document.querySelectorAll('.answer');

            allQuestions.forEach((question, index) => {
                const answer = allAnswers[index];
                const faqQnaId = question.getAttribute('data-faq-qna-id');

                if (faqQnaId === "7" || faqQnaId === "8" || faqQnaId === "9") {
                    question.style.display = "block";
                    answer.style.display = "none"; 
                } else {
                    question.style.display = "none";
                    answer.style.display = "none";
                }
            });
        }
        
        // FAQ_QNA_ID가 10, 11, 12인 질문만 보이도록 설정하는 함수
        function showDietQuestions() {
            const allQuestions = document.querySelectorAll('.question');
            const allAnswers = document.querySelectorAll('.answer');

            allQuestions.forEach((question, index) => {
                const answer = allAnswers[index];
                const faqQnaId = question.getAttribute('data-faq-qna-id');

                if (faqQnaId === "10" || faqQnaId === "11" || faqQnaId === "12") {
                    question.style.display = "block";
                    answer.style.display = "none";
                } else {
                    question.style.display = "none";
                    answer.style.display = "none";
                }
            });
        }
    </script>
</head>

<body>
<div class="container">
    <h1>FAQ</h1>

    <div class="button-container">
        <button onclick="toggleQuestions()">전체질문</button>
        <button onclick="showMemberQuestions()">회원</button>
        <button onclick="showTrainerQuestions()">트레이너</button>
        <button onclick="showProductQuestions()">상품</button>
        <button onclick="showDietQuestions()">식단</button>
    </div>

    <div>
        <c:forEach var="list" items="${allData}">
            <div class="question" data-faq-qna-id="${list.FAQ_QNA_ID}" onclick="toggleAnswer('answer_${list.FAQ_QNA_ID}')">
                ${list.QUESTION}
            </div>
            <div class="answer" id="answer_${list.FAQ_QNA_ID}">
                ${list.ANSWER}
            </div>
        </c:forEach> 
    </div>
</div>
</body>
</html>
