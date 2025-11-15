<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add User | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body { font-family:'Poppins',sans-serif; background:#fff8f3; margin:30px; }
.form-container { background:#fff; border-radius:12px; width:400px; margin:auto; padding:25px; box-shadow:0 4px 15px rgba(0,0,0,0.1);}
h2 { text-align:center; color:#e63946; font-weight:600; margin-bottom:15px;}
input, select { width:100%; padding:8px; margin:6px 0 12px 0; border-radius:6px; border:1px solid #ccc; }
button { width:100%; background:#e63946; color:white; border:none; padding:10px; border-radius:6px; cursor:pointer; transition:0.3s; }
button:hover { background:#c72e3b; }
a { display:block; text-align:center; margin-top:10px; color:#e63946; text-decoration:none; font-weight:500;}
a:hover { text-decoration:underline; }
</style>
</head>
<body>
<div class="form-container">
<h2>➕ Add User</h2> 
<form action="users" method="post">
    <input type="hidden" name="action" value="add"/>
    <label>Name</label>
    <input type="text" name="name" required maxlength="50"/>
    <label>Email</label>
    <input type="email" name="email" required maxlength="100"/>
    <label>Password</label>
    <input type="password" name="password" required minlength="4"/>
    <label>Role</label>
    <select name="roleId" required>
        <option value="2">Waiter</option>
        <option value="3">Chef</option>
        <option value="4">Cashier</option>
        <option value="5">Customer</option>
    </select>
    <button type="submit">➕ Add</button>
</form>
<a href="${pageContext.request.contextPath}/manager/users">← Back to list</a>
</div>
</body>
</html>
