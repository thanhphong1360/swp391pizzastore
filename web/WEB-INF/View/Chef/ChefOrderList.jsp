<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chef - Quản lý món ăn</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f6f8fc;
                margin: 0;
            }

            header {
                background-color: #1E90FF;
                color: white;
                padding: 12px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            h2 {
                margin: 0;
            }

            .container {
                padding: 20px;
            }

            .filter {
                margin-bottom: 15px;
            }

            select {
                padding: 5px 8px;
                font-size: 14px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            th, td {
                border-bottom: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }

            th {
                background-color: #f0f6ff;
            }

            button.action {
                background-color: #1E90FF;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 5px 10px;
                cursor: pointer;
            }

            button.reject {
                background-color: #dc3545;
            }

            button.complete {
                background-color: #28a745;
            }

            form.inline {
                display: inline;
            }
        </style>
    </head>
    <body>
        <form action="${pageContext.request.contextPath}/Home" method="GET" style="margin-top: 15px;">
            <input type="submit" value="Về trang chủ">
        </form>

        <header>
            <h2>Chef - Quản lý món ăn</h2>
            <form action="${pageContext.request.contextPath}/logout" method="POST">
                <button type="submit" class="action">Đăng xuất</button>
            </form>
        </header>

        <div class="container">

            <div class="filter">
                <form method="GET" action="${pageContext.request.contextPath}/chef/Order">
                    <input type="hidden" name="action" value="browse">
                    <label>Trạng thái: </label>
                    <select name="status" onchange="this.form.submit()">
                        <option value="pending"   ${status == 'pending' ? 'selected' : ''}>Đang chờ duyệt</option>
                        <option value="doing"     ${status == 'doing' ? 'selected' : ''}>Đang chế biến</option>
                        <option value="completed" ${status == 'completed' ? 'selected' : ''}>Đã hoàn thành</option>
                        <option value="rejected"  ${status == 'rejected' ? 'selected' : ''}>Bị từ chối</option>
                    </select>
                </form>
            </div>

            <table>
                <tr>
                    <th>Order ID</th>
                    <th>Món</th>
                    <th>Số lượng</th>
                    <th>Ghi chú</th>
                    <th>Thao tác</th>
                </tr>

                <c:if test="${empty orderFoods}">
                    <tr>
                        <td colspan="5"><i>Không có món nào trong trạng thái này.</i></td>
                    </tr>
                </c:if>

                <c:forEach var="of" items="${orderFoods}">
                    <tr>
                        <td>${of.orderId}</td>
                        <td>${of.food.name}</td>
                        <td>${of.quantity}</td>
                        <td>${of.note}</td>
                        <td>
                            <!-- Pending -->
                            <c:if test="${status == 'pending'}">
                                <form class="inline" method="POST" action="${pageContext.request.contextPath}/chef/Order">
                                    <input type="hidden" name="action" value="approve">
                                    <input type="hidden" name="orderFoodId" value="${of.orderFoodId}">
                                    <input type="hidden" name="status" value="${status}">
                                    <button type="submit" class="action">Duyệt</button>
                                </form>
                                <form class="inline" method="POST" action="${pageContext.request.contextPath}/chef/Order">
                                    <input type="hidden" name="action" value="reject">
                                    <input type="hidden" name="orderFoodId" value="${of.orderFoodId}">
                                    <input type="hidden" name="status" value="${status}">
                                    <button type="submit" class="action reject">Từ chối</button>
                                </form>
                            </c:if>

                            <!-- Doing -->
                            <c:if test="${status == 'doing'}">
                                <form class="inline" method="POST" action="${pageContext.request.contextPath}/chef/Order">
                                    <input type="hidden" name="action" value="complete">
                                    <input type="hidden" name="orderFoodId" value="${of.orderFoodId}">
                                    <input type="hidden" name="status" value="${status}">
                                    <button type="submit" class="action complete">Hoàn tất</button>
                                </form>
                                <form class="inline" method="POST" action="${pageContext.request.contextPath}/chef/Order">
                                    <input type="hidden" name="action" value="reject">
                                    <input type="hidden" name="orderFoodId" value="${of.orderFoodId}">
                                    <input type="hidden" name="status" value="${status}">
                                    <button type="submit" class="action reject">Từ chối</button>
                                </form>
                            </c:if>

                            <!-- Completed / Rejected -->
                            <c:if test="${status == 'completed' || status == 'rejected'}">
                                <i>Không có thao tác</i>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>

        </div>
    </body>
</html>
