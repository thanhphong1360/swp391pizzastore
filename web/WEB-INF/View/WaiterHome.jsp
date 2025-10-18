<%-- 
    Document   : WaiterHome
    Created on : Sep 29, 2025, 11:04:26 PM
    Author     : cungp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
    </head>
    <body>
        <jsp:include page="TopNav.jsp"></jsp:include>
        <h1>Waiter Home</h1>
        <div>
            <form action="${pageContext.request.contextPath}/waiter/Table" method="GET">
                <input type="hidden" name="action" value="open">
                <input type="submit" value="Open Table">
            </form>
            <a href="#">Create Order</a>
        </div>
    </body>
</html>
