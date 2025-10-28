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
        h2 { color: #2f3640; }
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
        a.add-btn:hover { background: #4cd137; }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td { padding: 10px; text-align: left; }
        th { background: #0097e6; color: white; }
        tr:nth-child(even) { background: #f1f2f6; }

        a.action {
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
            color: white;
            font-size: 13px;
            margin-right: 5px;
        }
        .edit { background: #00a8ff; }
        .delete { background: #e84118; }
        .restore { background: #44bd32; }
        .edit:hover { background: #0097e6; }
        .delete:hover { background: #c23616; }
        .restore:hover { background: #4cd137; }

        .alert {
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 6px;
            font-weight: 500;
        }
        .alert-success { background: #e6ffed; color: #006400; border-left: 5px solid #28a745; }
        .alert-info { background: #e8f4fd; color: #004085; border-left: 5px solid #007bff; }
        .alert-warning { background: #fff3cd; color: #856404; border-left: 5px solid #ffc107; }
    </style>
</head>
<body>
<div class="container">
    <h2>Ingredient Management</h2>

    <!-- ✅ Alert messages -->
    <c:if test="${param.message == 'added'}">
        <div class="alert alert-success">✅ Ingredient added successfully!</div>
    </c:if>
    <c:if test="${param.message == 'updated'}">
        <div class="alert alert-info">✏ Ingredient updated successfully!</div>
    </c:if>
    <c:if test="${param.message == 'deactivated'}">
        <div class="alert alert-warning">🗑 Ingredient deactivated successfully!</div>
    </c:if>
    <c:if test="${param.message == 'restored'}">
        <div class="alert alert-success">♻ Ingredient restored successfully!</div>
    </c:if>

    <a href="ingredients?action=add" class="add-btn">➕ Add Ingredient</a>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Unit</th>
            <th>Quantity</th>
            <th>Updated At</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="i" items="${list}">
            <tr>
                <td>${i.ingredientId}</td>
                <td>${i.name}</td>
                <td>${i.description}</td>
                <td>${i.unit}</td>
                <td>${i.quantity}</td>
                <td>${i.updatedAt}</td>
                <td>
                    <c:choose>
                        <c:when test="${i.status}">
                            <span style="color:green; font-weight:bold;">Active</span>
                        </c:when>
                        <c:otherwise>
                            <span style="color:red; font-weight:bold;">Inactive</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${i.status}">
                            <a href="ingredients?action=edit&id=${i.ingredientId}" class="action edit">✏ Edit</a>
                            <a href="ingredients?action=toggle&id=${i.ingredientId}" 
                               class="action delete"
                               onclick="return confirm('Are you sure you want to deactivate this ingredient?');">
                                🗑 Deactivate
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="ingredients?action=toggle&id=${i.ingredientId}" 
                               class="action restore"
                               onclick="return confirm('Do you want to restore this ingredient?');">
                                ♻ Restore
                            </a>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
