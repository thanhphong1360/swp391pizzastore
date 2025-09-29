<%-- 
    Document   : profile
    Created on : Sep 30, 2025, 2:17:37 AM
    Author     : Dystopia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello, ${current_user.name}</h1>
        <form action="changepassword" method="get">
            <input type="submit" value="Chage Password"/>
        </form>
    </body>
</html>
