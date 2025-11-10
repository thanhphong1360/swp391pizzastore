<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Danh Mục</title>
    <!-- Liên kết tới Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <h1 class="text-center mb-4">Chỉnh Sửa Danh Mục</h1>

        <!-- Form chỉnh sửa danh mục -->
        <form action="${pageContext.request.contextPath}/manager/EditCategoryServlet" method="post">
            <!-- Truyền categoryId vào form -->
            <input type="hidden" name="edit_cate_id" value="${c_edit.categoryId}" />

            <div class="mb-3">
                <label for="edit_cate_name" class="form-label">Tên Danh Mục:</label>
                <input type="text" class="form-control" name="edit_cate_name" id="edit_cate_name" value="${c_edit.name}" required />
            </div>

            <div class="mb-3">
                <label for="edit_cate_des" class="form-label">Mô Tả Chi Tiết:</label>
                <input type="text" class="form-control" name="edit_cate_des" id="edit_cate_des" value="${c_edit.description}" required />
            </div>

            <div class="mb-3">
                <label class="form-label">Tình Trạng:</label><br>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="edit_cate_status" value="available" id="status_available" ${c_edit.status == 'available' ? 'checked' : ''} required />
                    <label class="form-check-label" for="status_available">Có Sẵn</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="edit_cate_status" value="unavailable" id="status_unavailable" ${c_edit.status == 'unavailable' ? 'checked' : ''} required />
                    <label class="form-check-label" for="status_unavailable">Không Khả Dụng</label>
                </div>
            </div>

            <div class="d-grid gap-2">
                <input type="submit" value="Cập Nhật Danh Mục" class="btn btn-success" />
            </div>
        </form>
    </div>

    <!-- Liên kết tới Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
