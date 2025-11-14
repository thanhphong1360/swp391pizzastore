<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Access Denied | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #fffbea;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .card {
        background: #fef3c7;
        border: 2px solid #facc15;
        border-radius: 12px;
        padding: 40px 50px;
        text-align: center;
        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        max-width: 500px;
        width: 90%;
        transition: transform 0.3s ease;
    }
    .card:hover {
        transform: translateY(-5px);
    }
    h1 {
        color: #d97706;
        font-size: 24px;
        font-weight: 600;
        margin-bottom: 30px;
    }
    .btn-home {
        background-color: #facc15;
        color: #fff;
        font-weight: 600;
        padding: 12px 25px;
        border-radius: 8px;
        text-decoration: none;
        transition: background-color 0.3s ease;
    }
    .btn-home:hover {
        background-color: #eab308;
    }
</style>
</head>
<body>

<div class="card">
    <h1>🚫 Bạn không có quyền truy cập vào mục này!</h1>
    <a href="${pageContext.request.contextPath}/Home" class="btn-home">Về Trang Chủ</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
