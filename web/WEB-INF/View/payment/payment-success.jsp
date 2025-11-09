```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thanh toán thành công</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    </head>
    <body class="bg-light">

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow-sm text-center p-4">
                        <i class="bi bi-check-circle-fill text-success" style="font-size: 4rem;"></i>
                        <h2 class="text-success mt-3 mb-3">Thanh toán thành công!</h2>
                        <p class="text-muted">Cảm ơn bạn đã hoàn tất giao dịch.</p>
                        <hr>

                        <c:if test="${not empty orderId}">
                            <p class="mb-2"><strong>Mã đơn hàng:</strong> <span class="text-primary">${orderId}</span></p>
                            </c:if>
                            <c:if test="${not empty amount}">
                            <p class="mb-2"><strong>Số tiền:</strong> <span class="text-primary">${amount} VND</span></p>
                        </c:if>
                        <c:if test="${not empty gateway}">
                            <p class="mb-3"><strong>Phương thức:</strong> 
                                <c:choose>
                                    <c:when test="${gateway eq 'VNPay'}"><span class="badge bg-danger">VNPay</span></c:when>
                                    <c:when test="${gateway eq 'Momo'}"><span class="badge bg-info text-dark">MoMo</span></c:when>
                                    <c:otherwise><span class="badge bg-secondary">${gateway}</span></c:otherwise>
                                </c:choose>
                            </p>
                        </c:if>

                        <div class="d-flex justify-content-center gap-2 mt-4">
                            <a href="${pageContext.request.contextPath}/payment" class="btn btn-outline-primary">
                                <i class="bi bi-arrow-left"></i> Quay lại thanh toán
                            </a>
                    <!--        <a href="${pageContext.request.contextPath}/home" class="btn btn-success">
                                <i class="bi bi-house"></i> Về trang chủ
                            </a> -->
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
```