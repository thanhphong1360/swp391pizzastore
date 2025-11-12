<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout Invoice | Pizza House</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #fff8f3;
            margin: 0;
            padding: 30px;
            color: #333;
        }

        h3, h4, h5 {
            margin: 10px 0;
        }

        h3 {
            color: #e63946;
            font-weight: 600;
        }

        .container {
            background: #fff;
            border-radius: 14px;
            padding: 25px 35px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.1);
            max-width: 900px;
            margin: 0 auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            margin-bottom: 20px;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 10px 12px;
            text-align: left;
        }

        th {
            background-color: #e63946;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #fff1ee;
        }

        .total {
            font-weight: 600;
            text-align: right;
            color: #e63946;
            font-size: 1.05em;
        }

        .btn, input[type="submit"] {
            background-color: #e63946;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s ease-in-out;
            font-size: 14px;
            font-weight: 500;
        }

        .btn:hover, input[type="submit"]:hover {
            background-color: #c72e3b;
        }

        .back-form {
            margin-bottom: 25px;
        }

        .back-form input {
            background-color: #718093;
        }

        .back-form input:hover {
            background-color: #9c9c9c;
        }

        .order-block {
            border: 1px solid #eee;
            border-radius: 10px;
            padding: 15px 20px;
            margin-bottom: 20px;
            background-color: #fffaf8;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }

        .checkout-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 25px;
        }

        .checkout-actions h4 {
            font-weight: 600;
        }

        .error {
            color: #e63946;
            font-weight: 600;
            margin-bottom: 10px;
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

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

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
