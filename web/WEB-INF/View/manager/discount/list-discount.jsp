<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Discount Management | Pizza House</title>
        <base href="${pageContext.request.contextPath}/">
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
            }
            .home-btn, .add-btn {
                border-radius:8px;
                font-weight:500;
                padding:8px 14px;
                text-decoration:none;
                color:white;
                transition:0.3s;
            }
            .home-btn {
                background:#718093;
            }
            .home-btn:hover {
                background:#9c9c9c;
            }
            .add-btn {
                background:#e63946;
            }
            .add-btn:hover {
                background:#c72e3b;
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
            }
            td {
                padding:10px;
                border-bottom:1px solid #eee;
                text-align:center;
            }
            tr:hover {
                background:#fff1ee;
            }
            .action {
                padding:5px 10px;
                border-radius:6px;
                color:white;
                text-decoration:none;
                font-size:13px;
                margin-right:5px;
            }
            .edit {
                background:#00a8ff;
            }
            .edit:hover {
                background:#0097e6;
            }
            .view {
                background:#6c5ce7;
            }
            .view:hover {
                background:#5a4dcf;
            }

            /* === THÊM MỚI - GIỮ NGUYÊN PHONG CÁCH === */
            .header-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                flex-wrap: wrap;
                gap: 15px;
            }
            .search-box {
                display: flex;
                max-width: 360px;
            }
            .search-box input {
                border: 2px solid #ddd;
                border-right: none;
                border-radius: 8px 0 0 8px;
                padding: 8px 12px;
                font-size: 14px;
            }
            .search-box input:focus {
                outline: none;
                border-color: #e63946;
            }
            .search-box button {
                background: #e63946;
                color: white;
                border: none;
                border-radius: 0 8px 8px 0;
                padding: 0 16px;
            }
            .search-box button:hover {
                background: #c72e3b;
            }

            /* Pagination - nhẹ nhàng, đúng tông màu */
            .pagination-info {
                color: #555;
                font-size: 14px;
                margin-top: 20px;
            }
            .pagination {
                margin-top: 20px;
                justify-content: center;
            }
            .pagination .page-link {
                color: #e63946;
                border-radius: 6px;
                margin: 0 4px;
                padding: 8px 14px;
            }
            .pagination .page-item.active .page-link {
                background: #e63946;
                border-color: #e63946;
                color: white;
            }
            .pagination .page-item.disabled .page-link {
                color: #aaa;
            }
        </style>
    </head>
    <body>
        <c:if test="${not empty param.msg or not empty param.error}">

            <!-- Thông báo thành công -->
            <c:if test="${not empty param.msg}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    <c:choose>
                        <c:when test="${param.msg == 'add_success'}">Mã giảm giá đã được thêm thành công!</c:when>
                        <c:when test="${param.msg == 'edit_success'}">Mã giảm giá đã được cập nhật thành công!</c:when>
                        <c:otherwise>Thao tác thành công!</c:otherwise>
                    </c:choose>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Thông báo lỗi -->
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <c:choose>
                        <c:when test="${param.error == 'add_failed'}">Không thể thêm mã giảm giá. Vui lòng thử lại.</c:when>
                        <c:when test="${param.error == 'edit_failed'}">Không thể cập nhật mã giảm giá.</c:when>
                        <c:when test="${param.error == 'code_exists'}">Mã giảm giá đã tồn tại. Vui lòng chọn mã khác.</c:when>
                        <c:when test="${param.error == 'invalid_id'}">ID không hợp lệ.</c:when>
                        <c:when test="${param.error == 'exception'}">Đã xảy ra lỗi trong quá trình xử lý.</c:when>
                        <c:otherwise>Đã xảy ra lỗi.</c:otherwise>
                    </c:choose>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

        </c:if>

        <!-- HEADER BAR: Back + Add + Search (bên phải) -->
        <div class="header-bar">
            <h2>Discount Management</h2>
            <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                <!-- Search Box - nằm bên phải -->
                <form method="get" action="${pageContext.request.contextPath}/manager/discount/list" class="d-flex gap-2">
                    <input type="text" name="search" class="form-control search-box " 
                           placeholder="Search by Code or Description..." 
                           value="${param.search}">
                    <button type="submit" class="btn btn-primary">Search</button>
                    <c:if test="${not empty param.search}">
                        <a href="${pageContext.request.contextPath}/manager/discount/list" class="btn btn-secondary">Clear</a>
                    </c:if>
                </form>

                <a href="${pageContext.request.contextPath}/Home" class="home-btn">🏠 Back to Dashboard</a>
                <a href="manager/discount/add-discount" class="add-btn">➕ Add New Discount</a>
            </div>
        </div>

        <!-- Bảng dữ liệu -->
        <div style="overflow-x:auto;">
            <table>
                <thead>
                    <tr>
                        <th>ID</th><th>Code</th><th>Description</th><th>Type</th><th>Value</th>
                        <th>Start Date</th><th>End Date</th><th>Min Invoice</th><th>Max Discount</th>
                        <th>Status</th><th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="d" items="${discounts}">
                        <tr>
                            <td>${d.discountId}</td>
                            <td><strong>${d.code}</strong></td>
                            <td>${d.description}</td>
                            <td>
                                <span style="padding:4px 10px; border-radius:6px; font-size:12px; color:white;
                                      background:${d.type == 'percentage' ? '#00a8ff' : '#2ecc71'}">
                                    ${d.type == 'percentage' ? 'Percentage' : 'Fixed'}
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${d.type == 'percentage'}">${d.value}%</c:when>
                                    <c:otherwise><fmt:formatNumber value="${d.value}" pattern="#,###"/> VND</c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${d.startDate}" pattern="dd/MM/yyyy"/></td>
                            <td><fmt:formatDate value="${d.endDate}" pattern="dd/MM/yyyy"/></td>
                            <td><fmt:formatNumber value="${d.minInvoicePrice}" pattern="#,###"/> VND</td>
                            <td><fmt:formatNumber value="${d.maxDiscountAmount}" pattern="#,###"/> VND</td>
                            <td>
                                <span style="color:${d.status ? 'green' : 'red'}; font-weight:bold;">
                                    ${d.status ? 'Active' : 'Inactive'}
                                </span>
                            </td>
                            <td>
                                <a href="GetDiscountByIdServlet?id=${d.discountId}&action=view" 
                                   class="action view">View</a>
                                <a href="GetDiscountByIdServlet?id=${d.discountId}&action=edit" 
                                   class="action edit">Edit</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Không có dữ liệu -->
            <c:if test="${empty discounts}">
                <div style="text-align:center; padding:40px; color:#999; font-size:18px;">
                    No discount codes found.
                </div>
            </c:if>
        </div>

        <!-- PHÂN TRANG INFO -->
        <div class="pagination-info">
            Showing <strong>${(currentPage - 1) * pageSize + 1}</strong> - 
            <strong>${currentPage * pageSize > totalItems ? totalItems : currentPage * pageSize}</strong>
            of <strong>${totalItems}</strong> results
        </div>

        <<!-- PAGINATION -->
        <nav>
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/manager/discount/list?page=1&search=${param.search}">First</a>
                </li>
                <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/manager/discount/list?page=${currentPage - 1}&search=${param.search}">Previous</a>
                </li>

                <c:forEach var="i" begin="${currentPage - 2 > 0 ? currentPage - 2 : 1}" 
                           end="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/manager/discount/list?page=${i}&search=${param.search}">${i}</a>
                    </li>
                </c:forEach>

                <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/manager/discount/list?page=${currentPage + 1}&search=${param.search}">Next</a>
                </li>
                <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/manager/discount/list?page=${totalPages}&search=${param.search}">Last</a>
                </li>
            </ul>
        </nav>

    </body>
</html>