<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Hồ sơ cá nhân - Pizza House</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #fff8f3 0%, #ffeae6 100%);
                min-height: 100vh;
                margin: 0;
            }
            .container {
                padding: 40px 20px;
            }
            .profile-card {
                background: #ffffff;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 15px 40px rgba(230, 57, 70, 0.15);
                transition: all 0.4s ease;
                max-width: 800px;
                margin: 0 auto;
            }
            .profile-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 25px 50px rgba(230, 57, 70, 0.22);
            }
            .card-header {
                background: linear-gradient(135deg, #e63946, #c72e3b);
                color: white;
                padding: 40px 30px;
                text-align: center;
                position: relative;
                overflow: hidden;
            }
            .card-header::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: rgba(255,255,255,0.1);
                transform: rotate(30deg);
                pointer-events: none;
            }
            .avatar {
                width: 130px;
                height: 130px;
                background: white;
                color: #e63946;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 4.5rem;
                margin: 0 auto 20px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
                border: 6px solid rgba(255,255,255,0.3);
            }
            .card-header h3 {
                margin: 0;
                font-weight: 700;
                font-size: 2rem;
            }
            .card-header p {
                margin: 8px 0 0;
                opacity: 0.95;
                font-size: 1.1rem;
            }
            .card-body {
                padding: 40px 50px;
            }
            .form-label {
                font-weight: 600;
                color: #333;
                font-size: 1.05rem;
            }
            .form-control {
                border-radius: 12px;
                padding: 12px 16px;
                border: 2px solid #eee;
                transition: all 0.3s;
            }
            .form-control:focus {
                border-color: #e63946;
                box-shadow: 0 0 0 0.2rem rgba(230, 57, 70, 0.25);
            }
            .input-group-text {
                background: #e63946;
                color: white;
                border-radius: 12px 0 0 12px;
            }
            .btn-save {
                background: linear-gradient(135deg, #e63946, #d00000);
                color: white;
                border: none;
                padding: 14px 40px;
                border-radius: 50px;
                font-weight: 600;
                font-size: 1.1rem;
                transition: all 0.4s;
                box-shadow: 0 8px 20px rgba(230, 57, 70, 0.3);
            }
            .btn-save:hover {
                transform: translateY(-3px);
                box-shadow: 0 15px 30px rgba(230, 57, 70, 0.4);
                background: linear-gradient(135deg, #c72e3b, #b00000);
            }
            .btn-home {
                border-radius: 50px;
                padding: 12px 30px;
                font-weight: 600;
            }
            .status-badge {
                padding: 8px 20px;
                border-radius: 50px;
                font-weight: 600;
                font-size: 0.9rem;
            }
            .alert {
                border-radius: 15px;
                padding: 18px;
                margin-bottom: 25px;
                border: none;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }
            small.text-muted {
                font-size: 0.95rem;
            }
        </style>
    </head>
    <body>

        <div class="container">

            <!-- Thông báo -->
            <c:if test="${not empty sessionScope.msg}">
                <div class="alert alert-success alert-dismissible fade show">
                    <i class="fas fa-check-circle"></i> ${sessionScope.msg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("msg"); %>
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show">
                    <i class="fas fa-exclamation-triangle"></i> ${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("error"); %>
            </c:if>

            <div class="profile-card">
                <div class="card-header">
                    <div class="avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <h3>${user.name}</h3>
                    <p><i class="fas fa-envelope"></i> ${user.email}</p>
                    <small>Tham gia ngày <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm"/></small>
                </div>

                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/profile" method="post" class="needs-validation" novalidate>
                        <input type="hidden" name="action" value="update">

                        <div class="row g-4">
                            <div class="col-md-6">
                                <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                <input type="text" name="name" value="${user.name}" class="form-control form-control-lg" required>
                                <div class="invalid-feedback">Vui lòng nhập họ tên</div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                <input type="email" name="email" value="${user.email}" class="form-control form-control-lg" required>
                                <div class="invalid-feedback">Email không hợp lệ</div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Mã người dùng</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                    <input type="text" value="${user.userId}" class="form-control" disabled>
                                </div>
                            </div>

<!--                            <div class="col-md-6">
                                <label class="form-label">Trạng thái tài khoản</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-shield-alt"></i></span>
                                    <input type="text" 
                                           value="${user.status ? 'Hoạt động' : 'Bị khóa'}" 
                                           class="form-control status-badge ${user.status ? 'bg-success text-white' : 'bg-danger text-white'}" 
                                           disabled>
                                </div>-->
                            </div>
                        </div>

                        <div class="text-center mt-5">
                            <button type="submit" class="btn btn-save btn-lg px-5 me-3">
                                <i class="fas fa-save"></i> Cập nhật hồ sơ
                            </button>
                            <a href="${pageContext.request.contextPath}/Home" class="btn btn-outline-secondary btn-home">
                                <i class="fas fa-home"></i> Về trang chủ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Bootstrap validation
            (() => {
                'use strict'
                const forms = document.querySelectorAll('.needs-validation')
                Array.from(forms).forEach(form => {
                    form.addEventListener('submit', event => {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        form.classList.add('was-validated')
                    }, false)
                })
            })()
        </script>
    </body>
</html>