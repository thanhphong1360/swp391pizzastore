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
                <form id="checkoutForm" 
                      action="${pageContext.request.contextPath}/cashier/Invoice" 
                      method="POST" 
                      onsubmit="return confirmCheckout('${invoice.invoiceCode}')">

                    <input type="hidden" name="action" value="checkout">
                    <input type="hidden" name="invoiceId" value="${invoice.invoiceId}">

                    <!-- Tổng gốc -->
                    <h4>
                        Tổng hóa đơn gốc: 
                        <span class="total" id="originalTotal">${invoice.price} đ</span>
                    </h4>

                    <!-- Tổng sau giảm (preview bằng JS) -->
                    <h4>
                        Sau giảm giá: 
                        <span class="total" id="finalTotal">${invoice.price} đ</span>
                    </h4>

                    <!-- Ẩn tổng tiền gốc dạng số để JS dùng -->
                    <input type="hidden" id="basePrice" value="${invoice.price}"/>

                    <!-- MÃ GIẢM GIÁ - NẰM TRONG FORM -->
                    <label for="discountId"><b>Mã giảm giá:</b></label>
                    <select name="discountId" id="discountId">
                        <option value="">-- Không áp dụng mã --</option>
                        <c:forEach var="d" items="${discountList}">
                            <option 
                                value="${d.discountId}"
                                data-type="${d.type}"
                                data-value="${d.value}"
                                data-max="${d.maxDiscountAmount}"
                                data-min="${d.minInvoicePrice}"
                                >
                                ${d.code}
                                -
                                <c:out value="${d.description}" />
                                (<c:choose>
                                    <c:when test="${d.type == 'percentage'}">
                                        -${d.value}% 
                                        <c:if test="${d.maxDiscountAmount > 0}">
                                            , tối đa ${d.maxDiscountAmount}đ
                                        </c:if>
                                    </c:when>
                                    <c:otherwise>
                                        -${d.value}đ
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${d.minInvoicePrice > 0}">
                                    , đơn ≥ ${d.minInvoicePrice}đ
                                </c:if>
                                )
                            </option>
                        </c:forEach>
                    </select>

                    <c:if test="${not empty discountError}">
                        <p style="color:red; margin-top: 5px;">${discountError}</p>
                    </c:if>

                    <br><br>
                    <input type="submit" value="✅ Thanh toán" class="btn">
                </form>
            </div>

    </div>

    <script>
        function confirmCheckout(invoiceCode) {
            return confirm("Xác nhận thanh toán hóa đơn #" + invoiceCode + " ?");
        }
    </script>
    <script>
            function formatCurrency(value) {
                // đơn giản: làm tròn 0 số, thêm "đ"
                return Math.round(value).toLocaleString('vi-VN') + ' đ';
            }

            function updateDiscountPreview() {
                const basePriceInput = document.getElementById('basePrice');
                const originalTotalSpan = document.getElementById('originalTotal');
                const finalTotalSpan = document.getElementById('finalTotal');
                const select = document.getElementById('discountId');

                if (!basePriceInput || !select)
                    return;

                const basePrice = parseFloat(basePriceInput.value) || 0;
                let finalPrice = basePrice;

                const selectedOption = select.options[select.selectedIndex];

                if (selectedOption && selectedOption.value !== "") {
                    const type = selectedOption.getAttribute('data-type');   // percentage / fixed
                    const value = parseFloat(selectedOption.getAttribute('data-value')) || 0;
                    const max = parseFloat(selectedOption.getAttribute('data-max')) || 0;
                    const min = parseFloat(selectedOption.getAttribute('data-min')) || 0;

                    // Check đơn tối thiểu
                    if (basePrice >= min) {
                        let discountAmount = 0;

                        if (type && type.toLowerCase() === 'percentage') {
                            discountAmount = basePrice * value / 100.0;
                            if (max > 0 && discountAmount > max) {
                                discountAmount = max;
                            }
                        } else {
                            // fixed
                            discountAmount = value;
                        }

                        if (discountAmount > basePrice) {
                            discountAmount = basePrice;
                        }

                        finalPrice = basePrice - discountAmount;
                    } else {
                        // nếu không đủ điều kiện đơn tối thiểu thì không giảm
                        finalPrice = basePrice;
                    }
                }

                originalTotalSpan.textContent = formatCurrency(basePrice);
                finalTotalSpan.textContent = formatCurrency(finalPrice);
            }

            // Gắn event khi đổi mã
            document.addEventListener('DOMContentLoaded', function () {
                const select = document.getElementById('discountId');
                if (select) {
                    select.addEventListener('change', updateDiscountPreview);
                }
                // tính 1 lần khi load trang
                updateDiscountPreview();
            });
        </script>
</body>
</html>
