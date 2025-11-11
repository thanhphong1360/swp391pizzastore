<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add New Table | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    body { font-family:'Poppins',sans-serif; background:#fff8f3; margin:30px;}
    h2 { color:#e63946; font-weight:600; text-align:center; }
    .card { max-width:600px; margin:auto; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.1); padding:30px; }
    .form-label { font-weight:500; }
    .btn-red { background:#e63946; color:white; border-radius:8px; width:100%; transition:0.3s;}
    .btn-red:hover { background:#c72e3b; }
    .btn-gray { background:#718093; color:white; border-radius:8px; width:100%; transition:0.3s;}
    .btn-gray:hover { background:#9c9c9c; }
</style>
<script>
function validateForm() {
    let number = document.forms["addTableForm"]["table_number"].value.trim();
    let cap = document.forms["addTableForm"]["capacity"].value.trim();
    if(number=="" || cap=="") { alert("Please fill out all required fields."); return false;}
    if(isNaN(cap) || cap<=0) { alert("Capacity must be a positive number."); return false;}
    return true;
}
</script>
</head>
<body>
<div class="card">
    <h2>Add New Table</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form name="addTableForm" method="post" action="${pageContext.request.contextPath}/manager/table/add" onsubmit="return validateForm()">
        <div class="mb-3">
            <label class="form-label">Table Number <span class="text-danger">*</span></label>
            <input type="text" name="table_number" class="form-control"
                   value="${not empty param.table_number ? param.table_number : ''}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Capacity <span class="text-danger">*</span></label>
            <input type="number" name="capacity" class="form-control" min="1"
                   value="${not empty param.capacity ? param.capacity : ''}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Status</label>
            <select name="status" class="form-select">
                <option value="Available" ${param.status=='Available' ? 'selected' : ''}>Available</option>
                <option value="Occupied" ${param.status=='Occupied' ? 'selected' : ''}>Occupied</option>
                <option value="Reserved" ${param.status=='Reserved' ? 'selected' : ''}>Reserved</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Location</label>
            <input type="text" name="location" class="form-control" value="${not empty param.location ? param.location : ''}">
        </div>
        <button type="submit" class="btn btn-red mb-2">Add Table</button>
        <a href="${pageContext.request.contextPath}/manager/table/list" class="btn btn-gray">Cancel</a>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
