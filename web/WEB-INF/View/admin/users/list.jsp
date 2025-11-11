<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Management | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #fff8f3;
        margin: 0;
        padding: 40px 80px;
    }
    h2 {
        color: #e63946;
        font-weight: 600;
        font-size: 28px;
    }

    /* Button styles */
    .btn-custom {
        border-radius: 10px;
        font-weight: 500;
        padding: 10px 18px;
        text-decoration: none;
        color: white;
        transition: 0.3s;
        border: none;
    }
    .btn-dashboard {
        background: #718093;
    }
    .btn-dashboard:hover {
        background: #909fad;
    }
    .btn-add {
        background: #e63946;
        display: inline-block;
        margin-bottom: 25px; /* 🔹 thêm khoảng cách dưới nút */
        margin-top: 5px;     /* 🔹 nhẹ trên cho cân đối */
    }
    .btn-add:hover {
        background: #c72e3b;
    }

    /* Layout header */
    .header-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
    }

    /* Table styling */
    table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        background: white;
        border-radius: 15px;
        box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
        overflow: hidden;
    }
    thead th {
        background-color: #e63946;
        color: white;
        padding: 14px;
        text-align: center;
        font-weight: 500;
    }
    tbody td {
        padding: 12px;
        text-align: center;
        vertical-align: middle;
        color: #333;
        border-bottom: 1px solid #f0f0f0;
    }
    tbody tr:last-child td {
        border-bottom: none;
    }
    tbody tr:hover {
        background-color: #fff1ee;
    }

    /* Status */
    .status-active {
        color: #2ecc71;
        font-weight: 600;
    }
    .status-inactive {
        color: #e74c3c;
        font-weight: 600;
    }

    /* Actions */
    .action {
        padding: 6px 12px;
        border-radius: 6px;
        color: white;
        text-decoration: none;
        font-size: 14px;
        margin: 0 3px;
        display: inline-block;
        transition: 0.2s;
    }
    .edit { background: #00a8ff; }
    .edit:hover { background: #0097e6; }
    .toggle { background: #e84118; }
    .toggle:hover { background: #c23616; }
    .restore { background: #44bd32; }
    .restore:hover { background: #4cd137; }

    @media (max-width: 768px) {
        body { padding: 20px; }
        table { font-size: 14px; }
        .btn-custom { padding: 8px 14px; font-size: 14px; }
    }
</style>
</head>
<body>

<div class="header-bar">
    <h2>User Management</h2>
    <a href="${pageContext.request.contextPath}/Home" class="btn-custom btn-dashboard">🏠 Back to Dashboard</a>
</div>

<!-- 🔹 Nút Add User được tách ra với khoảng cách rõ ràng -->
<a href="${pageContext.request.contextPath}/manager/users?action=add" class="btn-custom btn-add">➕ Add User</a>

<div style="overflow-x:auto;">
    <table class="table align-middle">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Created At</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${list}">
                <tr>
                    <td>${u.userId}</td>
                    <td>${u.name}</td>
                    <td>${u.email}</td>
                    <td>${u.roleName}</td>
                    <td>${u.createdAt}</td>
                    <td>
                        <span class="${u.status ? 'status-active' : 'status-inactive'}">
                            ${u.status ? 'Active' : 'Inactive'}
                        </span>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${u.status}">
                                <a href="${pageContext.request.contextPath}/manager/users?action=edit&id=${u.userId}" class="action edit">✏ Edit</a>
                                <a href="${pageContext.request.contextPath}/manager/users?action=toggle&id=${u.userId}" class="action toggle" onclick="return confirm('Deactivate this user?');">📴 Deactivate</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/manager/users?action=toggle&id=${u.userId}" class="action restore" onclick="return confirm('Restore this user?');">♻ Restore</a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
                <c:if test="${not empty param.message}">
    <div class="alert alert-dismissible fade show
         <c:choose>
             <c:when test='${param.message eq "added" or param.message eq "restored" or param.message eq "updated"}'>alert-success</c:when>
             <c:when test='${param.message eq "deactivated"}'>alert-warning</c:when>
             <c:otherwise>alert-danger</c:otherwise>
         </c:choose>'
         role="alert"
         style="font-weight:500;">
         
        <c:choose>
            <c:when test="${param.message eq 'added'}">✅ User added successfully!</c:when>
            <c:when test="${param.message eq 'updated'}">✅ User updated successfully!</c:when>
            <c:when test="${param.message eq 'deactivated'}">⚠️ User deactivated!</c:when>
            <c:when test="${param.message eq 'restored'}">♻ User restored successfully!</c:when>
            <c:when test="${param.message eq 'error'}">❌ An error occurred. Please try again.</c:when>
        </c:choose>

        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>
        </tbody>
    </table>
</div>

</body>
</html>
