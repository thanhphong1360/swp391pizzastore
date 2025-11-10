<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Nguyên Liệu cho Món: ${menu.foodName}</title>
    <!-- Liên kết tới Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <h1 class="text-center mb-4">Sửa Nguyên Liệu cho Món: ${menu.foodName}</h1>

        <!-- Form để sửa nguyên liệu -->
        <form action="${pageContext.request.contextPath}/manager/EditIngredientsOfFoodServlet" method="post">
            <input type="hidden" name="foodId" value="${menu.foodId}" />
            <input type="hidden" name="ingredientId" value="${ingredient.ingredientId}" />

            <div class="mb-3">
                <label for="ingredientId" class="form-label">Nguyên Liệu:</label>
                <input type="text" class="form-control" value="${ingredient.name}" disabled />
            </div>

            <div class="mb-3">
                <label for="quantity" class="form-label">Số Lượng Hiện Tại:</label>
                <input type="number" name="quantity" class="form-control" value="${ingredient.quantity}" step="0.01" required />
            </div>

            <div class="d-grid gap-2">
                <input type="submit" value="Cập Nhật Nguyên Liệu" class="btn btn-warning" />
            </div>
        </form>
    </div>

    <!-- Liên kết tới Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
