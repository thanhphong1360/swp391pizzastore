<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Edit Menu | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    body { font-family:'Poppins',sans-serif; background:#fff8f3; padding:30px; }
    h2 { color:#e63946; font-weight:600; text-align:center; margin-bottom:30px; }
    .form-label { font-weight:500; }
    .btn-red { background:#e63946; color:white; border-radius:8px; padding:8px 14px; transition:0.3s; }
    .btn-red:hover { background:#c72e3b; }
    .card { max-width:700px; margin:auto; padding:30px; box-shadow:0 4px 12px rgba(0,0,0,0.1); border-radius:12px; background:#fff; }
    img.current-img { margin-bottom:15px; border-radius:8px; }
</style>
</head>
<body>

<div class="card">
    <h2>Chỉnh Sửa Món</h2>

    <form action="${pageContext.request.contextPath}/manager/EditMenuServlet" 
          method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
        
        <input type="hidden" name="foodId" value="${menu.foodId}"/>

        <!-- Tên món -->
        <div class="mb-3">
            <label for="foodName" class="form-label">Tên món <span class="text-danger">*</span></label>
            <input type="text" id="foodName" name="foodName" class="form-control" 
                   value="${menu.foodName}" required>
        </div>

        <!-- Mô tả -->
        <div class="mb-3">
            <label for="description" class="form-label">Mô tả chi tiết <span class="text-danger">*</span></label>
            <textarea id="description" name="description" rows="4" class="form-control" required>${menu.description}</textarea>
        </div>

        <!-- Kích cỡ -->
        <div class="mb-3">
            <label for="size" class="form-label">Kích cỡ <span class="text-danger">*</span></label>
            <select name="size" id="size" class="form-select" required>
                <option value="Small" ${menu.size == 'Small' ? 'selected' : ''}>Nhỏ</option>
                <option value="Medium" ${menu.size == 'Medium' ? 'selected' : ''}>Vừa</option>
                <option value="Large" ${menu.size == 'Large' ? 'selected' : ''}>Lớn</option>
            </select>
        </div>

        <!-- Danh mục -->
        <div class="mb-3">
            <label for="category_id" class="form-label">Danh mục <span class="text-danger">*</span></label>
            <select name="category_id" id="category_id" class="form-select" required>
                <c:forEach var="cate" items="${categories}">
                    <option value="${cate.categoryId}" ${menu.categoryId == cate.categoryId ? 'selected' : ''}>
                        ${cate.name}
                    </option>
                </c:forEach>
            </select>
        </div>

        <!-- Giá -->
        <div class="mb-3">
            <label for="price" class="form-label">Giá cả <span class="text-danger">*</span></label>
            <input type="number" id="price" name="price" step="0.01" class="form-control" value="${menu.price}" required>
        </div>

        <!-- Tình trạng -->
        <div class="mb-3">
            <label class="form-label">Tình trạng <span class="text-danger">*</span></label><br>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="status" id="available" value="available" ${menu.status=='available' ? 'checked' : ''} required>
                <label class="form-check-label" for="available">Có sẵn</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="status" id="unavailable" value="unavailable" ${menu.status=='unavailable' ? 'checked' : ''}>
                <label class="form-check-label" for="unavailable">Hết hàng</label>
            </div>
        </div>

        <!-- Hình ảnh -->
        <div class="mb-3">
            <label class="form-label">Hình ảnh hiện tại</label><br>
            <c:choose>
                <c:when test="${not empty menu.imgURL}">
                    <img src="${pageContext.request.contextPath}/${menu.imgURL}" alt="Current Image" class="current-img" width="120" height="120">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/images/no-image.png" alt="No Image" class="current-img" width="120" height="120">
                </c:otherwise>
            </c:choose>
            <input type="file" id="imageUrl" name="imageUrl" class="form-control mt-2" accept="image/*">
        </div>

        <!-- Submit -->
        <button type="submit" class="btn btn-red w-100">Lưu Món</button>
        <a href="${pageContext.request.contextPath}/manager/ListMenuServlet" class="btn btn-secondary w-100 mt-2">Hủy</a>
    </form>
</div>

<script>
(function () {
    'use strict';
    const forms = document.querySelectorAll('.needs-validation');
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
