<%-- 
    Document   : ChefHome
    Created on : Sep 29, 2025, 11:04:17 PM
    Author     : cungp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Home.css" />
    </head>
    <body>
        <jsp:include page="TopNav.jsp"></jsp:include>
        <div class="home-container">
            <h1>Chef Home</h1>
            <div class="home-links">
                <a href="#">Food orders</a>
                <a href="#">Restaurant's Ingredients</a>
            </div>
        </div>
    </body>
</html>
