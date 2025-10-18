<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách bàn</title>
    <style>
        .table-card {
            display: inline-block;
            width: 150px;
            height: 100px;
            margin: 10px;
            text-align: center;
            border-radius: 10px;
            padding: 10px;
            box-shadow: 0 0 5px #ccc;
        }
        .available {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }
        .occupied {
            background-color: #f44336;
            color: white;
            cursor: not-allowed;
        }
    </style>
    <script>
        function confirmOpen(tableId, tableName) {
            if (confirm("Bạn có chắc muốn mở bàn " + tableName + " không?")) {
                window.location.href = "waiter/OpenTable?tableId=" + tableId;
            }
        }
    </script>
</head>
<body>
    <h1>Danh sách bàn</h1>

    <div>
        <c:forEach var="t" items="${tableList}">
            <div class="table-card ${t.status}">
                <h3>${t.tableName}</h3>
                <p>Trạng thái: ${t.status}</p>

                <c:if test="${t.status == 'available'}">
                    <button onclick="confirmOpen('${t.tableId}', '${t.tableName}')">Mở bàn</button>
                </c:if>
                <c:if test="${t.status != 'available'}">
                    <button disabled>Không khả dụng</button>
                </c:if>
            </div>
        </c:forEach>
    </div>
</body>
</html>
