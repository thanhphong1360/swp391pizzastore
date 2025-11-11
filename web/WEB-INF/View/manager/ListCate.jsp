<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Category Management | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    body { font-family:'Poppins',sans-serif; background:#fff8f3; margin:30px; }
    h2 { color:#e63946; font-weight:600; text-align:center; margin-bottom:30px; }
    table { width:100%; border-collapse:collapse; margin-top:15px; background:#fff; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.1); }
    th { background:#e63946; color:white; padding:12px; text-align:center; }
    td { padding:10px; border-bottom:1px solid #eee; text-align:center; vertical-align:middle; }
    tr:hover { background:#fff1ee; }
    .btn-red { background:#e63946; color:white; border-radius:8px; padding:6px 12px; transition:0.3s; text-decoration:none; }
    .btn-red:hover { background:#c72e3b; }
    .btn-blue { background:#00a8ff; color:white; border-radius:6px; padding:5px 10px; font-size:13px; transition:0.3s; text-decoration:none; }
    .btn-blue:hover { background:#0097e6; }
    .btn-custom {
    border-radius: 10px;
    font-weight: 500;
    padding: 10px 18px;
    text-decoration: none;
    color: white;
    transition: 0.3s;
    border: none;
}
.btn-dashboard {
    background: #718093;
}
.btn-dashboard:hover {
    background: #909fad;
}

</style>
</head>
<body>
<div class="container">
      <div class="d-flex justify-content-between align-items-center mb-4">
   <h2>Category Management</h2>
    <div>
        <a href="${pageContext.request.contextPath}/Home" class="btn-custom btn-dashboard me-2">🏠 Back to Dashboard</a>

       <a href="${pageContext.request.contextPath}/manager/AddCategoryServlet" class="btn btn-red">➕ Add Category</a>
    </div>
</div>


    <div style="overflow-x:auto;">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Name</th>
                <th>Description</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="c" items="${cateList}">
                <tr>
                    <td>${c.name}</td>
                    <td>${c.description}</td>
                    <td>
                        <span class="badge ${c.status=='Active'?'bg-success':'bg-danger'}">${c.status}</span>
                    </td>
                    <td>
                        <form method="get" action="${pageContext.request.contextPath}/manager/EditCategoryServlet" style="display:inline;">
                            <input type="hidden" name="id_edit_cate" value="${c.categoryId}"/>
                            <button type="submit" class="btn btn-blue">Edit</button>
                        </form>
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
