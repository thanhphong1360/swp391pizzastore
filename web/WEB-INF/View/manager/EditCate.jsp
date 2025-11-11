<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Edit Category | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    body { font-family:'Poppins',sans-serif; background:#fff8f3; padding:40px; }
    h2 { color:#e63946; font-weight:600; margin-bottom:30px; text-align:center; }
    .form-label { font-weight:500; }
    .btn-red { background:#e63946; color:white; border-radius:8px; padding:8px 16px; transition:0.3s; }
    .btn-red:hover { background:#c72e3b; }
    .card { max-width:600px; margin:auto; padding:30px; box-shadow:0 4px 12px rgba(0,0,0,0.1); border-radius:12px; background:white; }
</style>
</head>
<body>
<div class="card">
    <h2>Edit Category</h2>
    <form action="${pageContext.request.contextPath}/manager/EditCategoryServlet" method="post">
        <input type="hidden" name="edit_cate_id" value="${c_edit.categoryId}">
        <div class="mb-3">
            <label class="form-label">Category Name <span class="text-danger">*</span></label>
            <input type="text" class="form-control" name="edit_cate_name" value="${c_edit.name}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Description</label>
            <input type="text" class="form-control" name="edit_cate_des" value="${c_edit.description}">
        </div>
        <div class="mb-3">
            <label class="form-label">Status</label><br>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="edit_cate_status" value="available" 
                    <c:if test="${c_edit.status == 'available'}">checked</c:if>>
                <label class="form-check-label">Available</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="edit_cate_status" value="unavailable"
                    <c:if test="${c_edit.status == 'unavailable'}">checked</c:if>>
                <label class="form-check-label">Unavailable</label>
            </div>
        </div>
        <button type="submit" class="btn btn-red w-100">Save Changes</button>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
