<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Edit User</title>
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                background: #f5f6fa;
                margin: 30px;
            }
            .container {
                background: #fff;
                border-radius: 12px;
                padding: 25px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                width: 400px;
                margin: auto;
            }
            h2 {
                color: #2f3640;
                text-align: center;
            }
            input, select {
                width: 100%;
                padding: 8px;
                margin: 8px 0;
                border-radius: 6px;
                border: 1px solid #ccc;
            }
            button {
                background: #00a8ff;
                color: white;
                padding: 8px 12px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
            }
            button:hover {
                background: #0097e6;
            }
            .error {
                color: red;
                font-weight: 500;
                margin-bottom: 10px;
            }
            a {
                text-decoration: none;
                color: #0097e6;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Edit User</h2>

            <c:if test="${not empty errorMessage}">
                <div style="background:#ffe6e6; color:#b30000; padding:10px; border-radius:6px; margin-bottom:10px;">
                    ${errorMessage}
                </div>
            </c:if>


            <form action="users" method="post">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="userId" value="${user.userId}">

                <label>Name:</label>
                <input type="text" name="name" value="${user.name}" required maxlength="50">

                <label>Email:</label>
                <input type="email" name="email" value="${user.email}" required maxlength="100">

                <label>Password:</label>
                <input type="password" name="password" value="${user.password}" required minlength="4">

                <label>Role ID:</label>
                <select name="roleId">
                    <option value="1" ${user.roleId == 1 ? 'selected' : ''}>Manager</option>
                    <option value="2" ${user.roleId == 2 ? 'selected' : ''}>Cashier</option>
                    <option value="3" ${user.roleId == 3 ? 'selected' : ''}>Chef</option>
                    <option value="4" ${user.roleId == 4 ? 'selected' : ''}>Waiter</option>
                    <option value="5" ${user.roleId == 5 ? 'selected' : ''}>DeliveryStaff</option>
                    <option value="6" ${user.roleId == 6 ? 'selected' : ''}>Customer</option>

                </select>

                <button type="submit">✏ Update</button>
                <a href="users">Cancel</a>
            </form>
        </div>
    </body>
</html>
