<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <title>Chef Ingredient Management</title>
    <div style="text-align:right; margin-bottom:15px;">
        <a href="ingredients" 
           style="background:#0097e6; color:white; padding:8px 14px; border-radius:6px; text-decoration:none; font-weight:600;">
            ← Back to List
        </a>
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
        }
        .container {
            background: #fff;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            max-width: 950px;
            margin: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #0097e6;
            color: white;
        }
        tr:nth-child(even) {
            background: #f1f2f6;
        }

        input[type="number"] {
            width: 90px;
            padding: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
            text-align: right;
        }

        button {
            background: #44bd32;
            color: white;
            border: none;
            padding: 6px 10px;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background: #4cd137;
        }

        .alert {
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 6px;
            font-weight: 500;
            text-align: center;
        }
        .alert-success {
            background: #e6ffed;
            color: #006400;
            border-left: 5px solid #28a745;
        }
        .alert-warning {
            background: #fff3cd;
            color: #856404;
            border-left: 5px solid #ffc107;
        }
        .alert-error {
            background: #ffe6e6;
            color: #b30000;
            border-left: 5px solid #dc3545;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>🍳 Chef - Update Ingredients</h2>

        <!-- ✅ Alert messages -->
        <c:if test="${param.message == 'quantityUpdated'}">
            <div class="alert alert-success">✅ Quantity updated successfully!</div>
        </c:if>
        <c:if test="${param.message == 'invalidQuantity'}">
            <div class="alert alert-warning">⚠ Invalid quantity value!</div>
        </c:if>
        <c:if test="${param.message == 'error'}">
            <div class="alert alert-error">❌ Operation failed!</div>
        </c:if>

        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Unit</th>
                <th>Current Quantity</th>
                <th>Update Quantity</th>
            </tr>

            <c:forEach var="i" items="${list}">
                <tr>
                    <td>${i.ingredientId}</td>
                    <td>${i.name}</td>
                    <td>${i.description}</td>
                    <td>${i.unit}</td>
                    <td>${i.quantity}</td>
                    <td>
                        <form action="ingredients" method="post" style="display:flex; gap:5px; justify-content:center;">
                            <input type="hidden" name="action" value="updateQuantity">
                            <input type="hidden" name="id" value="${i.ingredientId}">
                            <input type="number" name="quantity" value="${i.quantity}" step="0.1" min="0" required>
                            <button type="submit">🔄 Save</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
