<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Table</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <script>
            function validateEditForm() {
                let name = document.forms["editTableForm"]["table_name"].value.trim();
                let cap = document.forms["editTableForm"]["capacity"].value.trim();

                if (name === "" || cap === "") {
                    alert("Please fill out all required fields.");
                    return false;
                }
                if (isNaN(cap) || cap <= 0) {
                    alert("Capacity must be a positive number.");
                    return false;
                }
                return confirm("Are you sure you want to update this table?");
            }
        </script>
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="mb-3">Edit Table</h2>

            <form name="editTableForm" method="post"
                  action="${pageContext.request.contextPath}/manager/table/edit"
                  onsubmit="return validateEditForm()">

                <input type="hidden" name="table_id" value="${table.tableId}">

                <div class="form-group mb-3">
                    <label>Table Name <span class="text-danger">*</span></label>
                    <input type="text" name="table_name" class="form-control"
                           value="${table.tableName}">
                </div>

                <div class="form-group mb-3">
                    <label>Capacity <span class="text-danger">*</span></label>
                    <input type="number" name="capacity" class="form-control"
                           value="${table.capacity}" min="1">
                </div>

                <div class="form-group mb-3">
                    <label>Status</label>
                    <select name="status" class="form-control">
                        <option value="Available" ${table.status == 'Available' ? 'selected' : ''}>Available</option>
                        <option value="Occupied" ${table.status == 'Occupied' ? 'selected' : ''}>Occupied</option>
                        <option value="Reserved" ${table.status == 'Reserved' ? 'selected' : ''}>Reserved</option>
                    </select>
                </div>

                <div class="form-group mb-3">
                    <label>Location</label>
                    <input type="text" name="location" class="form-control"
                           value="${table.location}">
                </div>

                <button type="submit" class="btn btn-primary">Update</button>
                <a href="${pageContext.request.contextPath}/manager/table/list" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
    </body>
</html>
