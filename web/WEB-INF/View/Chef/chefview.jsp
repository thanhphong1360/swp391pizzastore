<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Chef Dashboard | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Poppins', sans-serif; background-color: #fff8f3; margin: 0; padding: 0; }
    .container { max-width: 900px; margin: 40px auto; }
    h2 { color: #e63946; font-weight: 600; text-align: center; margin-bottom: 30px; }
    table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); overflow: hidden; }
    th { background: #e63946; color: #fff; padding: 12px; text-align: center; }
    td { padding: 10px; text-align: center; vertical-align: middle; border-bottom: 1px solid #eee; }
    tr:hover { background: #fff1ee; }
    .quantity-input { width: 80px; text-align: center; padding: 5px; border-radius: 6px; border: 1px solid #ccc; }
    .btn-red { background: #e63946; color: white; padding: 6px 12px; border: none; border-radius: 8px; transition: 0.3s; }
    .btn-red:hover { background: #c72e3b; }
    .message { text-align: center; padding: 10px; margin-bottom: 15px; border-radius: 6px; }
    .success { background: #e7f9ee; color: #2e8b57; }
    .error { background: #fdecea; color: #d93025; }
    .back-link { display: inline-block; margin-bottom: 20px; text-decoration: none; color: #e63946; font-weight: 500; }
    .back-link:hover { text-decoration: underline; }
</style>
</head>
<body>
<div class="container">

    <a href="${pageContext.request.contextPath}/Home" class="back-link">← Back to Home</a>

    <h2>🍳 Chef - Ingredient Management</h2>

    <!-- Messages -->
    <c:if test="${param.message == 'quantityUpdated'}">
        <div class="message success">✅ Quantity updated successfully!</div>
    </c:if>
    <c:if test="${param.message == 'invalidQuantity'}">
        <div class="message error">⚠ Quantity must be a positive number.</div>
    </c:if>
    <c:if test="${param.message == 'error'}">
        <div class="message error">❌ An error occurred while updating.</div>
    </c:if>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Ingredient Name</th>
                <th>Description</th>
                <th>Unit</th>
                <th>Quantity</th>
                <th>Last Updated</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="ing" items="${list}">
                <tr>
                    <td>${ing.ingredientId}</td>
                    <td>${ing.name}</td>
                    <td>${ing.description}</td>
                    <td>${ing.unit}</td>
                    <td>
                        <form action="chef-ingredients" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="updateQuantity">
                            <input type="hidden" name="id" value="${ing.ingredientId}">
                            <input type="number" step="0.01" name="quantity" value="${ing.quantity}" class="quantity-input">
                    </td>
                    <td><fmt:formatDate value="${ing.updatedAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${ing.status}"><span class="text-success fw-bold">Active</span></c:when>
                            <c:otherwise><span class="text-danger fw-bold">Inactive</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                            <button type="submit" class="btn-red">Update</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr><td colspan="8">No ingredients available.</td></tr>
            </c:if>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
