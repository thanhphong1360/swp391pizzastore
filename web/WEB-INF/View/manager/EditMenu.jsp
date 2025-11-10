<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chỉnh Sửa Món</title>
        <!-- Bootstrap 5 CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">

        <div class="container py-5">
            <h1 class="text-center mb-4">Chỉnh Sửa Món</h1>

            <!-- Form chỉnh sửa món -->
            <form action="${pageContext.request.contextPath}/manager/EditMenuServlet" method="post" enctype="multipart/form-data">
                
                <!-- Thêm foodId ẩn -->
                <input type="hidden" name="foodId" value="${menu.foodId}" />

                <!-- Tên món -->
                <div class="mb-3">
                    <label for="foodName" class="form-label">Tên món:</label>
                    <input type="text" id="foodName" name="foodName" class="form-control" value="${menu.foodName}" required placeholder="Nhập tên món" />
                </div>

                <!-- Mô tả chi tiết -->
                <div class="mb-3">
                    <label for="description" class="form-label">Mô tả chi tiết:</label>
                    <textarea id="description" name="description" class="form-control" rows="4" required placeholder="Mô tả chi tiết món ăn">${menu.description}</textarea>
                </div>

                <!-- Kích cỡ -->
                <div class="mb-3">
                    <label for="size" class="form-label">Kích cỡ:</label>
                    <select name="size" id="size" class="form-select" required>
                        <option value="Small" ${menu.size == 'Small' ? 'selected' : ''}>Nhỏ</option>
                        <option value="Medium" ${menu.size == 'Medium' ? 'selected' : ''}>Vừa</option>
                        <option value="Large" ${menu.size == 'Large' ? 'selected' : ''}>Lớn</option>
                    </select>
                </div>
                
                <!-- Danh mục -->
                <div class="mb-3">
                    <label for="category_id" class="form-label">Danh mục:</label>
                    <select name="category_id" id="category_id" class="form-select" required>
                        <c:forEach var="cate" items="${categories}">
                            <option value="${cate.categoryId}" ${menu.categoryId == cate.categoryId ? 'selected' : ''}>${cate.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Giá -->
                <div class="mb-3">
                    <label for="price" class="form-label">Giá cả:</label>
                    <input type="number" id="price" name="price" class="form-control" step="0.01" value="${menu.price}" required placeholder="Nhập giá món ăn" />
                </div>

                <!-- Tình trạng -->
                <div class="mb-3">
                    <p>Tình trạng:</p>
                    <div class="form-check form-check-inline">
                        <input type="radio" name="status" value="available" class="form-check-input" ${menu.status == 'available' ? 'checked' : ''} required />
                        <label class="form-check-label">Có sẵn</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="radio" name="status" value="unavailable" class="form-check-input" ${menu.status == 'unavailable' ? 'checked' : ''} required />
                        <label class="form-check-label">Hết hàng</label>
                    </div>
                </div>

                <!-- Hình ảnh -->
                <div class="mb-3">
                    <label for="imageUrl" class="form-label">Hình ảnh hiện tại:</label><br>
                    <img src="${pageContext.request.contextPath}/${menu.imgURL}" alt="Current Image" width="80" height="80" class="img-thumbnail"><br><br>
                    <label for="imageUrl" class="form-label">Chọn hình ảnh mới:</label>
                    <input type="file" id="imageUrl" name="imageUrl" class="form-control" accept="image/*" />
                </div>

                <!-- Submit -->
                <div class="mb-3 text-center">
                    <button type="submit" class="btn btn-primary w-100">Cập nhật Món</button>
                </div>
            </form>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
