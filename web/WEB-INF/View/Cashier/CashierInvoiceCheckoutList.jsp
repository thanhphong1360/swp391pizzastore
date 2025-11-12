<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Invoice Checkout List | Pizza House</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #fff8f3;
            margin: 30px;
            color: #333;
        }

        h2 {
            color: #e63946;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        th, td {
            padding: 10px 14px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #e63946;
            color: #fff;
            font-weight: 500;
        }

        tr:nth-child(even) {
            background-color: #fff1ee;
        }

        tr:hover {
            background-color: #ffeae7;
        }

        select {
            padding: 6px 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
        }

        .btn, input[type="submit"], button {
            background-color: #e63946;
            color: white;
            border: none;
            padding: 7px 14px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s ease-in-out;
        }

        .btn:hover, button:hover, input[type="submit"]:hover {
            background-color: #c72e3b;
        }

        .home-btn {
            background-color: #718093;
        }

        .home-btn:hover {
            background-color: #9c9c9c;
        }

        td span {
            color: #888;
        }
    </style>
</head>
<body>
    <div class="topbar">
        <!-- Nút về trang chủ -->
        <form action="${pageContext.request.contextPath}/Home" method="GET">
            <input type="submit" value="🏠 Về trang chủ" class="btn home-btn">
        </form>

        <!-- Bộ lọc trạng thái -->
        <form action="${pageContext.request.contextPath}/cashier/Invoice" method="GET">
            <label for="status" style="margin-right: 5px;">Trạng thái hóa đơn:</label>
            <input type="hidden" name="action" value="checkoutList">
            <select name="status" id="status" onchange="this.form.submit()">
                <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>🕓 Chờ thanh toán</option>
                <option value="paid" ${param.status == 'paid' ? 'selected' : ''}>✅ Đã thanh toán</option>
                <option value="cancelled" ${param.status == 'cancelled' ? 'selected' : ''}>❌ Đã hủy</option>
            </select>
        </form>
    </div>

    <h2>
        <c:choose>
            <c:when test="${param.status == 'paid'}">💰 Danh sách hóa đơn đã thanh toán</c:when>
            <c:when test="${param.status == 'cancelled'}">🚫 Danh sách hóa đơn đã hủy</c:when>
            <c:otherwise>🕓 Danh sách hóa đơn chờ thanh toán</c:otherwise>
        </c:choose>
    </h2>

    <table>
        <thead>
            <tr>
                <th>Mã hóa đơn</th>
                <th>Bàn</th>
                <th>Ngày tạo</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="invoice" items="${invoiceList}">
                <tr>
                    <td>${invoice.invoiceCode}</td>
                    <td>${invoice.tableNumbers}</td>
                    <td>${invoice.createdAt}</td>
                    <td>
                        <c:choose>
                            <c:when test="${invoice.status == 'pending'}">
                                <span style="color:#e67e22; font-weight:600;">Chờ thanh toán</span>
                            </c:when>
                            <c:when test="${invoice.status == 'paid'}">
                                <span style="color:#28a745; font-weight:600;">Đã thanh toán</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color:#c72e3b; font-weight:600;">Đã hủy</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${invoice.status == 'pending'}">
                                <form action="${pageContext.request.contextPath}/cashier/Invoice" method="POST" style="margin:0;">
                                    <input type="hidden" name="invoiceId" value="${invoice.invoiceId}">
                                    <input type="hidden" name="action" value="checkoutForm">
                                    <button type="submit" class="btn">💳 Thanh toán</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <span>-</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty invoiceList}">
                <tr><td colspan="5"><i>Không có hóa đơn nào trong trạng thái này.</i></td></tr>
            </c:if>
        </tbody>
    </table>
</body>
</html>
