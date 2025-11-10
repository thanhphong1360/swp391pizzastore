<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Nguyên Liệu Món: ${menu.foodName}</title>
    <!-- Liên kết tới Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <h1 class="text-center mb-4">Quản Lý Nguyên Liệu Món: ${menu.foodName}</h1>

        <!-- Hiển thị nguyên liệu -->
        <table class="table table-bordered table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Tên Nguyên Liệu</th>
                    <th>Số Lượng</th>
                    <th>Đơn Vị</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ing" items="${ingredients}">
                    <tr>
                        <td>${ing.name}</td>
                        <td>${ing.quantity}</td>
                        <td>${ing.unit}</td>
                        <td>
                            <!-- Sửa nguyên liệu -->
                            <a href="${pageContext.request.contextPath}/manager/EditIngredientsOfFoodServlet?ingredientId=${ing.ingredientId}&foodId=${menu.foodId}" class="btn btn-warning btn-sm">Sửa</a>
                            <!-- Xóa nguyên liệu -->
                            <form method="post" action="${pageContext.request.contextPath}/manager/DeleteIngredientsOfFoodServlet" class="d-inline-block">
                                <input type="hidden" name="ingredientId" value="${ing.ingredientId}">
                                <input type="hidden" name="foodId" value="${menu.foodId}">
                                <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Thêm nguyên liệu -->
        <div class="text-center">
            <a href="${pageContext.request.contextPath}/manager/AddIngredientsOfFoodServlet?foodId=${menu.foodId}" class="btn btn-success">Thêm Nguyên Liệu</a>
        </div>
    </div>

    <!-- Liên kết tới Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
