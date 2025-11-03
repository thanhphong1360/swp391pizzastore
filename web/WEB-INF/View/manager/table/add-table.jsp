<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add New Table</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <script>
            function validateForm() {
                let name = document.forms["addTableForm"]["table_name"].value.trim();
                let cap = document.forms["addTableForm"]["capacity"].value.trim();

                if (name === "" || cap === "") {
                    alert("Please fill out all required fields.");
                    return false;
                }
                if (isNaN(cap) || cap <= 0) {
                    alert("Capacity must be a positive number.");
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="mb-3">Add New Table</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form name="addTableForm" method="post"
                  action="${pageContext.request.contextPath}/manager/table/add"
                  onsubmit="return validateForm()">

                <div class="form-group mb-3">
                    <label>Table Name <span class="text-danger">*</span></label>
                    <!-- SỬA: Giữ giá trị khi lỗi -->
                    <input type="text" name="table_name" class="form-control"
                           value="${not empty param.table_name ? param.table_name : ''}">
                </div>

                <div class="form-group mb-3">
                    <label>Capacity <span class="text-danger">*</span></label>
                    <input type="number" name="capacity" class="form-control" min="1"
                           value="${not empty param.capacity ? param.capacity : ''}">
                </div>

                <div class="form-group mb-3">
                    <label>Status</label>
                    <select name="status" class="form-control">
                        <option value="Available" ${param.status == 'Available' ? 'selected' : ''}>Available</option>
                        <option value="Occupied" ${param.status == 'Occupied' ? 'selected' : ''}>Occupied</option>
                        <option value="Reserved" ${param.status == 'Reserved' ? 'selected' : ''}>Reserved</option>
                    </select>
                </div>

                <div class="form-group mb-3">
                    <label>Location</label>
                    <input type="text" name="location" class="form-control"
                           value="${not empty param.location ? param.location : ''}">
                </div>

                <button type="submit" class="btn btn-primary">Add Table</button>
                <a href="${pageContext.request.contextPath}/manager/table/list" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
    </body>
</html>
