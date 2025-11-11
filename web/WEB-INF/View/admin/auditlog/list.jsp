<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Audit Log | Pizza House Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #fff8f3;
            margin: 0;
            padding: 30px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .page-header h2 {
            color: #e63946;
            font-weight: 600;
            margin: 0;
        }

        .home-btn {
            background-color: #e63946;
            color: white;
            padding: 10px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: 0.3s;
        }

        .home-btn:hover {
            background-color: #c72e3b;
            text-decoration: none;
            color: #fff;
        }

        .search-box {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 15px;
            gap: 10px;
        }

        .search-box input[type="text"] {
            border-radius: 8px;
            border: 1px solid #ccc;
            padding: 8px 12px;
            width: 250px;
        }

        .search-box button {
            background-color: #e63946;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 8px 14px;
            transition: 0.3s;
        }

        .search-box button:hover {
            background-color: #c72e3b;
        }

        .table-container {
            background: #fff;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 0;
        }

        th {
            background-color: #e63946;
            color: white;
            font-weight: 500;
            padding: 12px;
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background-color: #fff1ee;
        }

        .no-logs {
            text-align: center;
            padding: 15px;
            color: #999;
            font-style: italic;
        }
    </style>
</head>

<body>
    <div class="page-header">
        <h2>Audit Log</h2>
        <a href="${pageContext.request.contextPath}/Home" class="home-btn"> Back to Dashboard</a>
    </div>

    <div class="search-box">
        <form action="auditlog" method="get" class="d-flex">
            <input type="text" name="search" placeholder="Search by user or description..."
                   value="${search != null ? search : ''}">
            <button type="submit">Search</button>
        </form>
        <a href="auditlog" class="btn btn-outline-secondary" style="border-radius:8px;">Clear</a>
    </div>

    <div class="table-container">
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
                    <tr><td colspan="7" class="no-logs">No logs found.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
