<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manager Dashboard | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #fff8f3;
        margin: 0;
    }
    /* Sidebar */
    .sidebar {
        position: fixed;
        top: 0;
        left: 0;
        width: 240px;
        height: 100%;
        background-color: #2c2c2c;
        color: #fff;
        padding: 20px 15px;
    }
    .sidebar h3 {
        text-align: center;
        color: #e63946;
        margin-bottom: 25px;
    }
    .sidebar a {
        display: block;
        color: #ddd;
        text-decoration: none;
        padding: 12px;
        border-radius: 8px;
        margin-bottom: 8px;
        transition: 0.3s;
    }
    .sidebar a:hover { background-color: #e63946; color: #fff; }

    /* Main content */
    .content { margin-left: 260px; padding: 30px; }

    .topbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: #fff;
        padding: 12px 25px;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        margin-bottom: 25px;
    }
    .topbar h4 { color: #e63946; margin: 0; font-weight: 600; }
    .logout-btn {
        background-color: #e63946;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 8px;
        font-size: 14px;
        transition: 0.3s;
    }
    .logout-btn:hover { background-color: #c72e3b; }

    /* Stat cards */
    .stat-card {
        background: #fff;
        border-radius: 15px;
        padding: 25px;
        box-shadow: 0 6px 16px rgba(0,0,0,0.08);
        text-align: center;
        transition: 0.25s ease;
    }
    .stat-card:hover { transform: translateY(-6px); }
    .stat-icon { font-size: 3rem; margin-bottom: 10px; }
    .stat-title { color: #555; font-weight: 500; }
    .stat-value { font-size: 1.8rem; font-weight: 600; }

    /* Chart container */
    .chart-container {
        background: #fff;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        margin-bottom: 30px;
        height: 300px;  /* cố định chiều cao */
        max-width: 100%;
    }
    /* List group custom */
    .list-group-item-warning { background-color: #ffe5e0 !important; }
    .list-group-item-secondary { background-color: #f2f2f2 !important; }
    .list-group-item-light { background-color: #fff8f3 !important; }
    h5 { font-weight: 600; color: #e63946; text-align: center; margin-bottom: 15px; }
</style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h3>Pizza<span style="color:white;">House</span></h3>
    <a href="${pageContext.request.contextPath}/manager/users">👥 Staff Accounts</a>
    <a href="${pageContext.request.contextPath}/manager/ListMenuServlet">🍕 Restaurant Menu</a>
    <a href="${pageContext.request.contextPath}/manager/ListCategoryServlet">📂 Categories</a>
    <a href="${pageContext.request.contextPath}/manager/table/list">🪑 Tables</a>
    <a href="${pageContext.request.contextPath}/manager/ingredients">🥦 Ingredients</a>
    <a href="${pageContext.request.contextPath}/auditlog">📝 Audit Log</a>
    <a href="${pageContext.request.contextPath}/manager/discount/list">🏷️ Discount</a>
</div>

<!-- Main content -->
<div class="content">
    <div class="topbar">
        <h4>📊 Manager Dashboard</h4>
        <form action="${pageContext.request.contextPath}/Logout" method="post">
            <button class="logout-btn">Logout</button>
        </form>
    </div>

    <!-- STAT CARDS -->
    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-icon text-success"><i class="bi bi-currency-dollar"></i></div>
                <p class="stat-title">Doanh thu hôm nay</p>
                <p class="stat-value text-success">
                    <fmt:formatNumber value="${todayRevenue}" type="currency" currencySymbol="" /> VND
                </p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-icon text-primary"><i class="bi bi-receipt"></i></div>
                <p class="stat-title">Tổng đơn hàng</p>
                <p class="stat-value text-primary">${totalInvoices}</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-icon text-info"><i class="bi bi-people"></i></div>
                <p class="stat-title">Tổng khách hàng</p>
                <p class="stat-value text-info">${totalCustomers}</p>
            </div>
        </div>
    </div>

    <!-- Filter box -->
    <div class="filter-box">
        <form action="${pageContext.request.contextPath}/manager/dashboard/filter" method="post" class="row g-3 align-items-end">
            <div class="col-md-5">
                <label class="form-label fw-bold">Từ ngày</label>
                <input type="date" name="fromDate" class="form-control" value="${fromDate}" required>
            </div>
            <div class="col-md-5">
                <label class="form-label fw-bold">Đến ngày</label>
                <input type="date" name="toDate" class="form-control" value="${toDate}" required>
            </div>
            <div class="col-md-2 d-grid">
                <button type="submit" class="btn btn-danger">Lọc</button>
            </div>
        </form>
    </div>

    <!-- Charts -->
    <div class="row g-4">
        <div class="col-md-6">
            <div class="chart-container">
                <h5>📈 Doanh thu theo ngày</h5>
                <canvas id="revenueChart"></canvas>
            </div>
            <div class="chart-container">
                <h5>🍕 Top 5 Món Ăn Bán Chạy</h5>
                <c:choose>
                    <c:when test="${not empty topFoods}">
                        <div class="list-group overflow-auto" style="max-height:220px;">
                            <c:forEach items="${topFoods}" var="dish" varStatus="status">
                                <div class="list-group-item d-flex justify-content-between align-items-center
                                     ${status.index == 0 ? 'list-group-item-warning' :
                                       status.index == 1 ? 'list-group-item-secondary' :
                                       status.index == 2 ? 'list-group-item-light' : ''}">
                                    <strong>${status.index + 1}. ${dish.foodName}</strong>
                                    <span class="badge bg-danger rounded-pill">${dish.quantity} phần</span>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="text-center text-muted mb-0">Không có dữ liệu món ăn.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="col-md-6">
            <div class="chart-container">
                <h5>🏷 Doanh thu theo loại món</h5>
                <canvas id="categoryChart"></canvas>
            </div>
            <div class="chart-container">
                <h5>🛒 Kênh bán hàng</h5>
                <canvas id="channelChart"></canvas>
            </div>
        </div>
    </div>
</div>

<!-- Chart.js scripts -->
<script>
document.addEventListener('DOMContentLoaded', function () {
    // Revenue by Date
    const ctx1 = document.getElementById('revenueChart').getContext('2d');
    const labels1 = [<c:forEach items="${revenueByDate}" var="r">'${r.date}',</c:forEach>];
    const data1 = [<c:forEach items="${revenueByDate}" var="r">${r.total},</c:forEach>];
    new Chart(ctx1, {
        type: 'line',
        data: { labels: labels1, datasets: [{ label: 'Doanh thu (VND)', data: data1, fill:true, backgroundColor:'rgba(230,57,70,0.2)', borderColor:'#e63946', tension:0.3, pointRadius:4 }] },
        options: { responsive:true, maintainAspectRatio:false, plugins:{ tooltip:{ callbacks:{ label: ctx => 'Doanh thu: ' + ctx.parsed.y.toLocaleString('vi-VN') + ' VND' }}}, scales:{ y:{ beginAtZero:true, ticks:{ callback: v => v.toLocaleString('vi-VN') + ' VND' }}, x:{ ticks:{ maxRotation:45, minRotation:45 }}} }
    });

    // Revenue by Category
    const ctx2 = document.getElementById('categoryChart').getContext('2d');
    const labels2 = [<c:forEach items="${revenueByCategory}" var="c">'${c.category}',</c:forEach>];
    const data2 = [<c:forEach items="${revenueByCategory}" var="c">${c.revenue},</c:forEach>];
    new Chart(ctx2, {
        type: 'pie',
        data: { labels: labels2, datasets: [{ data: data2, backgroundColor: ['#e63946','#ffb703','#8ecae6','#219ebc','#023047'] }] },
        options: { responsive:true, maintainAspectRatio:false, plugins:{ legend:{position:'bottom'}, tooltip:{ callbacks:{ label: ctx => ctx.label + ': ' + ctx.parsed.toLocaleString('vi-VN') + ' VND' }}}}
    });

    // Channel chart
    const ctx3 = document.getElementById('channelChart').getContext('2d');
    new Chart(ctx3, {
        type: 'doughnut',
        data: { labels:['Online','Offline'], datasets:[{ data:[${orderChannel['Online'] != null ? orderChannel['Online'] : 0}, ${orderChannel['Offline'] != null ? orderChannel['Offline'] : 0}], backgroundColor:['#e63946','#8ecae6'] }] },
        options: { responsive:true, maintainAspectRatio:false, plugins:{ legend:{position:'bottom'}, tooltip:{ callbacks:{ label: ctx => ctx.label + ': ' + ctx.parsed + ' đơn' }}}}
    });
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
