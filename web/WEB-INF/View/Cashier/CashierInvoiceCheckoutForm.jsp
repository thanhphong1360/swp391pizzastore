<%-- 
    Document   : CashierInvoiceCheckoutForm
    Created on : Oct 28, 2025, 12:45:50 PM
    Author     : cungp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Thanh toán hóa đơn</title>
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
            color: #333;
        }

        h3, h4, h5 {
            margin: 8px 0;
        }

        h3 {
            color: #007bff;
        }

        .container {
            background: white;
            border-radius: 10px;
            padding: 20px 30px;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
            max-width: 900px;
            margin: 0 auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            margin-bottom: 15px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px 10px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .total {
            font-weight: bold;
            text-align: right;
            color: #007bff;
            font-size: 1.1em;
        }

        .btn, input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out;
            font-size: 14px;
        }

        .btn:hover, input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .back-form {
            margin-bottom: 20px;
        }

        .order-block {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            background-color: #fafafa;
        }

        .checkout-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>
<body>
    <div class="container">

        <!-- Nút quay lại -->
        <form class="back-form" action="${pageContext.request.contextPath}/cashier/Invoice" method="GET">
            <input type="hidden" name="action" value="checkoutList">
            <input type="submit" class="btn" value="← Quay lại danh sách">
        </form>
            <h3>${error}</h3>
        <h3>Thanh toán hóa đơn: ${invoice.invoiceCode}</h3>

        <h4>Danh sách Order</h4>

        <c:forEach items="${orderList}" var="order">
            <div class="order-block">
                <h5>Order #${order.orderId}</h5>
                <p><b>Bàn:</b> ${order.table.tableNumber}</p>
                <p><b>Trạng thái:</b> ${order.status}</p>

                <table>
                    <tr>
                        <th>Món</th>
                        <th>Số lượng</th>
                        <th>Thành tiền (VND)</th>
                    </tr>
                    <c:forEach items="${order.orderFoodList}" var="orderFood">
                        <tr>
                            <td>${orderFood.food.name}</td>
                            <td>${orderFood.quantity}</td>
                            <td>${orderFood.price}</td>
                        </tr>
                    </c:forEach>
                </table>

                <p class="total">Tổng order: ${order.price} đ</p>
            </div>
        </c:forEach>

        <div class="checkout-actions">
            <h4>Tổng hóa đơn: <span class="total">${invoice.price} đ</span></h4>
            <form id="checkoutForm" action="${pageContext.request.contextPath}/cashier/Invoice" method="POST" onsubmit="return confirmCheckout('${invoice.invoiceCode}')">
                <input type="hidden" name="action" value="checkout">
                <input type="hidden" name="invoiceId" value="${invoice.invoiceId}">
                <input type="submit" value="✅ Thanh toán" class="btn">
            </form>
        </div>

    </div>

    <script>
        function confirmCheckout(invoiceCode) {
            return confirm("Xác nhận thanh toán hóa đơn #" + invoiceCode + " ?");
        }
    </script>
</body>
</html>
