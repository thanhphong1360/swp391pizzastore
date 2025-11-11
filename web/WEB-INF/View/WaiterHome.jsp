<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Waiter Dashboard | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #fff8f3;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 900px;
        margin: 50px auto;
        text-align: center;
    }
    h1 {
        color: #e63946;
        font-weight: 600;
        margin-bottom: 40px;
    }
    .btn-action {
        background-color: #e63946;
        color: #fff;
        font-weight: 600;
        padding: 18px 30px;
        margin: 15px;
        border-radius: 10px;
        font-size: 18px;
        text-decoration: none;
        display: inline-block;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }
    .btn-action:hover {
        background-color: #c72e3b;
        transform: translateY(-3px);
    }
    .actions {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
    }
</style>
</head>
<body>

<div class="container">
    <jsp:include page="TopNav.jsp"></jsp:include>
    <h1>Waiter Dashboard</h1>
    <div class="actions">
        <form action="${pageContext.request.contextPath}/waiter/Table" method="GET" style="display:inline-block;">
            <input type="hidden" name="action" value="open">
            <button type="submit" class="btn-action">Open Table</button>
        </form>

        <form action="${pageContext.request.contextPath}/waiter/Order" method="GET" style="display:inline-block;">
            <input type="hidden" name="action" value="open">
            <button type="submit" class="btn-action">Order Food</button>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
