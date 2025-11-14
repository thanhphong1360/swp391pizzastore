<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register | Pizza House</title>
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
        .register-card {
            width: 420px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            padding: 40px 30px;
            text-align: center;
        }
        h2 {
            color: #e63946;
            font-weight: 600;
            margin-bottom: 25px;
        }
        input, select {
            width: 100%;
            padding: 10px 15px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-bottom: 15px;
            font-size: 15px;
        }
        input:focus, select:focus {
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
        .alert-text {
            font-size: 14px;
            margin-top: 5px;
        }
        .success { color: green; }
        .error { color: red; }
        .link {
            margin-top: 15px;
            font-size: 14px;
        }
        .link a {
            color: #e63946;
            text-decoration: none;
            font-weight: 500;
        }
        .link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="register-card">
        <h2>Create Your Account 🍕</h2>

        <c:if test="${not empty message}">
            <p class="alert-text success">${message}</p>
        </c:if>
        <c:if test="${not empty error}">
            <p class="alert-text error">${error}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <input type="text" name="name" placeholder="Full Name" required />
            <input type="email" name="email" placeholder="Email Address" required />
            <input type="password" name="password" placeholder="Password" required />
            <input type="password" name="confirm_password" placeholder="Confirm Password" required />

            <button type="submit">Register</button>
        </form>

        <div class="link">
            Already have an account? <a href="${pageContext.request.contextPath}/view/client/pages/login.jsp">Login</a>
        </div>
    </div>
</body>
</html>
