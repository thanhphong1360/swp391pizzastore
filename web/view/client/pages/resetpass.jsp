<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
</head>
<body>
    <h2>Reset Password</h2>

    
    <%
        String error = (String) request.getAttribute("error");
        String message = (String) request.getAttribute("message");
        if (error != null) {
    %>
        <p style="color:red;"><%= error %></p>
    <%
        } else if (message != null) {
    %>
        <p style="color:green;"><%= message %></p>
    <%
        }
    %>

    <form action="<%= request.getContextPath() %>/resetpass" method="post">
        <label>Email:</label><br/>
        <input type="email" name="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" required /><br/><br/>

        <label>New Password (>=6 ký tự):</label><br/>
        <input type="password" name="password" minlength="6" required /><br/><br/>

        <label>Confirm Password:</label><br/>
        <input type="password" name="confirm_password" minlength="6" required /><br/><br/>

        <button type="submit">Reset</button>
    </form>
</body>
</html>
