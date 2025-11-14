<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Food - Pizza House</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #fff5f5;
            margin: 0;
            color: #333;
        }

        header {
            background-color: #e63946;
            color: white;
            padding: 15px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 3px solid #c92a35;
        }

        .action {
            background-color: white;
            color: #e63946;
            border: 2px solid #e63946;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.2s;
            font-weight: 600;
        }

        .action:hover {
            background-color: #e63946;
            color: white;
        }

        .container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            padding: 25px;
        }

        section {
            background: white;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.08);
            overflow-y: auto;
            max-height: 500px;
        }

        h3 {
            color: #e63946;
            margin-bottom: 10px;
        }

        .filter-bar {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            gap: 8px;
        }

        .filter-bar input, .filter-bar select {
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(130px, 1fr));
            gap: 12px;
        }

        .food-item {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 10px;
            text-align: center;
            transition: 0.2s;
        }

        .food-item:hover {
            box-shadow: 0 0 8px rgba(230, 57, 70, 0.3);
        }

        .food-item button {
            background-color: #e63946;
            color: white;
            border: none;
            padding: 6px 10px;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.2s;
        }

        .food-item button:hover {
            background-color: #c92a35;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 10px;
        }

        th, td {
            border-bottom: 1px solid #eee;
            padding: 6px;
            text-align: center;
        }

        textarea {
            width: 100%;
            resize: none;
            border-radius: 5px;
            border: 1px solid #ccc;
            padding: 4px;
        }

        #draftTotal {
            color: #e63946;
            font-weight: 600;
        }
    </style>
</head>

<body>

<header>
    <h2>🍕 Order - Bàn ${tableNumber}</h2>
    <form action="${pageContext.request.contextPath}/waiter/Table" method="GET">
        <input type="hidden" name="action" value="open">
        <button type="submit" class="action">← Về danh sách bàn</button>
    </form>
</header>

<div class="container">

    <!-- DANH SÁCH MÓN ĂN -->
    <section>
        <h3>Thực đơn</h3>
        <form id="filterForm" method="GET" action="${pageContext.request.contextPath}/waiter/Order" class="filter-bar">
            <input type="hidden" name="tableId" value="${tableId}">
            <input type="hidden" name="action" value="order">
            <div id="draftInputs"></div>

            <select name="categoryId" onchange="submitWithDraft()">
                <option value="">-- Tất cả loại món --</option>
                <c:forEach var="c" items="${categoryList}">
                    <option value="${c.categoryId}" ${param.categoryId == c.categoryId ? 'selected' : ''}>${c.name}</option>
                </c:forEach>
            </select>

            <input type="text" name="search" placeholder="Tìm món..." value="${param.search}">
            <button type="button" class="action" onclick="submitWithDraft()">Tìm</button>
        </form>

        <div class="menu-grid">
            <c:forEach var="f" items="${foodList}">
                <div class="food-item">
                    <p><b>${f.name}</b></p>
                    <p>${f.price} đ</p>
                    <button type="button" onclick="addToOrder(${f.foodId}, '${fn:escapeXml(f.name)}', ${f.price})">Thêm</button>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- DRAFT -->
    <section>
        <h3>Đang chọn (chưa gửi)</h3>
        <table id="draftTable">
            <tr><th>Món</th><th>SL</th><th>Ghi chú</th><th>Tổng</th><th></th></tr>
        </table>
        <p><b>Tổng: <span id="draftTotal">0</span> đ</b></p>
        <button class="action" onclick="sendDraft()">✅ Gửi order</button>
    </section>

    <!-- PENDING -->
    <section>
        <h3>Đang chờ duyệt</h3>
        <form id="pendingForm" action="${pageContext.request.contextPath}/waiter/Order" method="POST">
            <input type="hidden" name="action" value="updatePending">
            <input type="hidden" name="tableId" value="${tableId}">
            <table>
                <tr><th>Món</th><th>SL</th><th>Tổng</th><th></th></tr>
                <c:forEach var="of" items="${pendingFoods}">
                    <tr>
                        <td>${of.food.name}</td>
                        <td><input type="number" name="quantity_${of.orderFoodId}" value="${of.quantity}" min="1" style="width:50px;"></td>
                        <td>${of.price * of.quantity}</td>
                        <td><input type="checkbox" name="remove_${of.orderFoodId}"> Xóa</td>
                    </tr>
                </c:forEach>
            </table>
            <c:if test="${not empty pendingFoods}">
                <button type="submit" class="action">Cập nhật</button>
            </c:if>
        </form>
    </section>

    <!-- DONE -->
    <section>
        <h3>Món đã hoàn thành</h3>
        <table>
            <tr><th>Món</th><th>SL</th><th>Trạng thái</th><th>Ghi chú</th></tr>
            <c:forEach var="of" items="${doneFoods}">
                <tr>
                    <td>${of.food.name}</td>
                    <td>${of.quantity}</td>
                    <td>${of.status}</td>
                    <td>${of.note}</td>
                </tr>
            </c:forEach>
        </table>
    </section>

