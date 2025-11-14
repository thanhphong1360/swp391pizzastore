<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Table Management | Pizza House</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #fff8f3;
                margin: 0;
                padding: 40px 80px;
            }

            /* Header */
            h2 {
                color: #e63946;
                font-weight: 600;
                font-size: 28px;
            }

            .header-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
            }

            /* Buttons */
            .btn-custom {
                border-radius: 10px;
                font-weight: 500;
                padding: 9px 16px;
                text-decoration: none;
                color: white;
                border: none;
                transition: 0.3s ease;
            }

            .btn-dashboard {
                background-color: #718093;
            }

            .btn-dashboard:hover {
                background-color: #909fad;
            }

            .btn-add {
                background-color: #e63946;
                margin-top: 5px;
                margin-bottom: 25px; /* tạo khoảng cách rõ ràng với bảng */
            }

            .btn-add:hover {
                background-color: #c72e3b;
            }

            /* Table */
            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            thead th {
                background-color: #e63946;
                color: white;
                padding: 14px;
                text-align: center;
                font-weight: 500;
            }

            tbody td {
                padding: 12px;
                text-align: center;
                color: #333;
                border-bottom: 1px solid #f0f0f0;
            }

            tbody tr:last-child td {
                border-bottom: none;
            }

            tbody tr:hover {
                background-color: #fff1ee;
            }

            /* Status */
            .status-badge {
                font-weight: 600;
                padding: 5px 10px;
                border-radius: 12px;
                color: #fff;
            }

            .available {
                background: #44bd32;
            }
            .occupied {
                background: #e84118;
            }
            .other {
                background: #718093;
            }

            /* Action buttons */
            .action-btn {
                padding: 6px 12px;
                border-radius: 6px;
                font-size: 14px;
                margin: 0 3px;
                color: #fff;
                text-decoration: none;
                border: none;
                transition: 0.2s;
            }

            .btn-blue {
                background: #00a8ff;
            }
            .btn-blue:hover {
                background: #0097e6;
            }
            .btn-red {
                background: #e84118;
            }
            .btn-red:hover {
                background: #c23616;
            }

            /* Alerts */
            .alert {
                border-radius: 10px;
                font-weight: 500;
                margin-bottom: 20px;
            }

            @media (max-width: 768px) {
                body {
                    padding: 20px;
                }
                table {
                    font-size: 14px;
                }
                .btn-custom {
                    padding: 8px 14px;
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body>
        <c:if test="${not empty param.msg}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <c:choose>
                    <c:when test="${param.msg == 'added'}">Bàn mới đã được thêm thành công!</c:when>
                    <c:when test="${param.msg == 'edited'}">Thông tin bàn đã được cập nhật thành công!</c:when>
                    <c:when test="${param.msg == 'deleted'}">Bàn đã được xóa thành công!</c:when>
                    <c:otherwise>Thao tác thành công!</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <c:choose>
                    <c:when test="${param.error == 'add_failed'}">Thêm bàn thất bại. Vui lòng thử lại.</c:when>
                    <c:when test="${param.error == 'edit_failed'}">Cập nhật thông tin bàn thất bại.</c:when>
                    <c:when test="${param.error == 'delete_failed'}">Không thể xóa bàn (có thể đang được sử dụng trong đơn hàng).</c:when>
                    <c:when test="${param.error == 'invalid_id'}">ID bàn không hợp lệ.</c:when>
                    <c:when test="${param.error == 'invalid_number'}">Số bàn hoặc sức chứa không hợp lệ.</c:when>
                    <c:when test="${param.error == 'exception'}">Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.</c:when>
                    <c:otherwise>Đã xảy ra lỗi: ${param.error}</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <main class="container-fluid">

            <!-- 🔹 Header -->
            <div class="header-bar">
                <h2>Table Management</h2>
                <div>
                    <a href="${pageContext.request.contextPath}/Home" class="btn-custom btn-dashboard me-2">🏠 Back to Dashboard</a>
                    <a href="${pageContext.request.contextPath}/manager/table/add" class="btn-custom btn-add">➕ Add New Table</a>
                </div>
            </div>


            <!-- 🔹 Table List -->
            <c:if test="${not empty tables}">
                <div style="overflow-x:auto;">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Table Number</th>
                                <th>Capacity</th>
                                <th>Status</th>
                                <th>Location</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="t" items="${tables}">
                                <tr>
                                    <td>${t.tableId}</td>
                                    <td>${t.tableNumber}</td>
                                    <td>${t.capacity}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${t.status eq 'Available'}">
                                                <span class="status-badge available">Available</span>
                                            </c:when>
                                            <c:when test="${t.status eq 'Occupied'}">
                                                <span class="status-badge occupied">Occupied</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge other">${t.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${t.location}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/manager/table/edit" method="get" style="display:inline;">
                                            <input type="hidden" name="id" value="${t.tableId}">
                                            <button type="submit" class="action-btn btn-blue">✏ Edit</button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/manager/table/delete" method="post" style="display:inline;"
                                              onsubmit="return confirm('Are you sure you want to delete table `${t.tableNumber}`?');">
                                            <input type="hidden" name="table_id" value="${t.tableId}">
                                            <button type="submit" class="action-btn btn-red">🗑 Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
