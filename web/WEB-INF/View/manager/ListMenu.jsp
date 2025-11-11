<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Menu Management | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    body { font-family:'Poppins',sans-serif; background:#fff8f3; margin:30px; }
    h2 { color:#e63946; font-weight:600; text-align:center; margin-bottom:30px; }
    .btn-red { background:#e63946; color:white; border-radius:8px; padding:8px 14px; transition:0.3s; }
    .btn-red:hover { background:#c72e3b; }
    .btn-gray { background:#718093; color:white; border-radius:8px; padding:8px 14px; transition:0.3s; }
    .btn-gray:hover { background:#9c9c9c; }
    table { width:100%; border-collapse:collapse; margin-top:15px; background:#fff; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.1); }
    th { background:#e63946; color:white; padding:12px; text-align:center; }
    td { padding:10px; border-bottom:1px solid #eee; text-align:center; vertical-align:middle; }
    tr:hover { background:#fff1ee; }
    img { border-radius:8px; }
    .action-btn { border-radius:6px; padding:5px 10px; font-size:13px; text-decoration:none; color:white; margin:2px; }
    .edit { background:#00a8ff; } .edit:hover { background:#0097e6; }
    .view { background:#44bd32; } .view:hover { background:#4cd137; }
</style>
</head>
<body>
<div class="container">

    <div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Menu Management</h2>
    <div>
        <a href="${pageContext.request.contextPath}/Home" class="btn btn-gray me-2">🏠 Back to Dashboard</a>
        <a href="${pageContext.request.contextPath}/manager/AddMenuServlet" class="btn btn-red">➕ Add Food</a>
    </div>
</div>

    <div style="overflow-x:auto;">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Food Name</th>
                <th>Category</th>
                <th>Description</th>
                <th>Size</th>
                <th>Price</th>
                <th>Status</th>
<!--                <th>Ingredients</th>-->
                <th>Image</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="f" items="${menuList}">
                <tr>
                    <td>${f.foodName}</td>
                    <td>${f.categoryName}</td>
                    <td>${f.description}</td>
                    <td>${f.size}</td>
                    <td><fmt:formatNumber value="${f.price}" type="number" maxFractionDigits="0"/> đ</td>
                    <td>
                        <span class="badge ${f.status=='Available'?'bg-success': f.status=='Sold Out'?'bg-danger':'bg-secondary'}">
                            ${f.status}
                        </span>
                    </td>
<!--                    <td>
                        <c:forEach var="ing" items="${f.ingredients}">
                            ${ing.name} - ${ing.quantity} ${ing.unit}<br>
                        </c:forEach>
                    </td>-->
                    <td>
                        <c:choose>
                            <c:when test="${not empty f.imgURL}">
                                <img src="${pageContext.request.contextPath}/${f.imgURL}" alt="${f.foodName}" width="80" height="80">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/images/no-image.png" alt="No image" width="80" height="80">
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/manager/EditMenuServlet?foodId=${f.foodId}" class="action-btn edit">Edit</a>
                        <a href="${pageContext.request.contextPath}/manager/ViewIngredientsOfFoodServlet?foodId=${f.foodId}" class="action-btn view">View Recipe</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
