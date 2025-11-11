<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chef Dashboard | Pizza House</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #fff8f3;
            margin: 0;
        }
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 240px;
            height: 100%;
            background-color: #2c2c2c;
            color: #fff;
            padding: 20px 15px;
        }
        .sidebar h3 {
            text-align: center;
            color: #e63946;
            margin-bottom: 25px;
        }
        .sidebar a {
            display: block;
            color: #ddd;
            text-decoration: none;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 8px;
            transition: 0.3s;
        }
        .sidebar a:hover {
            background-color: #e63946;
            color: #fff;
        }
        .content {
            margin-left: 260px;
            padding: 30px;
        }
        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #fff;
            padding: 12px 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .logout-btn {
            background-color: #e63946;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
        }
        .card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <h3>Pizza<span style="color:white;">House</span></h3>
        <a href="${pageContext.request.contextPath}/chef/Order?action=browse">📦 Orders</a>
        <a href="${pageContext.request.contextPath}/chef-ingredients">🥦 Ingredients</a>
    </div>

    <div class="content">
        <div class="topbar">
            <h4>Chef Dashboard</h4>
            <form action="${pageContext.request.contextPath}/Logout" method="post">
                <button class="logout-btn">Logout</button>
            </form>
        </div>

        <div class="row g-4 mt-4">
            <div class="col-md-6">
                <div class="card p-4 text-center">
                    <h5 class="card-title">Danh sách Order</h5>
                    <p>Xem và xử lý các món ăn đang được đặt.</p>
                    <form action="${pageContext.request.contextPath}/chef/Order" method="GET">
                        <input type="hidden" name="action" value="browse">
                        <button class="btn btn-outline-danger">Xem Orders</button>
                    </form>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card p-4 text-center">
                    <h5 class="card-title">Nguyên liệu</h5>
                    <p>Cập nhật tình trạng nguyên liệu trong bếp.</p>
                    <a href="${pageContext.request.contextPath}/chef-ingredients" class="btn btn-outline-danger">Cập nhật</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
