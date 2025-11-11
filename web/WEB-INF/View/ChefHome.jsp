<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Chef Home | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #fff8f3;
        padding: 20px;
    }
    h1 {
        color: #e63946;
        text-align: center;
        margin-bottom: 30px;
        font-weight: 600;
    }
    .section-card {
        background: #fff;
        border-radius: 12px;
        padding: 25px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        margin-bottom: 20px;
        text-align: center;
        transition: 0.3s;
    }
    .section-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(0,0,0,0.15);
    }
    .btn-red {
        background-color: #e63946;
        color: white;
        border-radius: 8px;
        padding: 10px 20px;
        text-decoration: none;
        font-weight: 500;
        transition: 0.3s;
    }
    .btn-red:hover {
        background-color: #c72e3b;
    }
</style>
</head>
<body>

<jsp:include page="TopNav.jsp"></jsp:include>

<div class="container">
    <h1>Chef Dashboard</h1>

    <div class="row">
        <!-- Orders Section -->
        <div class="col-md-6">
            <div class="section-card">
                <h3>Orders</h3>
                <p>View and manage all current orders.</p>
                <form action="${pageContext.request.contextPath}/chef/Order" method="GET">
                    <input type="hidden" name="action" value="browse">
                    <button type="submit" class="btn-red">View Orders</button>
                </form>
            </div>
        </div>

        <!-- Ingredients Section -->
        <div class="col-md-6">
            <div class="section-card">
                <h3>Ingredients</h3>
                <p>Update and manage ingredient stock.</p>
                <a href="${pageContext.request.contextPath}/chef-ingredients" class="btn-red">Update Ingredients</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
