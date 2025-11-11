<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Thêm Nguyên Liệu cho Món: ${menu.foodName}</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    body { font-family:'Poppins',sans-serif; background:#fff8f3; padding:30px; }
    h2 { color:#e63946; font-weight:600; text-align:center; margin-bottom:30px; }
    .card { max-width:600px; margin:auto; padding:30px; box-shadow:0 4px 12px rgba(0,0,0,0.1); border-radius:12px; background:#fff; }
    .btn-primary, .btn-secondary { border-radius:8px; padding:8px 14px; font-weight:500; transition:0.3s; }
    .btn-primary:hover { background:#c72e3b; border-color:#c72e3b; }
    .btn-secondary:hover { background:#6c757d; border-color:#6c757d; }
</style>
</head>
<body>

<div class="card">
    <h2>Thêm Nguyên Liệu cho Món: ${menu.foodName}</h2>

    <form action="${pageContext.request.contextPath}/manager/AddIngredientsOfFoodServlet" method="post">
        <input type="hidden" name="foodId" value="${menu.foodId}" />

        <div class="mb-3">
            <label for="ingredientId" class="form-label">Chọn Nguyên Liệu:</label>
            <select name="ingredientId" id="ingredientId" class="form-select" required>
                <option value="">-- Chọn nguyên liệu --</option>
                <c:forEach var="ingredient" items="${ingredients}">
                    <option value="${ingredient.ingredientId}">${ingredient.name}</option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label for="quantity" class="form-label">Số Lượng:</label>
            <input type="number" name="quantity" id="quantity" step="0.01" class="form-control" required placeholder="Nhập số lượng" />
        </div>

        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-primary">Thêm Nguyên Liệu</button>
            <a href="${pageContext.request.contextPath}/manager/ViewIngredientsOfFoodServlet?foodId=${menu.foodId}" class="btn btn-secondary">Quay Lại</a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
