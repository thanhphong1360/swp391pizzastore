<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Ingredient Management</title>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background: #f5f6fa;
            margin: 30px;
        }
        h2 {
            color: #2f3640;
        }
        .container {
            background: #fff;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        a.add-btn {
            background: #44bd32;
            color: white;
            padding: 8px 14px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
        }
        a.add-btn:hover {
            background: #4cd137;
        } 
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background: #0097e6;
            color: white;
        }
        tr:nth-child(even) {
            background: #f1f2f6;
        }
        a.action {
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
            color: white;
            font-size: 13px;
        }
        .edit { background: #00a8ff; }
        .delete { background: #e84118; }
        .edit:hover { background: #0097e6; }
        .delete:hover { background: #c23616; }
    </style>
</head>
<body>
<div class="container">
    <h2>Ingredient Management</h2>
    <a href="ingredients?action=add" class="add-btn">➕ Add Ingredient</a>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Unit</th>
            <th>Quantity</th>
            <th>Updated At</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="i" items="${list}">
            <tr>
                <td>${i.ingredientId}</td>
                <td>${i.name}</td>
                <td>${i.description}</td>
                <td>${i.unit}</td>
                <td>${i.quantity}</td>0
                <td>${i.updatedAt}</td>
                <td>
                    <a href="ingredients?action=edit&id=${i.ingredientId}" class="action edit">✏ Edit</a>
                    <a href="ingredients?action=delete&id=${i.ingredientId}" class="action delete"
                       onclick="return confirm('Are you sure to delete this item?')">🗑 Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
