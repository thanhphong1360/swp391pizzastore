<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Table Management</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    </head>
    <body>
        <main class="container mt-5">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2>Table Management</h2>

                <!-- SỬA: Dùng Servlet thay vì link trực tiếp JSP -->
                <a href="${pageContext.request.contextPath}/manager/table/add" class="btn btn-success">
                    + Add New Table
                </a>
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <c:if test="${empty tables}">
                <div class="alert alert-warning">No tables found.</div>
            </c:if>

            <c:if test="${not empty tables}">
                <table class="table table-bordered table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Table Name</th>
                            <th>Capacity</th>
                            <th>Status</th>
                            <th>Location</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="t" items="${tables}">
                            <tr>
                                <td>${t.tableId}</td>
                                <td>${t.tableName}</td>
                                <td>${t.capacity}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${t.status eq 'Available'}">
                                            <span class="badge bg-success">Available</span>
                                        </c:when>
                                        <c:when test="${t.status eq 'Occupied'}">
                                            <span class="badge bg-danger">Occupied</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${t.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${t.location}</td>
                                <td>
                                    <!-- SỬA: Gọi Edit qua Servlet -->
                                    <form action="${pageContext.request.contextPath}/manager/table/edit"
                                          method="get"
                                          style="display:inline;">
                                        <input type="hidden" name="id" value="${t.tableId}">
                                        <button type="submit" class="btn btn-sm btn-primary">Edit</button>
                                    </form>

                                    <!-- SỬA: Gọi confirm delete -->
                                    <form action="${pageContext.request.contextPath}/manager/table/delete"
                                          method="post"
                                          style="display:inline;"
                                          onsubmit="return confirm('Are you sure you want to delete table `${t.tableName}`?');">
                                        <input type="hidden" name="table_id" value="${t.tableId}">
                                        <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

        </main>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>