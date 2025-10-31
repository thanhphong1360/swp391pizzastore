<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <title>User Management</title>
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

        .container {
            background: #fff;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            max-width: 1000px;
            margin: auto;
            overflow-x: auto; /* ✅ Thêm để bảng không bị đè */
        }

        a.add-btn {
            background: #44bd32;
            color: white;
            padding: 10px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            margin-bottom: 20px;
            display: inline-block;
            transition: 0.3s;
        }

        a.add-btn:hover {
            background: #4cd137;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px; /* ✅ Giữ cột không bị bó hẹp */
        }

        th, td {
            padding: 12px 10px;
            border-bottom: 1px solid #ddd;
            text-align: center;
            white-space: nowrap;
        }

        th {
            background: #0097e6;
            color: white;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background: #f1f2f6;
        }

        a.action {
            padding: 6px 12px;
            border-radius: 5px;
            text-decoration: none;
            color: white;
            font-size: 13px;
            margin-right: 5px;
            transition: 0.3s;
        }

        .edit {
            background: #00a8ff;
        }
        .toggle {
            background: #e84118;
        }
        .restore {
            background: #44bd32;
        }

        .edit:hover {
            background: #0097e6;
        }
        .toggle:hover {
            background: #c23616;
        }
        .restore:hover {
            background: #4cd137;
        }

        .alert {
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 6px;
            font-weight: 500;
            text-align: center;
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


        .alert-success {
            background: #e6ffed;
            color: #006400;
            border-left: 5px solid #28a745;
        }
        .alert-info {
            background: #e8f4fd;
            color: #004085;
            border-left: 5px solid #007bff;
        }
        .alert-warning {
            background: #fff3cd;
            color: #856404;
            border-left: 5px solid #ffc107;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>User Management</h2>

        <!-- ✅ Alert messages -->
        <c:if test="${param.message == 'added'}">
            <div class="alert alert-success">✅ User added successfully!</div>
        </c:if>
        <c:if test="${param.message == 'updated'}">
            <div class="alert alert-info">✏ User updated successfully!</div>
        </c:if>
        <c:if test="${param.message == 'deactivated'}">
            <div class="alert alert-warning">🗑 User deactivated successfully!</div>
        </c:if>
        <c:if test="${param.message == 'restored'}">
            <div class="alert alert-success">♻ User restored successfully!</div>
        </c:if>

        <a href="users?action=add" class="add-btn">➕ Add User</a>

        <div style="overflow-x:auto;">
            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Created At</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                <c:forEach var="u" items="${list}">
                    <tr>
                        <td>${u.userId}</td>
                        <td>${u.name}</td>
                        <td>${u.email}</td>
                        <td>${u.roleName}</td>
                        <td>${u.createdAt}</td>
                        <td>
                            <c:choose>
                                <c:when test="${u.status}">
                                    <span style="color:green; font-weight:bold;">Active</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:red; font-weight:bold;">Inactive</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${u.status}">
                                    <a href="users?action=edit&id=${u.userId}" class="action edit">✏ Edit</a>
                                    <a href="users?action=toggle&id=${u.userId}"
                                       class="action toggle"
                                       onclick="return confirm('Deactivate this user?');">
                                        📴 Deactivate
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="users?action=toggle&id=${u.userId}"
                                       class="action restore"
                                       onclick="return confirm('Restore this user?');">
                                        ♻ Restore
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</body>
</html>
