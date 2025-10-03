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
            <div class="home-container">
                <h1>Waiter Home</h1>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Home.css" />
            <div class="home-links">
                <a href="#">Open Table</a>
                <a href="#">Create Order</a>
            </div>
        </div>
    </body>
</html>
