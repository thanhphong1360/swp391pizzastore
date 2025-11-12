<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách bàn - Pizza House</title>

        <!-- Font -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #fff8f6;
                margin: 0;
                padding: 30px;
                color: #333;
            }

            h1 {
                text-align: center;
                color: #e63946;
                margin-bottom: 25px;
                font-weight: 600;
            }

            .container {
                background: #ffffff;
                border-radius: 16px;
                padding: 25px 30px;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
                max-width: 1100px;
                margin: 0 auto;
            }

            .topbar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
            }

            .btn {
                background-color: #e63946;
                color: #fff;
                border: none;
                padding: 8px 18px;
                border-radius: 8px;
                cursor: pointer;
                font-size: 15px;
                font-weight: 500;
                transition: background-color 0.25s ease, transform 0.1s ease;
            }

            .btn:hover {
                background-color: #c92e3b;
                transform: translateY(-1px);
            }

            .btn-disabled {
                background-color: #aaa;
                cursor: not-allowed;
            }

            .table-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                gap: 20px;
            }

            .table-card {
                background: #fffaf8;
                border-radius: 12px;
                padding: 20px 10px;
                text-align: center;
                box-shadow: 0 3px 8px rgba(0, 0, 0, 0.08);
                border: 2px solid transparent;
                transition: all 0.25s ease;
            }

            .table-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 10px rgba(0, 0, 0, 0.12);
            }

            .available {
                border-color: #06d6a0;
            }

            .occupied {
                border-color: #ffb703;
            }

            .unavailable {
                border-color: #e63946;
            }

            .table-card h3 {
                margin: 0;
                font-size: 18px;
                color: #333;
            }

            .table-card p {
                margin: 8px 0;
                color: #666;
                font-size: 14px;
            }

            label {
                font-size: 14px;
                cursor: pointer;
                color: #333;
            }

            input[type="checkbox"] {
                margin-right: 6px;
                transform: scale(1.1);
            }

            .alert {
                background-color: #ffe8e8;
                color: #b91c1c;
                padding: 10px 15px;
                border-radius: 8px;
                margin-bottom: 15px;
                text-align: center;
                font-weight: 500;
            }

            .footer-actions {
                margin-top: 30px;
                text-align: center;
            }
        </style>

        <script>
            function confirmOpenMultiple() {
                const form = document.getElementById('openTablesForm');
                const checked = form.querySelectorAll('input[name="selectedTables"]:checked');
                if (checked.length === 0) {
                    alert("Vui lòng chọn ít nhất một bàn để mở!");
                    return;
                }
                if (confirm("Bạn có chắc muốn mở " + checked.length + " bàn đã chọn không?")) {
                    form.submit();
                }
            }
        </script>
    </head>

    <body>
        <div class="container">
            <div class="topbar">
                <form action="${pageContext.request.contextPath}/Home" method="GET">
                    <input type="submit" value="← Về trang chủ" class="btn">
                </form>
                <h1>Danh sách bàn</h1>
                <div></div>
            </div>

            <c:if test="${not empty message}">
                <div class="alert">${message}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/waiter/Table" method="POST" id="openTablesForm">
                <input type="hidden" name="action" value="open">

                <div class="table-container">
                    <c:forEach var="t" items="${tableList}">
                        <div class="table-card ${t.status}">
                            <h3>Bàn ${t.tableNumber}</h3>
                            <p><b>Trạng thái:</b> ${t.status}</p>

                            <c:choose>
                                <c:when test="${t.status == 'Available'}">
                                    <label>
                                        <input type="checkbox" name="selectedTables" value="${t.tableId}">
                                        Mở bàn
                                    </label>
                                </c:when>

                                <c:when test="${t.status == 'Occupied'}">
                                    <form action="${pageContext.request.contextPath}/waiter/Order" method="GET" style="display:inline;">
                                        <input type="hidden" name="tableId" value="${t.tableId}">
                                        <input type="hidden" name="action" value="order">
                                        <input type="submit" value="🍕 Gọi món" class="btn">
                                    </form>
                                </c:when>

                                <c:otherwise>
                                    <button class="btn btn-disabled" disabled>Không khả dụng</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </div>

                <div class="footer-actions">
                    <button type="button" class="btn" onclick="confirmOpenMultiple()">
                        Mở bàn đã chọn
                    </button>
                </div>
            </form>
        </div>
    </body>
</html>
