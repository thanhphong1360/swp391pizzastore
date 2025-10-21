<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Order Món Ăn | PizzaStore Manager</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f6f8fc;
                margin: 0;
                color: #333;
            }
            header {
                background-color: #1E90FF;
                color: white;
                padding: 10px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .container {
                display: flex;
                height: calc(100vh - 60px);
            }
            .sidebar {
                width: 220px;
                background-color: #ffffff;
                border-right: 1px solid #ddd;
                padding: 15px;
                overflow-y: auto;
            }
            .sidebar h3 {
                color: #1E90FF;
                margin-bottom: 10px;
            }
            .sidebar ul {
                list-style: none;
                padding: 0;
            }
            .sidebar li {
                margin: 8px 0;
            }
            .sidebar a {
                text-decoration: none;
                color: #333;
                display: block;
                padding: 6px 10px;
                border-radius: 6px;
            }
            .sidebar a.available:hover {
                background-color: #e0f0ff;
                color: #1E90FF;
            }
            .sidebar a.occupied {
                color: gray;
                cursor: not-allowed;
            }
            main {
                flex: 1;
                padding: 20px;
                display: flex;
                gap: 20px;
            }
            .menu, .order-panel {
                background: white;
                border-radius: 10px;
                padding: 15px;
                flex: 1;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }
            .menu-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
                gap: 10px;
            }
            .food-item {
                border: 1px solid #eee;
                padding: 10px;
                text-align: center;
                border-radius: 8px;
                transition: 0.2s;
            }
            .food-item:hover {
                box-shadow: 0 0 6px rgba(0,0,0,0.1);
            }
            .food-item img {
                width: 100%;
                height: 100px;
                object-fit: cover;
                border-radius: 8px;
            }
            .food-item button {
                background-color: #1E90FF;
                border: none;
                color: white;
                padding: 6px 10px;
                margin-top: 6px;
                border-radius: 6px;
                cursor: pointer;
            }
            .order-panel table {
                width: 100%;
                border-collapse: collapse;
            }
            .order-panel th, .order-panel td {
                padding: 8px;
                border-bottom: 1px solid #ddd;
            }
            .order-panel .total {
                text-align: right;
                margin-top: 10px;
                font-weight: bold;
            }
            footer {
                padding: 10px;
                text-align: right;
                background: #fff;
                border-top: 1px solid #ddd;
            }
            .btn-confirm {
                background: #1E90FF;
                border: none;
                color: white;
                padding: 10px 15px;
                border-radius: 6px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- Main content -->
            <main>
                <!-- Menu -->
                <div class="menu">
                    <h3>Thực đơn</h3>
                    <div class="menu-grid">
                        <c:forEach var="food" items="${foods}">
                            <div class="food-item">
                                <img src="${pageContext.request.contextPath}/images/${food.image}" alt="${food.name}">
                                <p><b>${food.name}</b></p>
                                <p>${food.price} đ</p>
                                <button onclick="addToOrder('${food.id}', '${food.name}', ${food.price})">Thêm</button>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Order panel -->
                <div class="order-panel">
                    <h3>Order hiện tại - Bàn ${param.tableId}</h3>
                    <table id="orderTable">
                        <tr><th>Món</th><th>SL</th><th>Giá</th><th>Tổng</th><th></th></tr>
                    </table>
                    <p class="total">Tổng cộng: <span id="totalPrice">0</span> đ</p>
                </div>
            </main>
        </div>

        <footer>
            <button class="btn-confirm" onclick="confirmOrder()">Xác nhận Order</button>
        </footer>

        <script>
            let order = [];

            function addToOrder(id, name, price) {
                let existing = order.find(item => item.id === id);
                if (existing) {
                    existing.qty++;
                } else {
                    order.push({id, name, price, qty: 1});
                }
                renderOrder();
            }

            function removeItem(id) {
                order = order.filter(item => item.id !== id);
                renderOrder();
            }

            function renderOrder() {
                let table = document.getElementById("orderTable");
                let rows = `<tr><th>Món</th><th>SL</th><th>Giá</th><th>Tổng</th><th></th></tr>`;
                let total = 0;
                order.forEach(item => {
                    let sub = item.price * item.qty;
                    total += sub;
                    rows += `
                      <tr>
                        <td>${item.name}</td>
                        <td>${item.qty}</td>
                        <td>${item.price}</td>
                        <td>${sub}</td>
                        <td><button onclick="removeItem('${item.id}')">X</button></td>
                      </tr>
                    `;
                });
                table.innerHTML = rows;
                document.getElementById("totalPrice").innerText = total;
            }

            function confirmOrder() {
                if (order.length === 0) {
                    alert("Vui lòng chọn ít nhất 1 món!");
                    return;
                }
                if (confirm("Xác nhận order này?")) {
                    fetch('${pageContext.request.contextPath}/waiter/OrderFood', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'},
                        body: JSON.stringify({
                            tableId: '${param.tableId}',
                            order: order
                        })
                    }).then(r => {
                        if (r.ok) {
                            alert("Đặt món thành công!");
                            order = [];
                            renderOrder();
                        } else {
                            alert("Lỗi khi gửi order!");
                        }
                    });
                }
            }
        </script>
    </body>
</html>
