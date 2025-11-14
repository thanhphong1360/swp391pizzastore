<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Xác nhận thanh toán | Pizza House</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');
            body {
                background-color: #fff8f3;
                font-family: 'Poppins', sans-serif;
                color: #333;
            }
            .header-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 35px;
            }
            .header-bar h2 {
                color: #e63946;
                font-weight: 600;
                font-size: 28px;
            }
            .btn-custom {
                border-radius: 10px;
                font-weight: 500;
                padding: 10px 18px;
                text-decoration: none;
                color: white;
                transition: 0.3s;
                border: none;
            }
            .btn-dashboard {
                background: #718093;
            }
            .btn-dashboard:hover {
                background: #909fad;
            }
            .payment-card {
                background: #fff;
                border-radius: 15px;
                padding: 30px;
                box-shadow: 0 6px 16px rgba(0,0,0,0.08);
                transition: 0.25s ease;
            }
            .payment-card:hover {
                transform: translateY(-6px);
                box-shadow: 0 12px 24px rgba(0,0,0,0.12);
            }
            .payment-icon {
                font-size: 3.5rem;
                margin-bottom: 15px;
            }
            .stat-title {
                color: #555;
                font-weight: 500;
                font-size: 1.1rem;
            }
            .stat-value {
                font-size: 1.6rem;
                font-weight: 700;
                color: #e63946;
            }
            .btn-momo {
                background: linear-gradient(135deg, #a100ff, #e63946);
                color: white;
                font-weight: 600;
                border-radius: 12px;
                padding: 12px 30px;
                font-size: 1.1rem;
            }
            .btn-vnpay {
                background: linear-gradient(135deg, #ff6b35, #e63946);
                color: white;
                font-weight: 600;
                border-radius: 12px;
                padding: 12px 30px;
                font-size: 1.1rem;
            }
            .btn-momo:hover, .btn-vnpay:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 16px rgba(230, 57, 70, 0.3);
            }
            .alert-custom {
                border-radius: 12px;
                border: none;
                font-weight: 500;
            }
        </style>
    </head>
    <body>

        <div class="container mt-5">
            <div class="header-bar">
                <h2>Xác nhận thanh toán</h2>
                <a href="${pageContext.request.contextPath}/Home" class="btn-custom btn-dashboard">
                    Về Dashboard
                </a>
            </div>

            <div class="row justify-content-center">
                <div class="col-md-7">
                    <div class="payment-card">
                        <div class="payment-icon text-primary">
                            <i class="bi bi-cart-check"></i>
                        </div>

                        <!-- THÔNG TIN ĐƠN HÀNG -->
                        <div class="mb-4">
                            <h4 class="stat-title mb-3">Thông tin đơn hàng</h4>

                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="fw-semibold text-secondary">Mã đơn hàng:</span>
                                <span class="stat-value">${orderId}</span>
                            </div>

                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="fw-semibold text-secondary">Khách hàng:</span>
                                <span class="text-primary fw-bold">${customerName}</span>
                            </div>

                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="fw-semibold text-secondary">Tổng tiền:</span>
                                <span class="text-dark">
                                    <fmt:formatNumber value="${totalAmount}" type="number" groupingUsed="true"/> VND
                                </span>
                            </div>

                            <!-- GIẢM GIÁ -->
                            <c:if test="${not empty discountAmount && discountAmount > 0}">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="fw-semibold text-success">Giảm giá:</span>
                                    <span class="text-success fw-bold">
                                        -<fmt:formatNumber value="${discountAmount}" type="number" groupingUsed="true"/> VND
                                    </span>
                                </div>
                            </c:if>

                            <!-- THÀNH TIỀN -->
                            <div class="d-flex justify-content-between align-items-center border-top pt-3 mt-3">
                                <span class="fw-bold fs-5 text-dark">Thành tiền:</span>
                                <span class="stat-value text-success">
                                    <fmt:formatNumber value="${finalAmount}" type="number" groupingUsed="true"/> VND
                                </span>
                            </div>
                        </div>

                        <hr class="my-4">

                        <!-- FORM THANH TOÁN -->
                        <form action="${pageContext.request.contextPath}/payment" method="post">
                            <input type="hidden" name="orderId" value="${orderId}">
                            <input type="hidden" name="customerName" value="${customerName}">
                            <input type="hidden" name="totalAmount" value="${totalAmount}">

                            <div class="mb-4">
                                <label class="form-label fw-semibold">Mã giảm giá</label>
                                <input type="text" name="discountCode" class="form-control" placeholder="Nhập mã (nếu có)" value="${discountCode}">
                            </div>

                            <div class="d-grid gap-3">
                                <button type="submit" name="method" value="Momo" class="btn btn-momo">
                                    <i class="bi bi-wallet2"></i> Thanh toán MoMo
                                </button>
                                <button type="submit" name="method" value="VNPay" class="btn btn-vnpay">
                                    <i class="bi bi-credit-card"></i> Thanh toán VNPay
                                </button>
                            </div>
                        </form>

                        <!-- LỖI -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-custom mt-4">
                                <i class="bi bi-exclamation-triangle"></i> ${error}
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>