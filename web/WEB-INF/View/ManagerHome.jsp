<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<style>
    :root {
        --orange: #EA6A12;
        --gray-text: #9CA3AF;
        --dark-text: #4B5563;
    }
    .ap-sidebar {
        width: 240px;
        min-height: 100vh;
        background: #fff;
        border-right: 1px solid #eee;
        padding: 1.5rem 1rem;
    }
    .ap-brand {
        font-size: 1.6rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        margin-bottom: 2rem;
        color: var(--orange);
    }
    .ap-brand span {
        display: inline-block;
        width: 38px;
        height: 24px;
        background: rgba(234,106,18,0.25);
        border-radius: 999px;
        margin-right: .5rem;
    }
    .ap-title {
        font-size: .85rem;
        text-transform: uppercase;
        letter-spacing: .04em;
        color: var(--gray-text);
        margin: 1.2rem 0 .5rem .3rem;
        letter-spacing: 0.05em;
    }
    .ap-link {
        display: flex;
        align-items: center;
        gap: .5rem;
        padding: .55rem .75rem;
        border-radius: 10px;
        color: var(--dark-text);
        text-decoration: none;
        transition: all 0.2s;
        font-weight: 500;
    }
    .ap-link i {
        font-size: 1rem;
    }
    .ap-link:hover {
        background: rgba(234,106,18,0.08);
        color: var(--orange);
    }
    .ap-link.active {
        background: var(--orange);
        color: #fff;
        box-shadow: 0 4px 14px rgba(234,106,18,0.45);
    }
</style>

<!-- Include the TopNav -->
<jsp:include page="TopNav.jsp"></jsp:include>

<!-- Main Content Layout -->
<div class="d-flex">
    <!-- Sidebar -->
    <div class="ap-sidebar">
        <div class="ap-brand">
            <span></span> Pizza Manager
        </div>

        <!-- Home Section -->
        <div class="ap-title">Home</div>
        <a href="#"
           class="ap-link ${param.active == 'dashboard' ? 'active' : ''}">
            <i class="bi bi-grid-fill"></i> Dashboard
        </a>

        <!-- Pages Section -->
        <div class="ap-title">Manager</div>
        <a href="${pageContext.request.contextPath}/manager/ListMenuServlet"
           class="ap-link ${param.active == 'menu' ? 'active' : ''}">
            <i class="bi bi-egg-fried"></i> Restaurant's Menu
        </a>
        <a href="${pageContext.request.contextPath}/manager/ListCategoryServlet"
           class="ap-link ${param.active == 'category' ? 'active' : ''}">
            <i class="bi bi-folder2"></i> Restaurant's Category
        </a>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
