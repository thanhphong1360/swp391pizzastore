<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Nguyên Liệu - ${menu.foodName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #fff8f3;
            font-family: 'Poppins', sans-serif;
        }
        .card {
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h1 {
            color: #e63946;
            font-weight: 600;
        }
        .btn-back {
            background-color: #718093;
            color: white;
        }
        .btn-back:hover {
            background-color: #9c9c9c;
            color: white;
        }
        .form-label {
            font-weight: 500;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>Sửa Nguyên Liệu</h1>
        <a href="${pageContext.request.contextPath}/manager/ViewIngredientsOfFoodServlet?foodId=${menu.foodId}" class="btn btn-back">← Quay Lại</a>
    </div>

    <div class="card p-4">
        <form action="${pageContext.request.contextPath}/manager/EditIngredientsOfFoodServlet" method="post">
            <input type="hidden" name="foodId" value="${menu.foodId}" />
            <input type="hidden" name="ingredientId" value="${ingredient.ingredientId}" />

            <div class="mb-3">
                <label class="form-label">Nguyên Liệu:</label>
                <input type="text" class="form-control" value="${ingredient.name}" disabled />
            </div>

            <div class="mb-3">
                <label for="quantity" class="form-label">Số Lượng:</label>
                <input type="number" name="quantity" class="form-control" value="${ingredient.quantity}" step="0.01" required />
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-warning">Cập Nhật Nguyên Liệu</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
