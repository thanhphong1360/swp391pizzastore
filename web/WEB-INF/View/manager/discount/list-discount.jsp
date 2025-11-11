<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Discount Management | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: #fff8f3;
        margin: 30px;
    }
    h2 {
        color: #e63946;
        font-weight: 600;
        margin-bottom: 20px;
    }
    /* --- Buttons --- */
    .btn-main {
        border-radius: 8px;
        padding: 8px 14px;
        font-weight: 500;
        color: white;
        transition: 0.3s;
        text-decoration: none;
    }
    .btn-red { background: #e63946; }
    .btn-red:hover { background: #c72e3b; }
    .btn-gray { background: #718093; }
    .btn-gray:hover { background: #9c9c9c; }

    /* --- Table --- */
    table {
        width: 100%;
        border-collapse: collapse;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        overflow: hidden;
    }
    th {
        background: #e63946;
        color: white;
        text-align: center;
        padding: 12px;
    }
    td {
        padding: 10px;
        text-align: center;
        border-bottom: 1px solid #eee;
        vertical-align: middle;
    }
    tr:hover {
        background: #fff1ee;
    }

    /* --- Action Buttons --- */
    .action-btn {
        border: none;
        border-radius: 6px;
        color: white;
        font-size: 13px;
        padding: 6px 10px;
        margin-right: 5px;
        transition: 0.3s;
    }
    .btn-view { background: #6c5ce7; }
    .btn-view:hover { background: #5a4dcf; }
    .btn-edit { background: #00a8ff; }
    .btn-edit:hover { background: #0097e6; }
    .btn-delete { background: #e84118; }
    .btn-delete:hover { background: #c23616; }

    /* --- Status --- */
    .status {
        font-weight: bold;
        padding: 5px 10px;
        border-radius: 12px;
    }
    .status.active { color: #2ecc71; }
    .status.inactive { color: #e84118; }
</style>
</head>
<body>

<div class="container">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Discount Management</h2>
        <div>
            <a href="${pageContext.request.contextPath}/Home" class="btn-main btn-gray me-2">🏠 Back to Dashboard</a>
            <a href="${pageContext.request.contextPath}/manager/discount/add-discount" class="btn-main btn-red">➕ Add Discount</a>
        </div>
    </div>

    <!-- Table -->
    <div style="overflow-x:auto;">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Code</th>
                    <th>Description</th>
                    <th>Type</th>
                    <th>Value</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Min Invoice</th>
                    <th>Max Discount</th>
                    <th>Status</th>
                    <th>Actions</th>
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
                        <td><fmt:formatDate value="${d.startDate}" pattern="yyyy-MM-dd" /></td>
                        <td><fmt:formatDate value="${d.endDate}" pattern="yyyy-MM-dd" /></td>
                        <td><fmt:formatNumber value="${d.minInvoicePrice}" pattern="#,###"/> VND</td>
                        <td><fmt:formatNumber value="${d.maxDiscountAmount}" pattern="#,###"/> VND</td>
                        <td>
                            <span class="status ${d.status ? 'active' : 'inactive'}">
                                ${d.status ? 'Active' : 'Inactive'}
                            </span>
                        </td>
                        <td>
                            <div class="d-flex justify-content-center">
                                <form action="${pageContext.request.contextPath}/GetDiscountByIdServlet" method="get" style="display:inline;">
                                    <input type="hidden" name="id" value="${d.discountId}">
                                    <input type="hidden" name="action" value="view">
                                    <button type="submit" class="action-btn btn-view">View</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/GetDiscountByIdServlet" method="get" style="display:inline;">
                                    <input type="hidden" name="id" value="${d.discountId}">
                                    <input type="hidden" name="action" value="edit">
                                    <button type="submit" class="action-btn btn-edit">Edit</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/DeleteDiscountServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this discount?');">
                                    <input type="hidden" name="id" value="${d.discountId}">
                                    <button type="submit" class="action-btn btn-delete">Delete</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty discounts}">
                    <tr><td colspan="11">No discounts available.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>
