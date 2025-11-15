<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Add New Menu | Pizza House</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <style>
            body {
                font-family:'Poppins',sans-serif;
                background:#fff8f3;
                padding:30px;
            }
            h2 {
                color:#e63946;
                font-weight:600;
                text-align:center;
                margin-bottom:30px;
            }
            .form-label {
                font-weight:500;
            }
            .btn-red {
                background:#e63946;
                color:white;
                border-radius:8px;
                padding:8px 14px;
                transition:0.3s;
            }
            .btn-red:hover {
                background:#c72e3b;
            }
            .btn-gray {
                background:#718093;
                color:white;
                border-radius:8px;
                padding:8px 14px;
                transition:0.3s;
            }
            .btn-gray:hover {
                background:#9c9c9c;
            }
            .card {
                max-width:700px;
                margin:auto;
                padding:30px;
                box-shadow:0 4px 12px rgba(0,0,0,0.1);
                border-radius:12px;
                background:#fff;
            }
        </style>
    </head>
    <body>

        <div class="card">
            <h2>Thêm Món Mới</h2>

            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger">${errorMsg}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/manager/AddMenuServlet" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="foodName" class="form-label">Tên món <span class="text-danger">*</span></label>
                    <input type="text" id="foodName" name="foodName" class="form-control" placeholder="Nhập tên món" value="${oldName}" required minlength="2" maxlength="100"
                           oninvalid="this.setCustomValidity('Vui lòng nhập tên món (tối thiểu 2 kí tự).')"
                           oninput="this.setCustomValidity('')">
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Mô tả <span class="text-danger">*</span></label>
                    <textarea id="description" name="description" rows="4" class="form-control" placeholder="Mô tả chi tiết món ăn" required minlength="2" maxlength="250"
                              oninvalid="this.setCustomValidity('Vui lòng nhập mô tả cho món ăn (tối thiểu 2 kí tự).')"
                              oninput="this.setCustomValidity('')">${oldDes}</textarea>
                </div>

                <div class="mb-3">
                    <label for="size" class="form-label">Kích cỡ <span class="text-danger">*</span></label>
                    <select name="size" id="size" class="form-select" required
                            oninvalid="this.setCustomValidity('Vui lòng chọn kích cỡ món ăn.')"
                            oninput="this.setCustomValidity('')">
                        <option value="">-- Chọn kích cỡ --</option>
                        <option value="Small" ${oldSize=='Small' ? 'selected' : ''}>Nhỏ</option>
                        <option value="Medium" ${oldSize=='Medium' ? 'selected' : ''}>Vừa</option>
                        <option value="Large" ${oldSize=='Large' ? 'selected' : ''}>Lớn</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="category_id" class="form-label">Danh mục <span class="text-danger">*</span></label>
                    <select name="category_id" id="category_id" class="form-select" required
                            oninvalid="this.setCustomValidity('Vui lòng chọn danh mục món ăn.')"
                            oninput="this.setCustomValidity('')">
                        <option value="">-- Chọn thể loại --</option>
                        <c:forEach var="cate" items="${categories}">
                            <option value="${cate.categoryId}" ${oldCategoryId == cate.categoryId ? 'selected' : ''}>${cate.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="price" class="form-label">Giá cả <span class="text-danger">*</span></label>
                    <input type="number" id="price" name="price" step="1" class="form-control" placeholder="Nhập giá món ăn" value="${oldPrice}" required min="0"
                           oninvalid="this.setCustomValidity('Vui lòng nhập giá món ăn (giá phải là số).')"
                           oninput="this.setCustomValidity('')">
                </div>

                <div class="mb-3">
                    <label class="form-label">Trạng thái <span class="text-danger">*</span></label><br>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="status" value="available" ${oldStatus == 'available' ? 'checked' : ''} required
                               oninvalid="this.setCustomValidity('Vui lòng chọn tình trạng món ăn.')"
                               onclick="this.setCustomValidity('')">
                        <label class="form-check-label" for="available">Có sẵn</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="status" value="unavailable" ${oldStatus == 'unavailable' ? 'checked' : ''}
                               onclick="this.setCustomValidity('')">
                        <label class="form-check-label" for="unavailable">Hết hàng</label>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="imageUrl" class="form-label">Hình ảnh</label>
                    <input type="file" id="imageUrl" name="imageUrl" class="form-control" accept="image/*">
                    
                </div>

                <button type="submit" class="btn btn-red w-100">Lưu Món</button>
                <a href="${pageContext.request.contextPath}/manager/ListMenuServlet" class="btn btn-gray w-100 mt-2">Hủy</a>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
