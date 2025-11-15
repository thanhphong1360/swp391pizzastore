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
        <title>Pizza House - Trang Chủ</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            :root{
                --brand:#e63946;
                --muted:#6c757d;
                --bg:#fff8f3
            }
            
            body{
                font-family: 'Poppins', sans-serif;
                background:var(--bg)
            }
            .navbar-brand span{
                color:var(--brand);
                font-weight:700
            }
            .hero{
                background: url('https://images.unsplash.com/photo-1601924582971-b0d29f3b39d9') center/cover no-repeat;
                height:60vh;
                display:flex;
                align-items:center
            }
            .hero .container{
                color:#fff
            }
            .card-product{
                border:0;
                border-radius:12px;
                box-shadow:0 8px 24px rgba(0,0,0,0.06);
                transition:transform .12s
            }
            .card-product:hover{
                transform:translateY(-6px)
            } /* Banner styles */
            .banner{
                background:linear-gradient(90deg, rgba(0,0,0,0.55), rgba(0,0,0,0.25)), url('https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D') center/cover no-repeat;
                border-radius:8px;
                padding:60px 0
            }
            .banner .text-col{
                padding:40px 20px
            }
            .banner-title{
                line-height:1.02;
                letter-spacing: -1px
            }
            .banner-sub{
                max-width:560px;
                color:rgba(255,255,255,0.9)
            }
            .banner-image{
                width:360px;
                height:360px;
                border-radius:50%;
                background-image:url('https://plus.unsplash.com/premium_photo-1733259709671-9dbf22bf02cc?mark=https%3A%2F%2Fimages.unsplash.com%2Fopengraph%2Flogo.png&amp;mark-w=64&amp;mark-align=top%2Cleft&amp;mark-pad=50&amp;h=630&amp;w=1200&amp;crop=faces%2Cedges&amp;blend-w=1&amp;blend=000000&amp;blend-mode=normal&amp;blend-alpha=10&amp;auto=format&amp;fit=crop&amp;q=60&amp;ixid=M3wxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNzYzMjA2NzkxfA&amp;ixlib=rb-4.1.0"/><meta name="twitter:creator" content="@gettyimages"/><meta property="og:title" content="Photo by Getty Images on Unsplash"/><meta property="og:description" content="Download this photo by Getty Images on Unsplash"/><meta property="og:type" content="website"/><meta property="og:url" content="https://unsplash.com/photos/classic-pepperoni-pizza-with-cut-slices-isolated-on-a-white-background-5B476qR_PzY"/><meta property="og:image" content="https://plus.unsplash.com/premium_photo-1733259709671-9dbf22bf02cc?mark=https%3A%2F%2Fimages.unsplash.com%2Fopengraph%2Flogo.png&amp;mark-w=64&amp;mark-align=top%2Cleft&amp;mark-pad=50&amp;h=630&amp;w=1200&amp;crop=faces%2Cedges&amp;blend-w=1&amp;blend=000000&amp;blend-mode=normal&amp;blend-alpha=10&amp;auto=format&amp;fit=crop&amp;q=60&amp;ixid=M3wxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNzYzMjA2NzkxfA&amp;ixlib=rb-4.1.0');
                background-size:cover;
                background-position:center;
                box-shadow:0 12px 30px rgba(0,0,0,0.4)
            }
            @media (max-width:991px){
                .banner{
                    padding:36px 0
                }
                .banner-image{
                    width:260px;
                    height:260px
                }
            }
            /* Features cards */
            .feature-card{
                background:#fff;
                border-radius:10px;
                padding:28px;
                box-shadow:0 12px 30px rgba(18,28,48,0.06);
                min-height:170px
            }
            .feature-icon{
                width:56px;
                height:56px;
                border-radius:10px;
                display:flex;
                align-items:center;
                justify-content:center;
                background:#fff7f7;
                color:var(--brand);
                font-size:22px;
                box-shadow:0 6px 18px rgba(0,0,0,0.04);
                margin-bottom:14px
            }
            .feature-title{
                font-weight:700;
                margin-bottom:8px
            }
            .feature-desc{
                color:var(--muted)
            } /* About section */
            .about-section .img-grid img{
                width:100%;
                height:170px;
                object-fit:cover;
                border-radius:8px
            }
            .about-title small{
                color:var(--brand);
                font-weight:600
            }
            .about-stats h3{
                color:var(--brand);
                font-size:2rem;
                margin-bottom:0
            }
            .about-stats .stat-label{
                color:var(--muted);
                font-size:.85rem
            }
            @media (max-width:991px){
                .about-section .img-grid img{
                    height:120px
                }
            }
            .price{
                color:var(--brand);
                font-weight:700
            }
            footer{
                background:#222;
                color:#ddd;
                padding:30px 0
            }
            footer a{
                color:var(--brand)
            }
            .text-truncate-2{
                display:-webkit-box;
                -webkit-line-clamp:2;
                -webkit-box-orient:vertical;
                line-clamp:2;
                overflow:hidden
            } /* Menu list style (two-column) */
            .menu-list-item{
                display:flex;
                align-items:center;
                justify-content:space-between;
                border-bottom:1px solid #e9ecef;
                padding:12px 0;
                gap: 20px; /* Thêm khoảng cách giữa hình ảnh và các phần còn lại */
            }
            .menu-left{
                display:flex;
                gap:20px; /* Thêm khoảng cách giữa hình ảnh và tên món ăn */
                align-items:center
            }
            .menu-img{
                width:200px;
                height:200px;
                object-fit:cover;
                border-radius:8px;
            }
            .menu-title{
                font-weight:700
            }
            .menu-desc{
                color:var(--muted);
                font-size:.92rem
            }
            .menu-price{
                color:var(--brand);
                font-weight:800
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
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/menuForCus">Trang Chủ</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/menuForCus#aboutus">Về Chúng Tôi</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/menuForCus#services">Dịch Vụ</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/menuForCus#menu">Thực Đơn</a></li>


                        <!-- Đã đăng nhập: hiện tên + Profile + Logout -->
                        <c:if test="${not empty sessionScope.user}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle"></i> Xin chào, ${sessionScope.user.name}
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                            <i class="fas fa-user-edit"></i> Hồ sơ
                                        </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <form action="${pageContext.request.contextPath}/Logout" method="post" class="d-inline">
                                            <button type="submit" class="dropdown-item text-danger">
                                                <i class="fas fa-sign-out-alt"></i> Đăng xuất
                                            </button>
                                        </form>
                                    </li>
                                </ul>
                            </li>
                        </c:if>

                        <c:if test="${empty sessionScope.user}">
                            <li class="nav-item">
                                <a class="nav-link btn btn-outline-primary px-4" href="${pageContext.request.contextPath}/client/pages/login.jsp">
                                    <i class="fas fa-sign-in-alt"></i> Đăng nhập
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </nav>


        <section id="aboutus" class="banner mb-5">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-7 text-col text-white">
                        <h1 class="banner-title display-4 fw-bold">Thưởng Thức Bữa Ăn Ngon Miệng Của Chúng Tôi</h1>
                        <p class="banner-sub lead">Chúng tôi mang đến cho bạn những món ăn tuyệt vời, đầy đủ dinh dưỡng và thơm ngon.</p>
                    </div>
                    <div class="col-lg-5 image-col d-none d-lg-flex justify-content-end">
                        <div class="banner-image" aria-hidden="true"></div>
                    </div>
                </div>
            </div>
        </section>

        <!-- About Section -->
        <section id="aboutus" class="about-section container mb-5">
            <div class="row g-4 align-items-center">
                <div class="col-lg-6">
                    <div class="row g-3 img-grid">
                        <div class="col-6"><img src="https://images.unsplash.com/photo-1553909489-cd47e0907980?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2FuZHdpY2h8ZW58MHx8MHx8fDA%3D" alt="pizza-3"></div>
                        <div class="col-6"><img src="https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=600&q=60" alt="pizza-3"></div>

                        <div class="col-6"><img src="https://images.unsplash.com/photo-1585032226651-759b368d7246?q=80&w=992&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="pizza-3"></div>
                        <div class="col-6"><img src="https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="pizza-3"></div>

                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="about-copy">
                        <div class="about-title mb-2"><small>Về Chúng Tôi</small>
                            <h2 class="fw-bold">Chào Mừng Đến Với <span class="text-brand">Pizza House</span></h2>
                        </div>
                        <p class="text-muted">Chúng tôi tự hào mang đến cho bạn những món pizza tươi ngon, được làm từ nguyên liệu cao cấp và công thức độc đáo. Pizza House cam kết luôn mang đến trải nghiệm ẩm thực tuyệt vời cho bạn và gia đình.</p>
                        <p class="text-muted">Chúng tôi cung cấp nhiều lựa chọn thực đơn phong phú, từ pizza truyền thống đến các món ăn sáng tạo, luôn đảm bảo chất lượng và hương vị hoàn hảo.</p>

                        <div class="row mt-4 about-stats">
                            <div class="col-6 d-flex align-items-center">
                                <div class="me-3 border-end pe-3">
                                    <h3>15</h3>
                                    <div class="stat-label">Năm Kinh Nghiệm</div>
                                </div>
                            </div>
                            <div class="col-6 d-flex align-items-center justify-content-end">
                                <div class="text-end">
                                    <h3>50</h3>
                                    <div class="stat-label">Đầu Bếp Nổi Tiếng</div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
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
