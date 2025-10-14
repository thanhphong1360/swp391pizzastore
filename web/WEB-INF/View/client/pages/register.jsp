<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, #74ABE2, #5563DE);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }

        .register-container {
            background-color: white;
            padding: 40px 35px;
            border-radius: 15px;
            box-shadow: 0px 8px 25px rgba(0,0,0,0.2);
            width: 400px;
            text-align: center;
            animation: fadeIn 0.5s ease;
        }

        h2 {
            color: #333;
            margin-bottom: 25px;
        }

        input {
            width: 100%;
            padding: 10px 12px;
            margin: 8px 0 16px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 15px;
            transition: 0.3s;
        }

        input:focus {
            border-color: #5563DE;
            box-shadow: 0 0 6px rgba(85,99,222,0.4);
            outline: none;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #5563DE;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background-color: #4151c4;
        }

        .message {
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 6px;
        }

        .success {
            background-color: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #a5d6a7;
        }

        .error {
            background-color: #ffebee;
            color: #c62828;
            border: 1px solid #ef9a9a;
        }

        a {
            color: #5563DE;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(20px);}
            to {opacity: 1; transform: translateY(0);}
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h2>📝 Create Your Account</h2>

        <c:if test="${not empty message}">
            <div class="message success">${message}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="message error">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <input type="text" name="name" placeholder="Full Name" required />
            <input type="email" name="email" placeholder="Email Address" required />
            <input type="password" name="password" placeholder="Password" required />
            <input type="password" name="confirm_password" placeholder="Confirm Password" required />
            <button type="submit">Register</button>
        </form>

        <p style="margin-top: 15px;">Already have an account? <a href="${pageContext.request.contextPath}/view/client/pages/login.jsp">Login</a></p>
    </div>
</body>
</html>
