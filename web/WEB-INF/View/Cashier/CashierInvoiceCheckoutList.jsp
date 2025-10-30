<%-- 
    Document   : CashierInvoiceCheckoutList
    Created on : Oct 27, 2025, 10:23:25 PM
    Author     : cungp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Invoice Checkout List</title>
    </head>
    <body>
        <form action="${pageContext.request.contextPath}/Home" method="GET">
            <input type="submit" value="Về trang chủ">
        </form>
        <h2>Danh sách hóa đơn chờ thanh toán</h2>

        <table border="1" class="table">
            <thead>
                <tr>
                    <th>Mã hóa đơn</th>
                    <th>Bàn</th>
                    <th>Ngày tạo</th>
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
                        <form action="${pageContext.request.contextPath}/cashier/Invoice" method="POST">
                            <input type="hidden" name="invoiceId" value="${invoice.invoiceId}">
                            <input type="hidden" name="action" value="checkoutForm">
                            <button type="submit">Thanh toán</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>
