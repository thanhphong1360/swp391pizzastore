<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Create Discount | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
body { font-family:'Poppins',sans-serif; background:#fff8f3; margin:30px; }
h2 { color:#e63946; font-weight:600; }
.home-btn, .add-btn { border-radius:8px; font-weight:500; padding:8px 14px; text-decoration:none; color:white; transition:0.3s; }
.home-btn { background:#718093; }
.home-btn:hover { background:#9c9c9c; }
.add-btn { background:#e63946; }
.add-btn:hover { background:#c72e3b; }
.card { border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.1); }
.btn-primary { background:#e63946; border:none; }
.btn-primary:hover { background:#c72e3b; }
.btn-secondary { background:#718093; border:none; }
.btn-secondary:hover { background:#9c9c9c; }
</style>
</head>
<body>

<div class="d-flex justify-content-between mb-3">
    <h2>Create New Discount</h2>
    <a href="${pageContext.request.contextPath}/manager/discount/list" class="home-btn">🏠 Back to List</a>
</div>

<div class="card p-4 mb-4" style="max-width:700px; margin:auto;">
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form method="POST" action="${pageContext.request.contextPath}/manager/discount/add-discount" class="needs-validation" novalidate>
        <div class="mb-3">
            <label class="form-label">Code</label>
            <input type="text" name="code" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" rows="3" required></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Type</label>
            <input type="text" name="type" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Value</label>
            <input type="number" step="0.01" name="value" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Start Date</label>
            <input type="date" name="start_date" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">End Date</label>
            <input type="date" name="end_date" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Min Invoice Price</label>
            <input type="number" step="1" name="min_invoice_price" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Max Discount Amount</label>
            <input type="number" step="1" name="max_discount_amount" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Status</label>
            <select name="status" class="form-select" required>
                <option value="true">Active</option>
                <option value="false">Inactive</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">Create Discount</button>
        <a href="${pageContext.request.contextPath}/manager/discount/list" class="btn btn-secondary w-100 mt-2">Cancel</a>
    </form>
</div>

<script>
(function () {
    'use strict';
    var forms = document.querySelectorAll('.needs-validation');
    Array.prototype.slice.call(forms).forEach(function (form) {
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
})();
</script>

</body>
</html>
