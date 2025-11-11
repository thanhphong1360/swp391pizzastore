<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add Category | Pizza House</title>
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
    <h2>Add New Category</h2>
    <form action="${pageContext.request.contextPath}/manager/AddCategoryServlet" method="post">
        <div class="mb-3">
            <label class="form-label">Category Name <span class="text-danger">*</span></label>
            <input type="text" class="form-control" name="add_cate_name" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Description</label>
            <input type="text" class="form-control" name="add_cate_des">
        </div>
        <div class="mb-3">
            <label class="form-label">Status</label><br>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="add_cate_status" value="available" required>
                <label class="form-check-label">Available</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="add_cate_status" value="unavailable" required>
                <label class="form-check-label">Unavailable</label>
            </div>
        </div>
        <button type="submit" class="btn btn-red w-100">Save Category</button>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
