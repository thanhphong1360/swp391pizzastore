<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login | Pizza House</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #ffe5d9, #fff8f3);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            width: 400px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            padding: 40px 30px;
            text-align: center;
        }
        h1 {
            color: #e63946;
            font-weight: 600;
            margin-bottom: 25px;
        }
        input {
            width: 100%;
            padding: 10px 15px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-bottom: 15px;
            font-size: 15px;
        }
        input:focus {
            outline: none;
            border-color: #e63946;
            box-shadow: 0 0 0 2px rgba(230,57,70,0.2);
        }
        button {
            width: 100%;
            background-color: #e63946;
            color: white;
            border: none;
            padding: 10px 0;
            border-radius: 8px;
            font-weight: 600;
            transition: 0.3s;
        }
        button:hover {
            background-color: #c72e3b;
        }
        .links a {
            display: inline-block;
            margin-top: 12px;
            color: #e63946;
            text-decoration: none;
            font-size: 14px;
        }
        .links a:hover {
            text-decoration: underline;
        }
        .alert-text {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <div class="login-card">
        <h1>Login</h1>
        <form action="${pageContext.request.contextPath}/Login" method="POST">
            <input type="email" name="username" placeholder="Email" required />
            <input type="password" name="password" placeholder="Password" required />
            <button type="submit">Sign In</button>
        </form>

        <div class="links">
            <a href="${pageContext.request.contextPath}/register">Sign Up</a> |
            <a href="${pageContext.request.contextPath}/view/client/pages/forgot_password.jsp">Forgot Password?</a>
        </div>

        <c:if test="${alert != null}">
            <p class="alert-text">${alert}</p>
        </c:if>
    </div>

</body>
</html>
