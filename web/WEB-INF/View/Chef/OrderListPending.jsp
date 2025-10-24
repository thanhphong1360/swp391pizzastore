<%-- 
    Document   : OrderList
    Created on : Oct 24, 2025, 12:53:50 PM
    Author     : cungp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order List</title>
    </head>
    <body>
        <form action="${pageContext.request.contextPath}/Home" method="GET">
            <input type="submit" value="Về trang chủ">
        </form>
        <div>
            <h3>Danh sách order chờ duyệt</h3>
            <table>
                <tr>
                    <th>Order ID</th>
                    <th>Bàn</th>
                    <th>Trạng thái</th>
                    <th>Thời gian</th>
                    <th>Chi tiết</th>
                    <th>Nhận đơn</th>
                    <th>Hủy đơn</th>
                </tr>
                <c:forEach items="${orderList}" var="order">
                    <tr>
                        <td>${order.orderId}</td>
                        <td>${order.table.tableNumber}</td>
                        <td>${order.status}</td>
                        <td>${order.created_at}</td>
                        <td>
                            <form action="${pageContext.request.contextPath}/chef/Order" method="GET">
                                <input type="hidden" name="action" value="detail">
                                <input type="hidden" name="orderId" value="${order.orderId}">
                                <input type="submit" value="Chi tiết">
                            </form>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/chef/Order" method="POST">
                                <input type="hidden" name="approve">
                                <input type="hidden" name="orderId" value="${order.orderId}">
                                <input type="submit" value="Nhận">
                            </form>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/chef/Order" method="POST">
                                <input type="hidden" name="reject">
                                <input type="hidden" name="orderId" value="${order.orderId}">
                                <input type="submit" value="Hủy">
                            </form>
                        </td>
                    </tr><!--  -->
                </c:forEach>
            </table>
        </div>
    </body>
</html>
