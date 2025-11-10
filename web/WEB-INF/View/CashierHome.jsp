<%-- 
    Document   : CashierHome
    Created on : Sep 29, 2025, 11:04:10 PM
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
        <h1>Cashier Home</h1>
        <div>
            <form action="${pageContext.request.contextPath}/cashier/Invoice" method="GET">
            <input type="hidden" name="action" value="checkoutList">
            <input type="submit" value="Thanh toán hóa đơn">
            </form>
            <a href="#">Invoice List</a>
        </div>
    </body>
</html>
