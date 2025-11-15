<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Add Category | Pizza House</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <style>
            body {
                font-family:'Poppins',sans-serif;
                background:#fff8f3;
                padding:40px;
            }
            h2 {
                color:#e63946;
                font-weight:600;
                margin-bottom:30px;
                text-align:center;
            }
            .form-label {
                font-weight:500;
            }
            .btn-red {
                background:#e63946;
                color:white;
                border-radius:8px;
                padding:8px 16px;
                transition:0.3s;
            }
            .btn-red:hover {
                background:#c72e3b;
            }
            .card {
                max-width:600px;
                margin:auto;
                padding:30px;
                box-shadow:0 4px 12px rgba(0,0,0,0.1);
                border-radius:12px;
                background:white;
            }
        </style>
    </head>
    <body>
        <div class="card">
            <h2>Thêm Danh mục món ăn</h2>
            <c:if test="${not empty requestScope.errorMsg}">
                <div class="alert alert-danger">${requestScope.errorMsg}</div>
            </c:if>
            <form action="${pageContext.request.contextPath}/manager/AddCategoryServlet" method="post">
                <div class="mb-3">
                    <label class="form-label">Tên Danh mục<span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="add_cate_name" minlength="2" maxlength="100" required value="${oldName}" oninvalid="this.setCustomValidity('Vui lòng nhập tên danh mục (tối thiểu 2 kí tự).')"
                           oninput="this.setCustomValidity('')">
                </div>
                <div class="mb-3">
                    <label class="form-label">Mô tả</label>
                    <input type="text" class="form-control" name="add_cate_des" minlength="2" maxlength="255" required value="${oldDes}" oninvalid="this.setCustomValidity('Vui lòng nhập mô tả cho danh mục (tối thiểu 2 kí tự).')"
                           oninput="this.setCustomValidity('')">
                </div>
                <div class="mb-3">
                    <label class="form-label">Trạng thái</label><br>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="add_cate_status" value="available" required oninvalid="this.setCustomValidity('Vui lòng chọn trạng thái danh mục.')"
                               onclick="this.setCustomValidity('')">
                        <label class="form-check-label">Khả dụng</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="add_cate_status" value="unavailable" onclick="this.setCustomValidity('')">
                        <label class="form-check-label">Không khả dụng</label>
                    </div>
                </div>

                <button type="submit" class="btn btn-red w-100 mb-3">Lưu danh mục</button>

                <a href="${pageContext.request.contextPath}/manager/ListCategoryServlet"
                   class="btn btn-outline-secondary w-100">
                    ⬅ Quay lại danh sách
                </a>
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
