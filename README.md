#  쇼핑몰 기반 헬스 커뮤니티 웹 프로젝트

## 📌 소개
운동에 대한 관심이 많은 팀원들이 모여 시작한 프로젝트입니다.  
이 프로젝트는 헬스 케어 관련 정보와 제품을 한 곳에서 제공하는 통합 플랫폼을 개발하는 것을 목표로 했습니다.    
사용자가 여러 사이트를 방문하지 않아도 필요한 정보를 얻고, 다양한 사용자들과 의견을 나누며, 쇼핑까지 편리하게 할 수 있도록 돕는 것을 목표로 하고 있습니다.  

## 📌 주요 기능
- 🛒 **쇼핑몰 기능**: 상품 구매 및 장바구니 기능
- 🔐 **로그인, 회원관리**: Spring Security, OAuth2 이용한 보안 기능
- 🏷 **욕설 필터링**: 클린 커뮤니티 유지
- 📑 **고객 지원 페이지**: 공지사항, FAQ 등 제공

## 📌 데모 영상
👉 https://www.youtube.com/watch?v=FGupQuCDWHM

## 📌 기술 스택
![Java](https://img.shields.io/badge/Java-17-orange?style=for-the-badge&logo=java)   
![Spring Boot](https://img.shields.io/badge/SpringBoot-3.3.3-green?style=for-the-badge&logo=spring)  
![Oracle](https://img.shields.io/badge/Oracle-Database-red?style=for-the-badge&logo=oracle)  
![OAuth2](https://img.shields.io/badge/OAuth2-Security-critical?style=for-the-badge&logo=auth0)

## 📌 프로젝트 구조
📦 프로젝트 루트  
 ┣ 📂 src  
 ┃ ┣ 📂 main  
 ┃ ┃ ┣ 📂 java  
 ┃ ┃ ┃ ┣ 📂 com.example  
 ┃ ┃ ┃ ┃ ┣ 📂 badwordfiltering  
 ┃ ┃ ┃ ┃ ┣ 📂 config  
 ┃ ┃ ┃ ┃ ┣ 📂 controller  
 ┃ ┃ ┃ ┃ ┣ 📂 dao  
 ┃ ┃ ┃ ┃ ┣ 📂 dto  
 ┃ ┃ ┃ ┃ ┣ 📂 entity  
 ┃ ┃ ┃ ┃ ┣ 📂 oauth2  
 ┃ ┃ ┃ ┃ ┣ 📂 repository  
 ┃ ┃ ┃ ┃ ┣ 📂 security  
 ┃ ┃ ┃ ┃ ┣ 📂 service  
 ┃ ┃ ┃ ┃ ┣ 📂 util  
 ┃ ┃ ┃ ┃ ┗ 📜 ShoppingMallApplication.java  
 ┃ ┃ ┣ 📂 resources  
 ┃ ┃ ┃ ┣ 📂 static  
 ┃ ┃ ┃ ┃ ┣ 📂 css  
 ┃ ┃ ┃ ┃ ┣ 📂 images  
 ┃ ┃ ┃ ┃ ┣ 📂 img  
 ┃ ┃ ┃ ┃ ┗ 📂 js  
 ┃ ┃ ┃ ┗ 📜 application.properties  
 ┃ ┃ ┣ 📂 webapp  
 ┃ ┃ ┃ ┣ 📂 WEB-INF  
 ┃ ┃ ┃ ┃ ┗ 📂 views  
 ┗ 📜 pom.xml  

