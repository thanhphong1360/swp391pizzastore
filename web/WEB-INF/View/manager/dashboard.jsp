<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                background-color: #fff8f3;
                font-family: 'Poppins', sans-serif;
            }
            /* Header */
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
            /* Stat cards */
            .stat-card {
                background: #fff;
                border-radius: 15px;
                padding: 25px;
                box-shadow: 0 6px 16px rgba(0,0,0,0.08);
                text-align: center;
                transition: 0.25s ease;
            }
            .stat-card:hover {
                transform: translateY(-6px);
            }
            .stat-icon {
                font-size: 3rem;
                margin-bottom: 10px;
            }
            .stat-title {
                color: #555;
                font-weight: 500;
            }
            .stat-value {
                font-size: 1.8rem;
                font-weight: 600;
            }
            /* Filter box */
            .filter-box {
                background: #fff;
                padding: 20px;
                border-radius: 12px;
                margin-bottom: 35px;
                box-shadow: 0 3px 10px rgba(0,0,0,0.08);
            }
            /* Chart container */
            .chart-container {
                background: #fff;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                margin-bottom: 30px;
                height: 320px;
                display: flex;
                flex-direction: column;
}
            /* List group custom */
            .list-group-item-warning {
                background-color: #ffe5e0 !important;
            }
            .list-group-item-secondary {
                background-color: #f2f2f2 !important;
            }
            .list-group-item-light {
                background-color: #fff8f3 !important;
            }
            h5 {
                font-weight: 600;
                color: #e63946;
                text-align: center;
                margin-bottom: 15px;
            }
            .list-group {
                max-height: 220px;
                overflow-y: auto;
            }
        </style>
    </head>
    <body>
        <div class="container py-4">
            <!-- HEADER -->
            <div class="header-bar">
                <h2>📊 Manager Dashboard</h2>
                <a href="${pageContext.request.contextPath}/Home" class="btn-custom btn-dashboard">🏠 Back to Dashboard</a>
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

            <!-- FILTER BOX -->
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

            <!-- CHARTS & TOP FOODS -->
            <div class="row g-4">
                <!-- LEFT COLUMN -->
                <div class="col-md-6">
                    <div class="chart-container">
                        <h5>📈 Doanh thu theo ngày</h5>
                        <canvas id="revenueChart"></canvas>
                    </div>

                    <div class="chart-container">
                        <h5>🍕 Top 5 Món Ăn Bán Chạy</h5>
                        <c:choose>
                            <c:when test="${not empty topFoods}">
                                <div class="list-group">
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

                <!-- RIGHT COLUMN -->
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

        <!-- CHARTS SCRIPT -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {

                // === 1. DOANH THU THEO NGÀY ===
                const ctx1 = document.getElementById('revenueChart').getContext('2d');
                        const labels1 = [<c:forEach items="${revenueByDate}" var="r">'${r.date}',</c:forEach>];
const data1 = [<c:forEach items="${revenueByDate}" var="r">${r.total},</c:forEach>];

                new Chart(ctx1, {
                    type: 'line',
                    data: {
                        labels: labels1,
                        datasets: [{
                                label: 'Doanh thu (VND)',
                                data: data1,
                                fill: true,
                                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                borderColor: 'rgb(54, 162, 235)',
                                tension: 0.3,
                                pointRadius: 4
                            }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            tooltip: {
                                callbacks: {
                                    label: ctx => 'Doanh thu: ' + ctx.parsed.y.toLocaleString('vi-VN') + ' VND'
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: v => v.toLocaleString('vi-VN') + ' VND'
                                }
                            },
                            x: {
                                ticks: {
                                    maxRotation: 45,
                                    minRotation: 45
                                }
                            }
                        }
                    }
                });

                // === 2. DOANH THU THEO LOẠI MÓN ===
                const ctx2 = document.getElementById('categoryChart').getContext('2d');
                        const labels2 = [<c:forEach items="${revenueByCategory}" var="c">'${c.category}',</c:forEach>];
                const data2 = [<c:forEach items="${revenueByCategory}" var="c">${c.revenue},</c:forEach>];

                new Chart(ctx2, {
                    type: 'pie',
                    data: {
                        labels: labels2,
                        datasets: [{
                                data: data2,
                                backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF']
                            }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {position: 'bottom'},
                            tooltip: {
                                callbacks: {
                                    label: ctx => ctx.label + ': ' + ctx.parsed.toLocaleString('vi-VN') + ' VND'
                                }
                            }
}
                    }
                });

                // === 3. KÊNH BÁN HÀNG ===
                const ctx3 = document.getElementById('channelChart').getContext('2d');
                new Chart(ctx3, {
                    type: 'doughnut',
                    data: {
                        labels: ['Online', 'Offline'],
                        datasets: [{
                                data: [
            ${orderChannel['Online'] != null ? orderChannel['Online'] : 0},
            ${orderChannel['Offline'] != null ? orderChannel['Offline'] : 0}
                                ],
                                backgroundColor: ['#36A2EB', '#FF6384']
                            }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {position: 'bottom'},
                            tooltip: {
                                callbacks: {
                                    label: ctx => ctx.label + ': ' + ctx.parsed + ' đơn'
                                }
                            }
                        }
                    }
                });
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>