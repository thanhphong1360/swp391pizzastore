<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thanh toán VNPay | Pizza House</title>
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
            .qr-container {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 12px;
                border: 2px dashed #e63946;
                margin: 20px 0;
            }
            .qr-container img {
                max-width: 180px;
                border-radius: 8px;
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
                <h2>Thanh toán VNPay</h2>
                <a href="${pageContext.request.contextPath}/payment" class="btn-custom btn-dashboard">
                    Quay lại
                </a>
            </div>

            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="payment-card">
                        <div class="payment-icon text-danger">
                            <i class="bi bi-credit-card"></i>
                        </div>
                        <h4 class="stat-title">Quét mã QR để thanh toán</h4>

                        <!-- vnpay.jsp -->
                        <div class="qr-container">
                            <img src="${pageContext.request.contextPath}/assets/images/vnpay-qr.png" 
                                 alt="VNPay QR" class="img-fluid">
                        </div>
                                 
                        <p><strong>Mã đơn:</strong> <span class="stat-value">${orderId}</span></p>
                        <p><strong>Số tiền:</strong> 
                            <span class="stat-value">
                                <fmt:formatNumber value="${amount}" type="number" groupingUsed="true"/> VND
                            </span>
                        </p>

                        <div class="alert alert-light alert-custom">
                            <strong>Hoặc chuyển khoản:</strong><br>
                            STK: <strong>9876543210</strong> - VNPay Bank<br>
                            Tên: <strong>Pizza House</strong><br>
                            Nội dung: <code>DH-${orderId}</code>
                        </div>

                        <div class="alert alert-warning alert-custom" id="statusAlert">
                            <i class="bi bi-hourglass-split"></i>
                            <strong>Đang chờ thanh toán...</strong><br>
                            Hệ thống sẽ tự động cập nhật sau khi nhận tiền.
                        </div>

                        <!-- NÚT TEST -->
                        <div class="mt-3 text-center">
                            <small class="text-muted">Chế độ test:</small><br>
                            <button type="submit" form="resultForm" name="status" value="Success" class="btn btn-success btn-sm">
                                Xác nhận thành công
                            </button>
                            <button type="submit" form="resultForm" name="status" value="Failed" class="btn btn-danger btn-sm">
                                Giả lập thất bại
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- FORM ẨN – PHẢI CÓ ĐỦ 4 FIELD -->
        <form id="resultForm" action="${pageContext.request.contextPath}/payment-result" method="post">
            <input type="hidden" name="gateway" value="${gateway}">
            <input type="hidden" name="orderId" value="${orderId}">
            <input type="hidden" name="amount" value="${amount}">
            <input type="hidden" name="status" value="Success">
        </form>

        <script>
            setTimeout(() => {
                const statusInput = document.querySelector('input[name="status"]');
                statusInput.value = 'Failed';
                document.getElementById('resultForm').submit();
            }, 10000);
        </script>

    </body>
</html>