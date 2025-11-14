<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thanh toán thất bại | Pizza House</title>
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
                text-align: center;
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
                font-size: 1.8rem;
                font-weight: 600;
                color: #e63946;
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
                <h2>Thanh toán thất bại</h2>
                <a href="${pageContext.request.contextPath}/home" class="btn-custom btn-dashboard">
                    Về Dashboard
                </a>
            </div>

            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="payment-card">
                        <div class="payment-icon text-danger">
                            <i class="bi bi-x-circle-fill"></i>
                        </div>
                        <h4 class="stat-title">Giao dịch không thành công</h4>

                        <p><strong>Mã đơn hàng:</strong> <span class="stat-value">${orderId}</span></p>
                        <p><strong>Số tiền:</strong> 
                            <span class="stat-value">
                                <fmt:formatNumber value="${amount}" type="number" groupingUsed="true"/> VND
                            </span>
                        </p>
                        <p><strong>Phương thức:</strong> 
                            <c:choose>
                                <c:when test="${gateway eq 'VNPay'}"><span class="badge bg-danger">VNPay</span></c:when>
                                <c:when test="${gateway eq 'Momo'}"><span class="badge bg-info text-dark">MoMo</span></c:when>
                                <c:otherwise><span class="badge bg-secondary">${gateway}</span></c:otherwise>
                            </c:choose>
                        </p>

                        <c:if test="${not empty error}">
                            <div class="alert alert-warning alert-custom mt-3">
                                <i class="bi bi-exclamation-triangle"></i> ${error}
                            </div>
                        </c:if>

                        <div class="d-flex justify-content-center gap-2 mt-4">
                            <a href="${pageContext.request.contextPath}/payment" class="btn btn-warning btn-custom">
                                <i class="bi bi-arrow-clockwise"></i> Thử lại
                            </a>
                            <a href="${pageContext.request.contextPath}/Home" class="btn btn-success btn-custom">
                                <i class="bi bi-house"></i> Về trang chủ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>