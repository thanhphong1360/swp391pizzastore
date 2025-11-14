<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Discount Management | Pizza House</title>
        <base href="${pageContext.request.contextPath}/"> <!-- QUAN TRỌNG NHẤT -->
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
            .delete {
                background:#e84118;
            }
            .delete:hover {
                background:#c23616;
            }
        </style>
    </head>
    <body>
        <c:if test="${param.msg == 'deleted'}">
            <div class="alert alert-success"> Mã giảm giá đã được xóa thành công!</div>
        </c:if>
        <c:if test="${param.error == 'delete_failed'}">
            <div class="alert alert-danger"> Không thể xóa mã giảm giá (có thể đang được sử dụng trong hóa đơn).</div>
        </c:if>
        <c:if test="${param.error == 'exception'}">
            <div class="alert alert-danger">️ Đã xảy ra lỗi trong quá trình xóa.</div>
        </c:if>
        <c:if test="${param.error == 'invalid_id'}">
            <div class="alert alert-warning">️ ID không hợp lệ.</div>
        </c:if>
        <div class="d-flex justify-content-between mb-3">
            <h2>Discount Management</h2>
            <a href="Home" class="home-btn">Back to Dashboard</a>
        </div>

        <a href="manager/discount/add-discount" class="add-btn mb-3 d-inline-block">Add Discount</a>

        <div style="overflow-x:auto;">
            <table class="table table-striped">
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
                            <td>${d.code}</td>
                            <td>${d.description}</td>
                            <td>${d.type}</td>
                            <td>${d.value}</td>
                            <td>${d.startDate}</td>
                            <td>${d.endDate}</td>
                            <td><fmt:formatNumber value="${d.minInvoicePrice}" pattern="#,###"/> VND</td>
                            <td><fmt:formatNumber value="${d.maxDiscountAmount}" pattern="#,###"/> VND</td>
                            <td><span style="font-weight:bold; color:${d.status ? 'green' : 'red'};">${d.status ? 'Active' : 'Inactive'}</span></td>
                            <td>
                                <div class="btn-group" role="group">

                                    <!-- VIEW -->
                                    <form action="GetDiscountByIdServlet" method="GET" style="display: inline;">
                                        <input type="hidden" name="id" value="${d.discountId}">
                                        <input type="hidden" name="action" value="view">
                                        <button type="submit" class="btn btn-sm btn-dark" style="margin-right: 5px;">
                                            View
                                        </button>
                                    </form>

                                    <!-- EDIT -->
                                    <form action="GetDiscountByIdServlet" method="GET" style="display: inline;">
                                        <input type="hidden" name="id" value="${d.discountId}">
                                        <input type="hidden" name="action" value="edit">
                                        <button type="submit" class="btn btn-sm btn-warning" style="margin-right: 5px;">
                                            Edit
                                        </button>
                                    </form>

                                    <form action="DeleteDiscountServlet"
                                          method="POST"
                                          style="display: inline;"
                                          onsubmit="return confirm('Bạn chắc chắn muốn xóa mã giảm giá này?');">
                                        <input type="hidden" name="id" value="${d.discountId}">
                                        <button type="submit" class="btn btn-sm btn-danger">
                                            <i class="tio-delete"></i> Delete
                                        </button>
                                    </form>

                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
