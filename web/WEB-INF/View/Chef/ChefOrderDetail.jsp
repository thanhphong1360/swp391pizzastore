<%-- 
    Document   : ChefOrderDetail
    Created on : Oct 24, 2025, 3:21:54 PM
    Author     : cungp
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Detail</title>
    </head>
    <body>
        <div>
            <c:choose>
                <c:when test="${not empty backUrl}">
                        <a href="${backUrl}">Quay lại</a>
                </c:when>
                <c:otherwise>
                    <form action="${pageContext.request.contextPath}/Home" method="get">
                        <button type="submit">Về trang chính</button>
                    </form>
                </c:otherwise>
            </c:choose>

        </div>
        <div>
            <h3>Chi tiết order</h3>
            <h4>Order ID: ${order.orderId}</h4>
            <h4>Bàn: ${order.table.tableNumber}</h4>
            <h4>Bồi bàn: ${order.waiter.name}</h4>
            <h4>Trạng thái: ${order.status}</h4>
            <h4>Đầu bếp: <c:if test="${order.chef == null}">Chưa có</c:if> <c:if test="${order.chef != null}">${order.chef.name}</c:if></h4>
            <h4>Note: ${order.note}</h4>
            <h4>Danh sách món: </h4>
            <table>
                <tr>
                    <th>Tên món</th>
                    <th>Số lượng</th>
                    <th>Thành tiền (VND)</th>
                </tr>
                <c:forEach items="${orderFoodList}" var="orderFood">
                    <tr>
                        <td>${orderFood.food.name}</td>
                        <td>${orderFood.quantity}</td>
                        <td>${orderFood.price}</td>
                    </tr>
                </c:forEach>
            </table>
            <h4>Tổng tiền: ${order.price} (VND)</h4>
        </div>
    </body>
</html>
