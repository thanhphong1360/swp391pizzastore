<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Ingredient Management | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Poppins', sans-serif; background:#fff8f3; margin:30px;}
    h2 { color:#e63946; font-weight:600; }
    .home-btn, .add-btn { border-radius:8px; font-weight:500; padding:8px 14px; text-decoration:none; color:white; transition:0.3s;}
    .home-btn { background:#718093; }
    .home-btn:hover { background:#9c9c9c; }
    .add-btn { background:#e63946; }
    .add-btn:hover { background:#c72e3b; }
    table { width:100%; border-collapse:collapse; margin-top:15px; background:#fff; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.1);}
    th { background:#e63946; color:white; padding:12px; }
    td { padding:10px; border-bottom:1px solid #eee; }
    tr:hover { background:#fff1ee; }
    .action { padding:5px 10px; border-radius:6px; color:white; text-decoration:none; font-size:13px; margin-right:5px; }
    .edit { background:#00a8ff; } .edit:hover { background:#0097e6; }
    .delete { background:#e84118; } .delete:hover { background:#c23616; }
    .restore { background:#44bd32; } .restore:hover { background:#4cd137; }
</style>
</head>
<body>
<div class="d-flex justify-content-between mb-3">
    <h2>Ingredient Management</h2>
    <a href="${pageContext.request.contextPath}/Home" class="home-btn">🏠 Back to Dashboard</a>
</div>

<a href="${pageContext.request.contextPath}/manager/ingredients?action=add" class="add-btn mb-3 d-inline-block">➕ Add Ingredient</a>

<table class="table table-striped">
    <thead>
        <tr>
            <th>ID</th><th>Name</th><th>Description</th><th>Unit</th><th>Quantity</th><th>Updated At</th><th>Status</th><th>Actions</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="i" items="${list}">
        <tr>
            <td>${i.ingredientId}</td>
            <td>${i.name}</td>
            <td>${i.description}</td>
            <td>${i.unit}</td>
            <td>${i.quantity}</td>
            <td>${i.updatedAt}</td>
            <td><span style="font-weight:bold; color:${i.status ? 'green' : 'red'};">${i.status ? 'Active' : 'Inactive'}</span></td>
            <td>
                <c:choose>
                    <c:when test="${i.status}">
                        <a href="${pageContext.request.contextPath}/manager/ingredients?action=edit&id=${i.ingredientId}" class="action edit">✏ Edit</a>
                        <a href="${pageContext.request.contextPath}/manager/ingredients?action=toggle&id=${i.ingredientId}" class="action delete" onclick="return confirm('Deactivate this ingredient?');">🗑 Deactivate</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/manager/ingredients?action=toggle&id=${i.ingredientId}" class="action restore" onclick="return confirm('Restore this ingredient?');">♻ Restore</a>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
        <c:if test="${not empty param.message}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <c:choose>
            <c:when test="${param.message eq 'added'}">✅ Ingredient added successfully!</c:when>
            <c:when test="${param.message eq 'updated'}">✅ Ingredient updated successfully!</c:when>
            <c:when test="${param.message eq 'deactivated'}">⚠️ Ingredient deactivated!</c:when>
            <c:when test="${param.message eq 'restored'}">✅ Ingredient restored!</c:when>
            <c:when test="${param.message eq 'error'}">❌ An error occurred!</c:when>
        </c:choose>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

    </tbody>
</table>
</body>
</html>
