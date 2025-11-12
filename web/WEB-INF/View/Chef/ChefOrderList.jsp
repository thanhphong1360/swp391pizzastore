<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chef - Quản lý món ăn | Pizza House</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #fff8f3;
            margin: 30px;
        }
        h2 {
            color: #e63946;
            font-weight: 600;
        }
        /* Header */
        header {
            background-color: #e63946;
            color: white;
            padding: 15px 25px;
            border-radius: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        header h2 {
            margin: 0;
        }
        .logout-btn {
            background: white;
            color: #e63946;
            font-weight: 500;
            border: none;
            border-radius: 6px;
            padding: 6px 12px;
            cursor: pointer;
            transition: 0.3s;
        }
        .logout-btn:hover {
            background: #f2f2f2;
        }

        /* Filter */
        .filter {
            margin-bottom: 20px;
            display: flex;
            justify-content: flex-start;
            align-items: center;
        }
        select {
            padding: 6px 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
            margin-left: 5px;
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        th {
            background-color: #e63946;
            color: white;
            padding: 12px;
            text-align: center;
        }
        td {
            padding: 10px;
            border-bottom: 1px solid #eee;
            text-align: center;
            vertical-align: middle;
        }
        tr:hover {
            background: #fff1ee;
        }

        /* Buttons */
        .action {
            background-color: #00a8ff;
            border: none;
            border-radius: 6px;
            padding: 6px 10px;
            color: white;
            cursor: pointer;
            transition: 0.3s;
        }
        .action:hover { background-color: #0097e6; }

        .reject { background-color: #e84118; }
        .reject:hover { background-color: #c23616; }

        .complete { background-color: #44bd32; }
        .complete:hover { background-color: #4cd137; }

        form.inline { display: inline; }

        /* Return Home */
        .back-btn {
            background: #718093;
            color: white;
            border-radius: 8px;
            padding: 8px 14px;
            text-decoration: none;
            transition: 0.3s;
        }
        .back-btn:hover {
            background: #9c9c9c;
        }
    </style>
</head>
<body>

    <!-- 🔙 Back button -->
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/Home" class="back-btn">🏠 Về trang chủ</a>
    </div>

    <!-- Header -->
  

    <div class="container">

        <!-- Bộ lọc trạng thái -->
        <div class="filter">
            <form method="GET" action="${pageContext.request.contextPath}/chef/Order">
                <input type="hidden" name="action" value="browse">
                <label>Trạng thái:</label>
                <select name="status" onchange="this.form.submit()">
                    <option value="pending"   ${status == 'pending' ? 'selected' : ''}>Đang chờ duyệt</option>
                    <option value="doing"     ${status == 'doing' ? 'selected' : ''}>Đang chế biến</option>
                    <option value="completed" ${status == 'completed' ? 'selected' : ''}>Đã hoàn thành</option>
                    <option value="rejected"  ${status == 'rejected' ? 'selected' : ''}>Bị từ chối</option>
                </select>
            </form>
        </div>

        <!-- Danh sách món ăn -->
        <div style="overflow-x:auto;">
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Món</th>
                        <th>Số lượng</th>
                        <th>Ghi chú</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
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
                                <!-- Nếu đang chờ -->
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

                                <!-- Nếu đang chế biến -->
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

                                <!-- Nếu đã hoàn thành hoặc từ chối -->
                                <c:if test="${status == 'completed' || status == 'rejected'}">
                                    <i>Không có thao tác</i>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </div>
</body>
</html>
