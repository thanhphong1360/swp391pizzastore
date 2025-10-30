<%-- 
    Document   : ChefOrderListRejected
    Created on : Oct 27, 2025, 9:06:27 PM
    Author     : cungp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order List</title>
        <style>
            table, th, td {
                border: 1px solid #ccc;
                border-collapse: collapse;
                padding: 6px 10px;
            }
            th {
                background-color: #f0f0f0;
            }
            button, input[type=submit] {
                padding: 4px 10px;
                border-radius: 4px;
                border: 1px solid #ccc;
                cursor: pointer;
            }
            input[type=submit]:hover {
                background-color: #e0e0e0;
            }
        </style>
    </head>
    <body>
        <form action="${pageContext.request.contextPath}/Home" method="GET">
            <input type="submit" value="Về trang chủ">
        </form>

        <div>
            <h3>Danh sách order đã hủy</h3>
            <c:choose>
                <c:when test="${not empty orderList}">
                    <table>
                        <tr>
                            <th>Order ID</th>
                            <th>Bàn</th>
                            <th>Trạng thái</th>
                            <th>Thời gian</th>
                            <th>Chi tiết</th>
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
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <h3>Không có order nào đã hủy!</h3>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
