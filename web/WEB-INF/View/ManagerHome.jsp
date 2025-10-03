<%-- 
    Document   : ManagerHome
    Created on : Sep 29, 2025, 11:04:01 PM
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
            <h1>Manager Home</h1>
            <div class="home-links">
                <a href="#">Staff Accounts</a>
                <a href="#">Restaurant's Menu</a>
                <a href="#">Tables</a>
                <a href="#">Ingredients</a>
                <a href="#">Restaurant's Statistics</a>
            </div>
        </div>
    </body>
</html>
