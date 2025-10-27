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
    </head>
    <body>
        <jsp:include page="TopNav.jsp"></jsp:include>
            <h1>Chef Home</h1>
            <h3>Orders</h3>
            <div>
                <form action="${pageContext.request.contextPath}/chef/Order" method="GET">
                <input type="hidden" name="action" value="browse">
                <input type="hidden" name="status" value="pending">
                <input type="submit" value="Pending orders">
                </form>
                <form action="${pageContext.request.contextPath}/chef/Order" method="GET">
                <input type="hidden" name="action" value="browse">
                <input type="hidden" name="status" value="doing">
                <input type="submit" value="Doing orders">
                </form>
                <form action="${pageContext.request.contextPath}/chef/Order" method="GET">
                <input type="hidden" name="action" value="browse">
                <input type="hidden" name="status" value="completed">
                <input type="submit" value="Completed orders">
                </form>
                <form action="${pageContext.request.contextPath}/chef/Order" method="GET">
                <input type="hidden" name="action" value="browse">
                <input type="hidden" name="status" value="rejected">
                <input type="submit" value="Rejected orders">
                </form>
            </div>
            <h3>Ingredients</h3>
            <div>
                <a href="#">Restaurant's Ingredients</a>
            </div> 
    </body>
</html>