</div>

<script>
    let draft = [];

    function addToOrder(id, name, price) {
        const existing = draft.find(f => f.id === id);
        if (existing) existing.qty++;
        else draft.push({id, name, price, qty: 1, note: ""});
        renderDraft();
    }

    function renderDraft() {
                const table = document.getElementById("draftTable");
                let html = "<tr><th>Món</th><th>SL</th><th>Ghi chú</th><th>Tổng</th><th></th></tr>";
                let total = 0;
                draft.forEach((it, i) => {
                    const sub = it.price * it.qty;
                    total += sub;
                    html += "<tr>" + "<td>" + it.name + "</td>" + "<td>" + "<button onclick='changeQty(" + i + ", -1)'>−</button>" + "<span>" + it.qty + "</span>" + "<button onclick='changeQty(" + i + ", 1)'>+</button>" + "</td>" + "<td><textarea maxlength='100' oninput='updateNote(" + i + ", this.value)' rows='2'>" + (it.note || "") + "</textarea></td>" + "<td>" + sub + "</td>" + "<td><button onclick='removeDraft(" + i + ")'>X</button></td>" + "</tr>";
                });
                table.innerHTML = html;
                document.getElementById("draftTotal").innerText = total;
                console.log("DRAFT :", draft);
            }

    function changeQty(i, d) {
        draft[i].qty += d;
        if (draft[i].qty <= 0) draft.splice(i, 1);
        renderDraft();
    }

    function removeDraft(i) {
        draft.splice(i, 1);
        renderDraft();
    }

    function updateNote(i, val) {
        draft[i].note = val;
    }

    function submitWithDraft() {
        const form = document.getElementById("filterForm");
        const container = document.getElementById("draftInputs");
        container.innerHTML = "";
        draft.forEach(it => {
            ["foodId", "quantity", "note"].forEach(k => {
                const input = document.createElement("input");
                input.type = "hidden";
                input.name = k;
                input.value = (k === "foodId") ? it.id :
                              (k === "quantity") ? it.qty : it.note;
                container.appendChild(input);
            });
        });
        form.submit();
    }

    function sendDraft() {
        if (draft.length === 0) {
            alert("Vui lòng chọn ít nhất một món!");
            return;
        }
        const form = document.createElement("form");
        form.method = "POST";
        form.action = "${pageContext.request.contextPath}/waiter/Order";

        const addInput = (name, value) => {
            const input = document.createElement("input");
            input.type = "hidden";
            input.name = name;
            input.value = value;
            form.appendChild(input);
        };

        addInput("action", "sendOrder");
        addInput("tableId", "${tableId}");

        draft.forEach(it => {
            addInput("foodId", it.id);
            addInput("quantity", it.qty);
            addInput("note", it.note);
        });

        document.body.appendChild(form);
        form.submit();
    }
</script>
</body>
</html>
