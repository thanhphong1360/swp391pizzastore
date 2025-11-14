<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password | Pizza House</title>
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
        .forgot-card {
            width: 400px;
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
        input[type=email] {
            width: 100%;
            padding: 10px 15px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-bottom: 15px;
            font-size: 15px;
        }
        input:focus {
            border-color: #e63946;
            box-shadow: 0 0 0 2px rgba(230,57,70,0.2);
            outline: none;
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
        .msg {
            margin-top: 15px;
            font-size: 14px;
        }
        .success { color: green; }
        .error { color: red; }
        .back-link {
            margin-top: 15px;
            display: block;
            font-size: 14px;
        }
        .back-link a {
            color: #e63946;
            text-decoration: none;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="forgot-card">
        <h2>Forgot Password?</h2>
        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
            <input type="email" name="email" placeholder="Enter your email" required />
            <button type="submit">Send Reset Link</button>
        </form>

        <div class="msg">
            <p class="success">${successMessage}</p>
            <p class="error">${errorMessage}</p>
        </div>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/view/client/pages/login.jsp">Back to Login</a>
        </div>
    </div>
</body>
</html>
