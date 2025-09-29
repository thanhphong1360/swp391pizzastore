<%-- 
    Document   : login
    Created on : Sep 29, 2025, 8:36:43 PM
    Author     : Dystopia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <form action="login" method="post">
            <label>Tên tài khoản</label><br/>
            <input type="input" name="account"/><br/>
            <label>Mật khẩu</label><br/>
            <input type="password" name="password"/><br/>
            
            <input type="submit" value="Login"/>
        </form>
    </body>
</html>
