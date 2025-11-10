<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Order Food</title>
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
            .working {
                background-color: #F5BE27;
                color: white;
            }
        </style>
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
        <h1>Danh sách bàn đang hoạt động</h1>
        <c:if test="${not empty tableList}">
            <div>
                <c:forEach var="t" items="${tableList}">
                    <div class="table-card working">
                        <h3>${t.tableNumber}</h3>
                        <form action="${pageContext.request.contextPath}/waiter/Order" method="GET" style="display:inline;">
                            <input type="hidden" name="tableId" value="${t.tableId}">
                            <input type="hidden" name="action" value="order">
                            <input type="submit" value="Order">
                        </form>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${empty tableList}">
            <h4>Không có bàn đang hoạt động!</h4>
        </c:if>
    </body>
</html>
