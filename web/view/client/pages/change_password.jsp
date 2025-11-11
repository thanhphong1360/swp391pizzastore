<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Change Password | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: #fff8f3;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        padding: 20px;
    }
    .card {
        background: #fff;
        padding: 30px 35px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        max-width: 400px;
        width: 100%;
        text-align: center;
    }
    h2 {
        color: #e63946;
        margin-bottom: 25px;
        font-weight: 600;
    }
    .form-control {
        border-radius: 8px;
        padding: 10px;
        margin-bottom: 15px;
    }
    .btn-red {
        background: #e63946;
        color: white;
        border-radius: 8px;
        padding: 10px;
        width: 100%;
        transition: 0.3s;
    }
    .btn-red:hover {
        background: #c72e3b;
    }
    .msg p {
        font-size: 14px;
        margin: 10px 0 5px;
    }
    .msg .success { color: green; }
    .msg .error { color: red; }
    .back-link {
        display: inline-block;
        margin-top: 10px;
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
<div class="card">
    <h2>Change Password</h2>

    <form id="changeForm" action="change-password" method="post" onsubmit="return validateForm()">
        <input type="hidden" name="token" value="${param.token}">
        <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="Enter new password" required>
        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm new password" required>
        <button type="submit" class="btn-red">Change Password</button>
    </form>

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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
