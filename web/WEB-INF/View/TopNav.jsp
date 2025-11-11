<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

<style>
/* Container top nav */
.header-nav {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 12px;
    padding: 12px 20px;
    background-color: #fff8f3;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    border-radius: 0 0 12px 12px;
}

/* Button style */
.header-nav-link {
    display: flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
    padding: 10px 18px;
    border-radius: 10px;
    font-size: 15px;
    font-weight: 500;
    border: 1px solid transparent;
    transition: all 0.2s ease-in-out;
}

/* Hover effect */
.header-nav-link:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

/* Home button */
.btn-icon-home {
    background-color: #eef2ff;
    color: #3b82f6;
}
.btn-icon-home:hover {
    background-color: #dbeafe;
    color: #2563eb;
}

/* Logout button */
.btn-icon-logout {
    background-color: #fee2e2;
    color: #ef4444;
}
.btn-icon-logout:hover {
    background-color: #fecaca;
    color: #dc2626;
}
</style>

<nav class="header-nav">
    <a href="${pageContext.request.contextPath}/Home" class="header-nav-link btn-icon-home">
        <i class="fas fa-home"></i> Trang chủ
    </a>
    <a href="${pageContext.request.contextPath}/Logout" class="header-nav-link btn-icon-logout">
        <i class="fas fa-sign-out-alt"></i> Đăng xuất
    </a>
</nav>
