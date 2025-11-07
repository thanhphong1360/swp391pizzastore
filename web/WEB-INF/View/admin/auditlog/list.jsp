<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Audit Log</title>
     <a href="${pageContext.request.contextPath}/Home" class="home-btn"> Back to Home</a>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background: #f5f6fa;
            margin: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        th {
            background: #44bd32;
            color: white;
        }
        .search-box {
            text-align: right;
            margin-bottom: 15px;
        }
        input[type=text] {
            padding: 6px;
            width: 200px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            padding: 6px 10px;
            background: #0097e6;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background: #00a8ff;
        }
        .home-btn {
            background: #718093;
            color: white;
            padding: 8px 14px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            display: inline-block;
        }
        .home-btn:hover {
            background: #9c9c9c;
        }
    </style>
</head>
<body>

<h2> Audit Log</h2>

<div class="search-box">
    <form action="auditlog" method="get">
        <input type="text" name="search" placeholder="Search by name or description..."
               value="${search != null ? search : ''}">
        <button type="submit">Search</button>
        <a href="auditlog" style="margin-left:10px; text-decoration:none;">Clear</a>
    </form>
</div>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>User</th>
            <th>Action</th>
            <th>Table</th>
            <th>Target ID</th>
            <th>Description</th>
            <th>Time</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="log" items="${logs}">
            <tr>
                <td>${log.logId}</td>
                <td>${log.userName}</td>
                <td>${log.actionType}</td>
                <td>${log.targetTable}</td>
                <td>${log.targetId}</td>
                <td>${log.description}</td>
                <td><fmt:formatDate value="${log.createdAt}" pattern="yyyy-MM-dd HH:mm" /></td>
            </tr>
        </c:forEach>
        <c:if test="${empty logs}">
            <tr><td colspan="7" style="text-align:center;">No logs found.</td></tr>
        </c:if>
    </tbody>
</table>

</body>
</html>
