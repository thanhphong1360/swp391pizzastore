<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Danh Mục</title>
    <!-- Liên kết tới Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <div class="container mt-4">
        <h1 class="text-center mb-4">Danh Mục</h1>

        <!-- Nút thêm danh mục -->
        <div class="d-flex justify-content-end mb-4">
            <form method="get" action="${pageContext.request.contextPath}/manager/AddCategoryServlet">
                <button type="submit" class="btn btn-primary">Thêm Danh Mục</button>
            </form>
        </div>

        <!-- Bảng danh mục -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                        <thead class="table-dark">
                            <tr>
                                <th>Danh mục</th>
                                <th>Mô tả</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${cateList}">
                                <tr>
                                    <td>${c.name}</td>
                                    <td style="max-width: 180px;">${c.description}</td>
                                    <td>
                                        <span class="badge ${c.status == 'active' ? 'bg-success' : 'bg-secondary'}">${c.status}</span>
                                    </td>
                                    <td>
                                        <form method="get" action="${pageContext.request.contextPath}/manager/EditCategoryServlet" class="d-inline-block">
                                            <input type="hidden" name="id_edit_cate" value="${c.categoryId}"/>
                                            <button type="submit" class="btn btn-warning btn-sm">Sửa</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Liên kết tới Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
