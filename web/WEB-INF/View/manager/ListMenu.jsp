<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Menu Management | Pizza House</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <style>
            body {
                font-family:'Poppins',sans-serif;
                background:#fff8f3;
                margin:30px;
            }
            h2 {
                color:#e63946;
                font-weight:600;
                text-align:center;
                margin-bottom:30px;
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
            table {
                width:100%;
                border-collapse:collapse;
                margin-top:15px;
                background:#fff;
                border-radius:12px;
                box-shadow:0 4px 12px rgba(0,0,0,0.1);
            }
            th {
                background:#e63946;
                color:white;
                padding:12px;
                text-align:center;
            }
            td {
                padding:10px;
                border-bottom:1px solid #eee;
                text-align:center;
                vertical-align:middle;
            }
            tr:hover {
                background:#fff1ee;
            }
            img {
                border-radius:8px;
            }
            .action-btn {
                border-radius:6px;
                padding:5px 10px;
                font-size:13px;
                text-decoration:none;
                color:white;
                margin:2px;
            }
            .edit {
                background:#00a8ff;
            }
            .edit:hover {
                background:#0097e6;
            }
            .view {
                background:#44bd32;
            }
            .view:hover {
                background:#4cd137;
            }
            .ingredient-box {
                padding: 10px;
                background: #f8f9fa;
                border-radius: 8px;
                font-size: 14px;
                margin-top: 5px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                max-width: 300px; /* Giới hạn chiều rộng của box */
                margin-left: auto;
                margin-right: auto;
            }

            .ingredient-item {
                display: flex;
                justify-content: space-between;
                margin-bottom: 6px;
                padding: 5px;
                background-color: #f1f1f1;
                border-radius: 6px;
                font-weight: 500;
            }

            .ingredient-name {
                font-size: 14px;
                color: #333;
            }

            .ingredient-qty {
                font-size: 13px;
                color: #888;
            }

            .no-ingredients {
                color: #aaa;
                font-style: italic;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="container">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Quản lí thực đơn</h2>
                <div>
                    <a href="${pageContext.request.contextPath}/Home" class="btn btn-gray me-2">🏠 Quay lại Dashboard</a>
                    <a href="${pageContext.request.contextPath}/manager/AddMenuServlet" class="btn btn-red">➕ Thêm món</a>
                </div>
            </div>
            <c:if test="${not empty message}">
                <div id="alertBox" class="alert
                     <c:choose>
                         <c:when test="${messageType == 'success'}">alert-success</c:when>
                         <c:otherwise>alert-error</c:otherwise>
                     </c:choose>">
                    ${message}
                </div>
            </c:if>

            <div style="overflow-x:auto;">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Tên món</th>
                            <th>Danh mục</th>
                            <th>Mô tả món ăn</th>
                            <th>Kích thước</th>
                            <th>Giá</th>
                            <th>Trạng thái</th>
                            <th>Nguyên liệu của món</th>
                            <th>Hình ảnh</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="f" items="${menuList}">
                            <tr>
                                <td>${f.foodName}</td>
                                <td>${f.categoryName}</td>
                                <td>${f.description}</td>
                                <td>${f.size}</td>
                                <td><fmt:formatNumber value="${f.price}" type="number" maxFractionDigits="0"/> đ</td>
                                <td>
                                    <span class="badge ${f.status=='available'?'bg-success':(f.status == 'unavailable'
                                                         ? ' bg-danger'
                                                         : ' bg-secondary')}">
                                              ${f.status}
                                          </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${empty f.ingredients}">
                                                <span class="no-ingredients">Món này chưa có nguyên liệu</span>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="ingredient-box">
                                                    <c:forEach var="ing" items="${f.ingredients}">
                                                        <div class="ingredient-item">
                                                            <span class="ingredient-name">${ing.name}</span>
                                                            <span class="ingredient-qty">${ing.quantity} ${ing.unit}</span>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty f.imgURL}">
                                                <img src="${pageContext.request.contextPath}/${f.imgURL}" alt="${f.foodName}" width="80" height="80">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/images/no-image.png" alt="Hình ảnh" width="80" height="80">
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/manager/EditMenuServlet?foodId=${f.foodId}" class="action-btn edit">Chỉnh sửa</a>
                                        <a href="${pageContext.request.contextPath}/manager/ViewIngredientsOfFoodServlet?foodId=${f.foodId}" class="action-btn view">Công thức món</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="d-flex justify-content-center mt-4">
                    <ul class="pagination">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/manager/ListMenuServlet?page=${currentPage - 1}">Previous</a>
                            </li>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="pageNum">
                            <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/manager/ListMenuServlet?page=${pageNum}">${pageNum}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/manager/ListMenuServlet?page=${currentPage + 1}">Next</a>
                            </li>
                        </c:if>
                    </ul>
                </div>

            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // Kiểm tra nếu thông báo tồn tại
                var alertBox = document.getElementById('alertBox');
                if (alertBox) {
                    setTimeout(function () {
                        alertBox.style.display = 'none';
                    }, 3000); // Ẩn sau 3 giây
                }
            </script>
        </body>
    </html>
