<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manager Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            .stat-card {
                background: white;
                border-radius: 12px;
                padding: 20px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                text-align: center;
                transition: transform 0.2s;
            }
            .stat-card:hover {
                transform: translateY(-5px);
            }
            .stat-icon {
                font-size: 2.5rem;
                margin-bottom: 10px;
            }
            .chart-container {
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                height: 320px;
                display: flex;
                flex-direction: column;
            }
            .filter-box {
                background: #f8f9fa;
                padding: 15px;
                border-radius: 10px;
                margin-bottom: 20px;
            }
            .list-group-item-warning {
                background-color: #fff3cd !important;
            }
            .list-group-item-secondary {
                background-color: #e2e3e5 !important;
            }
            .list-group-item-light {
                background-color: #f8f9fa !important;
            }
        </style>
    </head>
    <body class="bg-light">

        <div class="container-fluid py-4">

            <h2 class="mb-4 text-center text-primary">
                Manager Dashboard
            </h2>

            <!-- STAT CARDS -->
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-icon text-success"><i class="bi bi-currency-dollar"></i></div>
                        <h5>Doanh thu hôm nay</h5>
                        <h3 class="text-success"><fmt:formatNumber value="${todayRevenue}" type="currency" currencySymbol="" /> VND</h3>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-icon text-primary"><i class="bi bi-receipt"></i></div>
                        <h5>Tổng đơn hàng</h5>
                        <h3 class="text-primary">${totalInvoices}</h3>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-icon text-info"><i class="bi bi-people"></i></div>
                        <h5>Tổng khách hàng</h5>
                        <h3 class="text-info">${totalCustomers}</h3>
                    </div>
                </div>
            </div>

            <!-- CHỈ 1 FILTER: Từ ngày → Đến ngày + Lọc -->
            <div class="filter-box">
                <form action="${pageContext.request.contextPath}/manager/dashboard/filter" method="post" class="row g-3 align-items-end">
                    <div class="col-md-5">
                        <label class="form-label"><strong>Từ ngày</strong></label>
                        <input type="date" name="fromDate" class="form-control" value="${fromDate}" required>
                    </div>
                    <div class="col-md-5">
                        <label class="form-label"><strong>Đến ngày</strong></label>
                        <input type="date" name="toDate" class="form-control" value="${toDate}" required>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">
                            Lọc
                        </button>
                    </div>
                </form>
            </div>

            <!-- 4 CHARTS: 2 TRÁI - 2 PHẢI -->
            <div class="row g-4">
                <!-- TRÁI: Doanh thu theo ngày + Top 5 -->
                <div class="col-md-6">
                    <div class="chart-container mb-4">
                        <h5 class="text-center mb-3">Doanh thu theo ngày</h5>
                        <canvas id="revenueChart"></canvas>
                    </div>

                    <div class="chart-container">
                        <h5 class="text-center mb-3">Top 5 Món Ăn Bán Chạy</h5>
                        <c:choose>
                            <c:when test="${not empty topFoods}">
                                <div class="list-group overflow-auto" style="max-height: 220px;">
                                    <c:forEach items="${topFoods}" var="dish" varStatus="status">
                                        <div class="list-group-item d-flex justify-content-between align-items-center
                                             ${status.index == 0 ? 'list-group-item-warning' : 
                                               status.index == 1 ? 'list-group-item-secondary' : 
                                               status.index == 2 ? 'list-group-item-light' : ''}">
                                            <strong>${status.index + 1}. ${dish.foodName}</strong>
                                            <span class="badge bg-primary rounded-pill">${dish.quantity} phần</span>
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

                <!-- PHẢI: Doanh thu loại món + Kênh bán -->
                <div class="col-md-6">
                    <div class="chart-container mb-4">
                        <h5 class="text-center mb-3">Doanh thu theo loại món</h5>
                        <canvas id="categoryChart"></canvas>
                    </div>

                    <div class="chart-container">
                        <h5 class="text-center mb-3">Kênh bán hàng</h5>
                        <canvas id="channelChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- CHART.JS + FIX BIỂU ĐỒ DÀI -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {

                // === 1. DOANH THU THEO NGÀY - SỬA LỖI DÀI BẤT TẬN ===
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

    </body>
</html>