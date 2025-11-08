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
    </head>
    <body>
        <jsp:include page="TopNav.jsp"></jsp:include>
            <h1>Manager Home</h1>
            <div>
                <a href="#">Staff Accounts</a>
                <a href="${pageContext.request.contextPath}/manager/ListMenuServlet">Restaurant's Menu</a>
                <a href="${pageContext.request.contextPath}/manager/ListCategoryServlet">Restaurant's Category</a>
                <a href="#">Tables</a>
                <a href="#">Ingredients</a>
                <a href="#">Restaurant's Statistics</a>
            </div>
    </body>
</html>
