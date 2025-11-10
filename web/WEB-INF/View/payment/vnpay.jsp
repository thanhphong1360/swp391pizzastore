<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>Thanh toán VNPay</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow-sm p-4 text-center">
                        <h2 class="mb-4">Thanh toán qua VNPay</h2>
                        <p class="text-muted">Mã đơn hàng: ${orderId}</p>
                        <p class="text-muted">Số tiền: ${amount} VND</p>
                        <hr>

                        <!-- SỬA: Hiển thị mã QR hoặc số tài khoản -->
                        <div class="mb-4">
                            <h5>Quét mã QR để thanh toán</h5>
                            <img src="${pageContext.request.contextPath}/assets/images/vnpay-qr.png" alt="VNPay QR Code" class="img-fluid" style="max-width: 200px;">
                            <!-- Thay bằng QR thật của nhà hàng -->
                        </div>

                        <div class="mb-4">
                            <h5>Hoặc chuyển khoản qua số tài khoản</h5>
                            <p class="alert alert-info">
                                <strong>Số tài khoản: </strong> 9876543210 <br>
                                <strong>Ngân hàng: </strong> VNPay Bank <br>
                                <strong>Tên tài khoản: </strong> Pizza Restaurant
                            </p>
                        </div>

                        <!-- Form xác nhận thanh toán (giả lập thành công/thất bại) -->
                        <form action="${pageContext.request.contextPath}/payment-result" method="post">
                            <input type="hidden" name="gateway" value="VNPay">
                            <input type="hidden" name="orderId" value="${orderId}">
                            <input type="hidden" name="amount" value="${amount}">
                            <div class="d-flex justify-content-center gap-2">
                                <button type="submit" name="status" value="Success" class="btn btn-success">Xác nhận thành công</button>
                                <button type="submit" name="status" value="Failed" class="btn btn-danger">Giả lập thất bại</button>
                            </div>
                        </form>

                        <a href="${pageContext.request.contextPath}/payment" class="btn btn-secondary mt-3 w-100">Quay lại</a>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
