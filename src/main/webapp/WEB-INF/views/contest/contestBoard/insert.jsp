<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<style type="text/css">
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f5f5f5;
}

.container {
    padding: 20px;
    max-width: 800px;
    margin: 50px auto;
    background-color: #fff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    background-color: #e7ebf7; /* Container background color */
}

h1 {
    font-size: 2em;
    margin-bottom: 20px;
    text-align: center;
    color: #333;
}

form {
    display: flex;
    flex-direction: column;
    background-color: #ffffff; /* Form background color */
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

form div {
    margin-bottom: 15px;
}

label {
    margin-bottom: 5px;
    font-weight: bold;
    color: #333;
}

input[type="text"], textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    background-color: #f9f9f9; /* Input field background color */
}

textarea {
    resize: vertical;
}

button[type="submit"] {
    width: 100px;
    padding: 10px;
    background-color: #007BFF; /* Button background color */
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    align-self: center;
    transition: background-color 0.3s ease;
}

button[type="submit"]:hover {
    background-color: #0056b3; /* Button hover color */
}
</style>
</head>
<body>
    <div class="container">
        <h1>글쓰기</h1>
        <form action="ContentInsert" method="get">
            <div>
                <label for="title">제목:</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div>
                <label for="content">내용:</label>
                <textarea id="content" name="content" rows="10" required></textarea>
            </div>
            <div>
                <button type="submit">등록</button>
            </div>
        </form>
    </div>
</body>
</html>