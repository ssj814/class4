<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
        // 특정 답변을 토글하는 함수
        function toggleAnswer(answerId) {
            const answer = document.getElementById(answerId);
            const question = answer.previousElementSibling;
            const allAnswers = document.querySelectorAll('.answer');

            if (answer.style.display === "none" || answer.style.display === "") {
            	allAnswers.forEach(answer => answer.style.display = "none"); 
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

<div class="faq-container">
	<h1>FAQ</h1>

	<div class="faq-button-container">
		<button onclick="toggleQuestions()">전체질문</button>
		<button onclick="showMemberQuestions()">회원</button>
		<button onclick="showTrainerQuestions()">트레이너</button>
		<button onclick="showProductQuestions()">상품</button>
		<button onclick="showDietQuestions()">식단</button>
	</div>

	<div>
		<c:forEach var="list" items="${allData}">
			<div class="question" data-faq-qna-id="${list.FAQ_QNA_ID}"
				onclick="toggleAnswer('answer_${list.FAQ_QNA_ID}')">
				${list.QUESTION}</div>
			<div class="answer" id="answer_${list.FAQ_QNA_ID}">
				${list.ANSWER}</div>
		</c:forEach>
	</div>
</div>

