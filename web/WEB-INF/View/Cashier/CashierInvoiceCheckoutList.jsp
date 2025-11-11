<%-- 
    Document   : CashierInvoiceCheckoutList
    Created on : Oct 27, 2025, 10:23:25 PM
    Author     : cungp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Invoice Checkout List</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f7fa;
                margin: 20px;
            }
            h2 {
                color: #004aad;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                background: white;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }
            th, td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: center;
            }
            th {
                background-color: #e9f0ff;
            }
            tr:hover {
                background-color: #f1f6ff;
            }
            select {
                padding: 5px 10px;
                border-radius: 5px;
            }
            button {
                background-color: #007bff;
                border: none;
                color: white;
                padding: 5px 10px;
                border-radius: 5px;
                cursor: pointer;
            }
            button:hover {
                background-color: #0056b3;
            }
            .topbar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <div class="topbar">
            <form action="${pageContext.request.contextPath}/Home" method="GET">
                <input type="submit" value="Về trang chủ">
            </form>

            <!-- Bộ lọc trạng thái -->
            <form action="${pageContext.request.contextPath}/cashier/Invoice" method="GET">
                <label for="status">Trạng thái hóa đơn:</label>
                <input type="hidden" name="action" value="checkoutList">
                <select name="status" id="status" onchange="this.form.submit()">
                    <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>Chờ thanh toán</option>
                    <option value="paid" ${param.status == 'paid' ? 'selected' : ''}>Đã thanh toán</option>
                    <option value="cancelled" ${param.status == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                </select>
            </form>
        </div>

        <h2>
            <c:choose>
                <c:when test="${param.status == 'paid'}">Danh sách hóa đơn đã thanh toán</c:when>
                <c:when test="${param.status == 'cancelled'}">Danh sách hóa đơn đã hủy</c:when>
                <c:otherwise>Danh sách hóa đơn chờ thanh toán</c:otherwise>
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
                        <td>${invoice.status}</td>
                        <td>
                            <c:choose>
                                <c:when test="${invoice.status == 'pending'}">
                                    <form action="${pageContext.request.contextPath}/cashier/Invoice" method="POST" style="margin:0;">
                                        <input type="hidden" name="invoiceId" value="${invoice.invoiceId}">
                                        <input type="hidden" name="action" value="checkoutForm">
                                        <button type="submit">Thanh toán</button>
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
                    <tr><td colspan="5">Không có hóa đơn nào trong trạng thái này.</td></tr>
                </c:if>
            </tbody>
        </table>
    </body>
</html>
