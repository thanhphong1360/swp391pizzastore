<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý menu</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="d-flex">
            <div class="col-3">
                <jsp:include page="/WEB-INF/View/ManagerHome.jsp"></jsp:include>
            </div>

            <div class="container-fluid">
                <div class="row">

                    <div class="col-12 col-md-10 col-lg-10 p-4">

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h3 class="mb-0">Menu</h3>
                            <form method="get" action="${pageContext.request.contextPath}/manager/AddMenuServlet" class="mb-0">
                            <button type="submit" class="btn btn-primary">Thêm món mới</button>
                        </form>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered align-middle">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Tên món</th>
                                            <th>Danh mục</th>
                                            <th>Mô tả</th>
                                            <th>Kích cỡ</th>
                                            <th>Giá</th>
                                            <th>Trạng thái</th>
                                            <th>Nguyên liệu</th>
                                            <th>Hình ảnh</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="f" items="${menuList}">
                                            <tr>
                                                <td>${f.foodName}</td>
                                                <td>${f.categoryName}</td>
                                                <td style="max-width: 180px;">${f.description}</td>
                                                <td>${f.size}</td>
                                                <td>
                                                    <fmt:formatNumber value="${f.price}" type="number" maxFractionDigits="0"/> đ
                                                </td>
                                                <td>
                                                    <span class="badge ${f.status == 'available' ? 'bg-success' : 'bg-secondary'}">
                                                        ${f.status}
                                                    </span>
                                                </td>
                                                <td style="max-width: 200px;">
                                                    <c:forEach var="ing" items="${f.ingredients}">
                                                        ${ing.name} - ${ing.quantity} ${ing.unit}<br/>
                                                    </c:forEach>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty f.imgURL}">
                                                            <img src="${pageContext.request.contextPath}/${f.imgURL}" alt="${f.foodName}" class="img-thumbnail" style="width:80px; height:80px; object-fit:cover;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/images/no-image.png" alt="No image" class="img-thumbnail" style="width:80px; height:80px; object-fit:cover;">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <form method="get" action="${pageContext.request.contextPath}/manager/EditMenuServlet" class="mb-2">
                                                        <input type="hidden" name="foodId" value="${f.foodId}">
                                                        <button type="submit" class="btn btn-sm btn-warning w-100">Edit</button>
                                                    </form>
                                                    <form method="get" action="${pageContext.request.contextPath}/manager/ViewIngredientsOfFoodServlet">
                                                        <input type="hidden" name="foodId" value="${f.foodId}">
                                                        <button type="submit" class="btn btn-sm btn-secondary w-100">Công thức</button>
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
            </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
