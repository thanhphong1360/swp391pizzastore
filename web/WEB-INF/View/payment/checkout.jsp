<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Checkout</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow-sm p-4">
                        <h2 class="text-center mb-4">Thanh toán</h2>
                        <p><strong>Mã đơn hàng:</strong> ${orderId}</p>
                        <p><strong>Khách hàng:</strong> ${customerName}</p>
                        <p><strong>Tổng tiền:</strong> ${totalAmount} VND</p>
                        <hr>

                        <!-- Thêm mã giảm giá -->
                        <div class="mb-3">
                            <label class="form-label">Mã giảm giá</label>
                            <input type="text" name="discountCode" class="form-control" placeholder="Nhập mã (nếu có)">
                        </div>

                        <!-- Nút chọn phương thức -->
                        <form action="${pageContext.request.contextPath}/payment" method="post">
                            <input type="hidden" name="orderId" value="${orderId}">
                            <input type="hidden" name="amount" value="${totalAmount}">
                            <button type="submit" name="method" value="VNPay" class="btn btn-primary w-100 mb-2">Thanh toán VNPay</button>
                            <button type="submit" name="method" value="Momo" class="btn btn-info w-100">Thanh toán MoMo</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
