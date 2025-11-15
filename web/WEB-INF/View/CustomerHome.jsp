<%@page contentType="text/html; charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>

<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pizza House - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #fff8f3;
        }
        .navbar-brand span {
            color: #e63946;
            font-weight: 700;
        }
        .hero {
            background: url('https://images.unsplash.com/photo-1601924582971-b0d29f3b39d9') center/cover no-repeat;
            height: 80vh;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        .hero h1 {
            font-size: 3rem;
            font-weight: 700;
            text-shadow: 0 2px 6px rgba(0,0,0,0.4);
        }
        .menu-section {
            padding: 60px 0;
            overflow-x: auto; /* Cho phép cuộn ngang nếu các thẻ không vừa với màn hình */
        }

        .menu-row {
            display: flex;
            flex-wrap: nowrap; /* Không cho phép xuống hàng, cuộn ngang */
            gap: 15px; /* Khoảng cách giữa các món ăn */
            margin-bottom: 20px;
        }

        .menu-card {
            flex: 0 0 calc(50% - 15px); /* Mỗi thẻ chiếm 50% chiều rộng của container */
            height: 400px; /* Cố định chiều cao */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            background-color: white;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 15px; /* Khoảng cách giữa các thẻ */
        }

        .menu-card img {
            width: 100%;
            height: 200px; /* Cố định chiều cao hình ảnh */
            object-fit: cover; /* Đảm bảo ảnh không bị méo */
            border-radius: 8px;
        }

        .menu-card-title {
            font-size: 1.2rem;
            font-weight: bold;
            margin-top: 10px;
        }

        .menu-card-price {
            font-size: 1rem;
            font-weight: bold;
            color: #e63946;
            margin-top: 5px;
        }
        footer {
            background-color: #222;
            color: #ddd;
            padding: 40px 0;
        }
        footer a {
            color: #e63946;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light py-3 shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/Home">
                <span>Pizza</span>House
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/menuForCus">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/menuForCus">Menu</a></li>
                

                    <!-- Đã đăng nhập: hiện tên + Profile + Logout -->
                    <c:if test="${not empty sessionScope.user}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user-circle"></i> Xin chào, ${sessionScope.user.name}
                            </a>
                            <ul class="dropdown-menu">
                                
                                
                                <li>
                                    <form action="${pageContext.request.contextPath}/Logout" method="post" class="d-inline">
                                        <button type="submit" class="dropdown-item text-danger">
                                            <i class="fas fa-sign-out-alt"></i> Log out
                                        </button>
                                    </form>
                                </li>
                            </ul>
                        </li>
                    </c:if>

                    <!-- Chưa đăng nhập: hiện Login -->
                    <c:if test="${empty sessionScope.user}">
                        <li class="nav-item">
                            <a class="nav-link btn btn-outline-primary px-4" href="${pageContext.request.contextPath}/client/pages/login.jsp">
                                <i class="fas fa-sign-in-alt"></i> Đăng nhập
                            </a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </section>

        <!-- Features Section -->
        <section id="services" class="container mb-5">
            <div class="row g-4">
                <div class="col-12 col-sm-6 col-md-3">
                    <div class="feature-card h-100">
                        <a href="#master-chefs">
                            <div class="feature-icon"><i class="fas fa-user-tie"></i></div>
                            <h5 class="feature-title">Đầu Bếp Chuyên Nghiệp</h5>
                            <p class="feature-desc small">Chúng tôi có đội ngũ đầu bếp với nhiều năm kinh nghiệm, cam kết mang đến những món ăn tuyệt vời nhất.</p>
                        </a>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-3">
                    <div class="feature-card h-100">
                        <a href="#quality-food">
                            <div class="feature-icon"><i class="fas fa-utensils"></i></div>
                            <h5 class="feature-title">Món Ăn Chất Lượng</h5>
                            <p class="feature-desc small">Nguyên liệu tươi ngon, chế biến cẩn thận để tạo nên các món ăn hấp dẫn, đầy đủ dinh dưỡng.</p>
                        </a>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-3">
                    <div class="feature-card h-100">
                        <a href="#online-order">
                            <div class="feature-icon"><i class="fas fa-shopping-cart"></i></div>
                            <h5 class="feature-title">Đặt Hàng Trực Tuyến</h5>
                            <p class="feature-desc small">Đặt hàng nhanh chóng và tiện lợi ngay trên website của chúng tôi để được giao hàng tận nơi.</p>
                        </a>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-3">
                    <div class="feature-card h-100">
                        <a href="#service-24-7">
                            <div class="feature-icon"><i class="fas fa-headset"></i></div>
                            <h5 class="feature-title">Dịch Vụ 24/7</h5>
                            <p class="feature-desc small">Dịch vụ khách hàng hỗ trợ 24/7, luôn sẵn sàng giải đáp mọi thắc mắc và yêu cầu của bạn.</p>
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Menu Section (two-column list) -->
        <section id="menu" class="container mb-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="mb-0">Thực Đơn</h2>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <c:forEach var="food" items="${menuList}" varStatus="st">
                        <c:if test="${st.index % 2 == 0}">
                            <div class="menu-list-item">
                                <div class="menu-left">
                                    <img src="${food.imgURL != null ? food.imgURL : '/web/images/placeholder.png'}" alt="${food.foodName}" class="menu-img" />
                                    <div>
                                        <div class="menu-title">${food.foodName}</div>
                                        <div class="menu-desc small text-muted">${food.description}</div>
                                    </div>
                                </div>
                                <div class="menu-price"><fmt:formatNumber value="${food.price}" type="number" maxFractionDigits="0"/> Đ</div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>

                <div class="col-md-6">
                    <c:forEach var="food" items="${menuList}" varStatus="st">
                        <c:if test="${st.index % 2 == 1}">
                            <div class="menu-list-item">
                                <div class="menu-left">
                                    <img src="${food.imgURL != null ? food.imgURL : '/web/images/placeholder.png'}" alt="${food.foodName}" class="menu-img" />
                                    <div>
                                        <div class="menu-title">${food.foodName}</div>
                                        <div class="menu-desc small text-muted">${food.description}</div>
                                    </div>
                                </div>
                                <div class="menu-price"><fmt:formatNumber value="${food.price}" type="number" maxFractionDigits="0"/> Đ</div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="text-center">
            <div class="container">
                <p>© 2025 Pizza House. Bảo lưu mọi quyền.</p>
                <p>Theo dõi chúng tôi trên <a href="#">Facebook</a> | <a href="#">Instagram</a></p>
            </div>
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
