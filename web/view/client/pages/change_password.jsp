<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Change Password</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f6f7fb;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                background: #fff;
                padding: 30px 40px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                width: 380px;
                text-align: center;
            }
            h2 {
                margin-bottom: 20px;
            }
            input[type=password] {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 6px;
            }
            button {
                width: 100%;
                background-color: #007BFF;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
            }
            button:hover {
                background-color: #0056b3;
            }
            .msg {
                margin-top: 15px;
                font-size: 14px;
            }
            .success {
                color: green;
            }
            .error {
                color: red;
            }
            .back-link {
                margin-top: 10px;
                display: inline-block;
                color: #007bff;
                text-decoration: none;
                font-size: 14px;
            }
            .back-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Change Password</h2>

            <form id="changeForm" action="change-password" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="token" value="${param.token}">
                <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password" required>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password" required>
                <button type="submit">Change Password</button>
            </form>

            <!-- ✅ Hiển thị message và link quay lại login -->
            <!-- ✅ Hiển thị message và link quay lại login -->
            <div class="msg">
                <c:if test="${not empty successMessage}">
                    <p class="success">${successMessage}</p>
                    <a href="${pageContext.request.contextPath}/view/client/pages/login.jsp" class="back-link">
                        ← Back to Login
                    </a>
                </c:if>

                <c:if test="${not empty errorMessage}">
                    <p class="error">${errorMessage}</p>
                </c:if>
            </div>

        </div>

        <script>
            function validateForm() {
                const newPass = document.getElementById("newPassword").value.trim();
                const confirmPass = document.getElementById("confirmPassword").value.trim();
                if (newPass !== confirmPass) {
                    alert("Passwords do not match. Please re-enter.");
                    return false;
                }
                if (newPass.length < 6) {
                    alert("Password must be at least 6 characters long.");
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>
