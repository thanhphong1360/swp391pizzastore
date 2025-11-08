<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Order Food - Waiter</title>
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
                display: grid;
                grid-template-columns: 1fr 1fr;
                grid-template-rows: auto auto;
                gap: 15px;
                padding: 15px;
            }
            section {
                background: white;
                border-radius: 10px;
                padding: 15px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                overflow-y: auto;
                max-height: 450px;
            }
            h3 {
                color: #1E90FF;
                margin-bottom: 10px;
            }
            .filter-bar {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
            }
            .filter-bar input, .filter-bar select {
                padding: 5px;
                border-radius: 5px;
                border: 1px solid #ccc;
            }
            .menu-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(130px, 1fr));
                gap: 10px;
            }
            .food-item {
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 8px;
                text-align: center;
            }
            .food-item button {
                background-color: #1E90FF;
                color: white;
                border: none;
                padding: 6px 10px;
                border-radius: 6px;
                cursor: pointer;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                border-bottom: 1px solid #ddd;
                padding: 6px;
                text-align: center;
            }
            button.action {
                background-color: #1E90FF;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 4px 8px;
                cursor: pointer;
            }
            textarea {
                width: 100%;
                resize: none;
                border-radius: 5px;
                border: 1px solid #ccc;
                padding: 4px;
            }
            .readonly {
                background-color: #f4f4f4;
            }
        </style>
    </head>
    <body>

        <header>
            <h2>Order - Bàn ${tableNumber}</h2>
            <form action="${pageContext.request.contextPath}/waiter/Table" method="GET">
                <input type="hidden" name="action" value="open">
                <button type="submit" class="action">← Quay lại danh sách bàn</button>
            </form>
        </header>

        <div class="container">

            <!-- MENU MÓN ĂN -->
            <section>
                <h3>Thực đơn</h3>
                <form id="filterForm" method="GET" action="${pageContext.request.contextPath}/waiter/Order" class="filter-bar">
                    <input type="hidden" name="tableId" value="${tableId}">
                    <input type="hidden" name="action" value="order">

                    <!-- Các input draft tạm sẽ được thêm bằng JS trước khi submit -->
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
                            <button type="button" onclick="addToOrder(${f.foodId}, '${f.name}', ${f.price})">Thêm</button>
                        </div>
                    </c:forEach>
                </div>
            </section>

            <!-- DANH SÁCH MÓN ĐANG CHỌN -->
            <section>
                <h3>Đang chọn (chưa gửi)</h3>
                <table id="draftTable">
                    <tr><th>Món</th><th>SL</th><th>Ghi chú</th><th>Tổng</th><th></th></tr>
                            <c:forEach var="d" items="${draft}">
                        <tr>
                            <td>${d.foodName}</td>
                            <td>${d.quantity}</td>
                            <td>${d.note}</td>
                            <td>${d.price}</td>
                        </tr>
                    </c:forEach>
                </table>
                <p><b>Tổng: <span id="draftTotal">0</span> đ</b></p>
                <button class="action" onclick="sendDraft()">Gửi order mới</button>
            </section>

            <!-- Các section pending / done giữ nguyên -->
            <section>
                <h3>Đang chờ duyệt (Pending)</h3>
                <!-- ... -->
            </section>

            <section>
                <h3>Món đã gửi</h3>
                <!-- ... -->
            </section>
        </div>

        <script>
            let draft = [];

            <c:if test="${not empty draft}">
            draft = [
                <c:forEach var="d" items="${draft}" varStatus="st">
            {id:${d.foodId}, name:'${d.foodName}', price:${d.price}, qty:${d.quantity}, note:'${d.note}'}
                    <c:if test="${!st.last}">,</c:if>
                </c:forEach>
            ];
            renderDraft();
            </c:if>

            function addToOrder(id, name, price) {
                let item = draft.find(f => f.id === id);
                if (item)
                    item.qty++;
                else
                    draft.push({id, name, price, qty: 1, note: ""});
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

            function changeQty(i, delta) {
                draft[i].qty += delta;
                if (draft[i].qty <= 0)
                    draft.splice(i, 1);
                renderDraft();
            }

            function removeDraft(i) {
                draft.splice(i, 1);
                renderDraft();
            }
            function updateNote(i, note) {
                draft[i].note = note;
            }

            // Gửi draft kèm theo form tìm kiếm
            function submitWithDraft() {
                const container = document.getElementById("draftInputs");
                container.innerHTML = "";
                draft.forEach(it => {
                    if (!it.id)
                        return;

                    const idInput = document.createElement("input");
                    idInput.type = "hidden";
                    idInput.name = "foodId";
                    idInput.value = it.id;
                    container.appendChild(idInput);

                    const qtyInput = document.createElement("input");
                    qtyInput.type = "hidden";
                    qtyInput.name = "quantity";
                    qtyInput.value = it.qty;
                    container.appendChild(qtyInput);

                    const noteInput = document.createElement("input");
                    noteInput.type = "hidden";
                    noteInput.name = "note";
                    noteInput.value = it.note || '';
                    container.appendChild(noteInput);
                });


                document.getElementById("filterForm").submit();
            }

            // Gửi order thực tế
            function sendDraft() {
                if (draft.length === 0) {
                    alert("Vui lòng chọn ít nhất 1 món!");
                    return;
                }
                const form = document.createElement("form");
                form.method = "POST";
                form.action = "${pageContext.request.contextPath}/waiter/Order";
                form.innerHTML += `<input type="hidden" name="action" value="sendDraft">
                                   <input type="hidden" name="tableId" value="${tableId}">`;
                draft.forEach(it => {
                    form.innerHTML += `<input type="hidden" name="foodId" value="${it.id}">
                                       <input type="hidden" name="quantity" value="${it.qty}">
                                       <input type="hidden" name="note" value="${it.note}">`;
                });
                document.body.appendChild(form);
                form.submit();
                renderDraft();
            }
        </script>

    </body>
</html>
