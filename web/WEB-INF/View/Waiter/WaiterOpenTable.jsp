<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách bàn</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f8;
                text-align: center;
            }
            h1 {
                color: #333;
            }
            .table-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 15px;
                margin-top: 20px;
            }
            .table-card {
                width: 160px;
                height: 120px;
                border-radius: 12px;
                padding: 10px;
                box-shadow: 0 0 5px #ccc;
                background-color: white;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                align-items: center;
            }
            .available {
                border: 2px solid #4CAF50;
            }
            .occupied {
                border: 2px solid #f39c12;
            }
            .unavailable {
                border: 2px solid #f44336;
            }
            .btn {
                padding: 6px 12px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                color: white;
                font-size: 14px;
            }
            .btn-open {
                background-color: #4CAF50;
            }
            .btn-order {
                background-color: #2196F3;
            }
            .btn-disabled {
                background-color: #9e9e9e;
                cursor: not-allowed;
            }
            .alert {
                background-color: #e1f5fe;
                color: #0277bd;
                padding: 10px;
                border-radius: 6px;
                margin: 15px auto;
                width: 60%;
            }
            form {
                display: inline-block;
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
        <form action="${pageContext.request.contextPath}/Home" method="GET" style="margin-top: 15px;">
            <input type="submit" value="Về trang chủ">
        </form>

        <div>
            <c:if test="${not empty message}">
                <div class="alert">${message}</div>
            </c:if>
        </div>

        <h1>Danh sách bàn</h1>

        <form action="${pageContext.request.contextPath}/waiter/Table" method="POST" id="openTablesForm">
            <input type="hidden" name="action" value="open">

            <div class="table-container">
                <c:forEach var="t" items="${tableList}">
                    <div class="table-card ${t.status}">
                        <h3>${t.tableNumber}</h3>
                        <p>Trạng thái: ${t.status}</p>

                        <c:choose>
                            <c:when test="${t.status == 'available'}">
                                <label>
                                    <input type="checkbox" name="selectedTables" value="${t.tableId}">
                                    Chọn mở bàn
                                </label>
                            </c:when>

                            <c:when test="${t.status == 'occupied'}">
                                <form action="${pageContext.request.contextPath}/waiter/Order" method="GET" style="display:inline;">
                                    <input type="hidden" name="tableId" value="${t.tableId}">
                                    <input type="hidden" name="action" value="order">
                                    <input type="submit" value="Gọi món">
                                </form>
                            </c:when>

                            <c:otherwise>
                                <button class="btn btn-disabled" disabled>Không khả dụng</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </div>

            <div style="margin-top: 20px;">
                <button type="button" class="btn btn-open" onclick="confirmOpenMultiple()">
                    Mở bàn đã chọn
                </button>

            </div>
        </form>
    </body>
</html>
