<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Xác nhận thanh toán</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow p-4">

                        <h2 class="text-center mb-4">Xác nhận thanh toán</h2>

                        <!-- THÔNG TIN ĐƠN HÀNG -->
                        <p><strong>Mã đơn hàng:</strong> <span class="text-primary">${orderId}</span></p>
                        <p><strong>Khách hàng:</strong> <span class="text-primary">${customerName}</span></p>
                        <p><strong>Tổng tiền:</strong> 
                            <span class="text-danger fs-5">
                                <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="" /> VND
                            </span>
                        </p>

                        <hr>

                        <!-- MÃ GIẢM GIÁ -->
                        <form action="${pageContext.request.contextPath}/payment" method="post">
                            <input type="hidden" name="orderId" value="${orderId}">
                            <input type="hidden" name="customerName" value="${customerName}">
                            <input type="hidden" name="totalAmount" value="${totalAmount}">

                            <div class="mb-3">
                                <label class="form-label">Mã giảm giá</label>
                                <input type="text" name="discountCode" class="form-control" placeholder="Nhập mã (nếu có)">
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" name="method" value="Momo" class="btn btn-info btn-lg">
                                    Thanh toán MoMo
                                </button>
                                <button type="submit" name="method" value="VNPay" class="btn btn-danger btn-lg">
                                    Thanh toán VNPay
                                </button>
                            </div>
                        </form>

                        <!-- LỖI -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger mt-3">
                                ${error}
                            </div>
                        </c:if>

                    </div>
                </div>
            </div>
        </div>

    </body>
</html>