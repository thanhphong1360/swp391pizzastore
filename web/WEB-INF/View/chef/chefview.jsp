<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>Chef - Manage Ingredients</title>
    <!-- 🔙 Back to Home -->
    <div style="text-align:right; margin-bottom:15px;">
        <a href="Home" class="home-btn">🏠 Back to Home</a>
    </div>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background: #f5f6fa;
            margin: 30px;
        }
        h2 {
            color: #2f3640;
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }
        th {
            background-color: #44bd32;
            color: white;
        }
        tr:hover {
            background-color: #f0f8ff;
        }
        .quantity-input {
            width: 80px;
            padding: 5px;
            text-align: center;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .update-btn {
            background: #0097e6;
            color: white;
            padding: 6px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .update-btn:hover {
            background: #00a8ff;
        }
        .message {
            text-align: center;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 6px;
        }
        .success {
            background: #e7f9ee;
            color: #2e8b57;
        }
        .error {
            background: #fdecea;
            color: #d93025;
        }
    </style>
</head>
<body>

    <h2>🍳 Chef - Ingredient Management</h2>

    <!-- ✅ Message feedback -->
    <c:if test="${param.message == 'quantityUpdated'}">
        <div class="message success">✅ Quantity updated successfully!</div>
    </c:if>
    <c:if test="${param.message == 'invalidQuantity'}">
        <div class="message error">⚠ Quantity must be a positive number.</div>
    </c:if>
    <c:if test="${param.message == 'error'}">
        <div class="message error">❌ An error occurred while updating.</div>
    </c:if>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Ingredient Name</th>
                <th>Description</th>
                <th>Unit</th>
                <th>Quantity</th>
                <th>Last Updated</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="ing" items="${list}">
                <tr>
                    <td>${ing.ingredientId}</td>
                    <td>${ing.name}</td>
                    <td>${ing.description}</td>
                    <td>${ing.unit}</td>
                    <td>
                        <form action="chef-ingredients" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="updateQuantity">
                            <input type="hidden" name="id" value="${ing.ingredientId}">
                            <input type="number" step="0.01" name="quantity" value="${ing.quantity}" class="quantity-input">
                    </td>
                    <td>
                        <fmt:formatDate value="${ing.updatedAt}" pattern="yyyy-MM-dd HH:mm" />
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${ing.status}"><span style="color:green;">Active</span></c:when>
                            <c:otherwise><span style="color:red;">Inactive</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                            <button type="submit" class="update-btn">Update</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty list}">
                <tr><td colspan="8">No ingredients available.</td></tr>
            </c:if>
        </tbody>
    </table>

</body>
</html>
