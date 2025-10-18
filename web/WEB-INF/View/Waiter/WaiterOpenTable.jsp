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
            }
            .occupied {
                background-color: #f44336;
                color: white;
            }
            button {
                padding: 5px 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
        </style>
        <script>
            function confirmOpen(form, tableName) {
                if (confirm("Bạn có chắc muốn mở bàn " + tableName + " không?")) {
                    form.submit();
                }
            }
        </script>
    </head>
    <body>
        <form action="${pageContext.request.contextPath}/Home" method="GET">
            <input type="submit" value="Về trang chủ">
        </form>
        <div>
            <c:if test="${not empty message}">
                <div class="alert">${message}</div>
            </c:if>
        </div>
        <h1>Danh sách bàn</h1>

        <div>
            <c:forEach var="t" items="${tableList}">
                <div class="table-card ${t.status}">
                    <h3>${t.tableNumber}</h3>
                    <p>Trạng thái: ${t.status}</p>

                    <c:if test="${t.status == 'available'}">
                        <form action="${pageContext.request.contextPath}/waiter/Table" method="POST" style="display:inline;">
                            <input type="hidden" name="tableId" value="${t.tableId}">
                            <input type="hidden" name="action" value="open">
                            <button type="button"
                                    onclick="confirmOpen(this.form, '${t.tableNumber}')">
                                Mở bàn
                            </button>
                        </form>
                    </c:if>
                    <c:if test="${t.status != 'available'}">
                        <button disabled>Không khả dụng</button>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </body>
</html>
