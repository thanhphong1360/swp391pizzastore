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
            <h3>Danh sách order chờ duyệt</h3>
            <c:choose>
                <c:when test="${not empty orderList}">
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
                                    <form action="${pageContext.request.contextPath}/chef/Order" method="POST" onsubmit="return confirmApprove(${order.orderId})">
                                        <input type="hidden" name="action" value="approve">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <input type="submit" value="Nhận">
                                    </form>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/chef/Order" method="POST" onsubmit="return confirmReject(this, ${order.orderId})">
                                        <input type="hidden" name="action" value="reject">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <input type="hidden" name="pageStatus" value="pending">
                                        <input type="hidden" name="reason" value="">
                                        <input type="submit" value="Hủy">
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <h3>Không có order nào chờ duyệt!</h3>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- ✅ Script xác nhận -->
        <script>
            // Xác nhận khi bấm "Nhận"
            function confirmApprove(orderId) {
                return confirm("Xác nhận nhận đơn #" + orderId + " ?");
            }

            // Nhập lý do khi bấm "Hủy"
            function confirmReject(form, orderId) {
                const reason = prompt("Nhập lý do hủy đơn #" + orderId + ":");
                if (reason === null) {
                    // Người dùng bấm Cancel → không gửi form
                    return false;
                }
                if (reason.trim() === "") {
                    alert("Vui lòng nhập lý do hủy đơn.");
                    return false;
                }

                // Gán lý do vào input hidden trước khi gửi form
                form.querySelector("input[name='reason']").value = reason;
                return confirm("Xác nhận hủy đơn #" + orderId + " với lý do: " + reason + " ?");
            }
        </script>
    </body>
</html>
