<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Món Mới</title>
        <!-- Bootstrap 5 CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <script>
            // Kiểm tra khi submit form
            function validateForm() {
                var price = document.getElementById("price").value;

                // Kiểm tra xem giá trị có phải là số và không âm
                if (price < 0 || isNaN(price)) {
                    alert("Vui lòng nhập giá hợp lệ (không âm).");
                    return false;  // Dừng việc submit nếu có lỗi
                }

                // Nếu không có lỗi, form sẽ được submit
                return true;
            }
        </script>
    </head>
    <body class="bg-light">

        <!-- Thêm Món Mới -->
        <div class="container py-5">
            <h1 class="text-center mb-4">Thêm Món Mới</h1>
            
            <form action="${pageContext.request.contextPath}/manager/AddMenuServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                <!-- Tên món -->
                <div class="mb-3">
                    <label for="foodName" class="form-label">Tên món:</label>
                    <input type="text" id="foodName" name="foodName" class="form-control" required placeholder="Nhập tên món" />
                </div>

                <!-- Mô tả chi tiết -->
                <div class="mb-3">
                    <label for="description" class="form-label">Mô tả chi tiết:</label>
                    <textarea id="description" name="description" class="form-control" rows="4" required placeholder="Mô tả chi tiết món ăn"></textarea>
                </div>

                <!-- Kích cỡ -->
                <div class="mb-3">
                    <label for="size" class="form-label">Kích cỡ:</label>
                    <select name="size" id="size" class="form-select" required>
                        <option value="">-- Chọn kích cỡ --</option>
                        <option value="Small">Nhỏ</option>
                        <option value="Medium">Vừa</option>
                        <option value="Large">Lớn</option>
                    </select>
                </div>
                
                <!-- Danh mục -->
                <div class="mb-3">
                    <label for="category_id" class="form-label">Danh mục:</label>
                    <select name="category_id" id="category_id" class="form-select" required>
                        <option value="">-- Chọn thể loại --</option>
                        <c:forEach var="cate" items="${categories}">
                            <option value="${cate.categoryId}">${cate.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Giá -->
                <div class="mb-3">
                    <label for="price" class="form-label">Giá cả:</label>
                    <input type="number" id="price" name="price" class="form-control" step="0.01" required placeholder="Nhập giá món ăn" />
                </div>

                <!-- Tình trạng -->
                <div class="mb-3">
                    <p>Tình trạng:</p>
                    <div class="form-check form-check-inline">
                        <input type="radio" name="status" value="available" class="form-check-input" required />
                        <label class="form-check-label">Có sẵn</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" name="status" value="unavailable" class="form-check-input" required />
                        <label class="form-check-label">Hết hàng</label>
                    </div>
                </div>

                <!-- Hình ảnh -->
                <div class="mb-3">
                    <label for="imageUrl" class="form-label">Hình ảnh:</label>
                    <input type="file" id="imageUrl" name="imageUrl" class="form-control" accept="image/*" />
                </div>

                <!-- Submit -->
                <div class="mb-3 text-center">
                    <button type="submit" class="btn btn-primary w-100">Lưu Món</button>
                </div>
            </form>
        </div>

        <!-- Bootstrap JS (for modal, dropdown, etc.) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
