<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Nguyên Liệu cho Món: ${menu.foodName}</title>
    <!-- Liên kết tới Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <h1 class="text-center mb-4">Thêm Nguyên Liệu cho Món: ${menu.foodName}</h1>

        <form action="${pageContext.request.contextPath}/manager/AddIngredientsOfFoodServlet" method="post">
            <input type="hidden" name="foodId" value="${menu.foodId}" />

            <div class="mb-3">
                <label for="ingredientId" class="form-label">Chọn Nguyên Liệu:</label>
                <select name="ingredientId" class="form-select" required>
                    <c:forEach var="ingredient" items="${ingredients}">
                        <option value="${ingredient.ingredientId}">${ingredient.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label for="quantity" class="form-label">Số Lượng:</label>
                <input type="number" name="quantity" class="form-control" step="0.01" required />
            </div>

            <div class="d-grid gap-2">
                <input type="submit" value="Thêm Nguyên Liệu" class="btn btn-success" />
            </div>
        </form>
    </div>

    <!-- Liên kết tới Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
