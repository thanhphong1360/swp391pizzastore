<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Audit Log</title>
    <style>
        body { font-family: "Segoe UI", sans-serif; background: #f5f6fa; margin: 30px; }
        .container { background: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #2f3640; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 10px; text-align: left; }
        th { background: #0097e6; color: white; }
        tr:nth-child(even) { background: #f1f2f6; }
        .back-btn {
            display: inline-block; margin-bottom: 10px;
            background: #273c75; color: white; padding: 8px 14px;
            border-radius: 6px; text-decoration: none;
        }
        .back-btn:hover { background: #40739e; }
    </style>
</head>
<body>
<div class="container">
    <h2>📜 Audit Log</h2>
    <a href="Home" class="back-btn">🏠 Back to Home</a>

    <table>
        <tr>
            <th>ID</th>
            <th>User</th>
            <th>Action</th>
            <th>Table</th>
            <th>Target ID</th>
            <th>Description</th>
            <th>Time</th>
        </tr>
        <c:forEach var="log" items="${logs}">
            <tr>
                <td>${log.logId}</td>
                <td>${log.userName}</td>
                <td>${log.actionType}</td>
                <td>${log.targetTable}</td>
                <td>${log.targetId}</td>
                <td>${log.description}</td>
                <td>${log.createdAt}</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
