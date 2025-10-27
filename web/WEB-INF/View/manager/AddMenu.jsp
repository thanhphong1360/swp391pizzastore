<%-- 
    Document   : AddMenu
    Created on : Oct 21, 2025, 2:22:10 PM
    Author     : Dystopia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Food Information</h1>
        <form action="${pageContext.request.contextPath}/manager/AddMenuServlet" method="post">
            <p>Tên món</p>
            <input type="text" />
            <p>Mô tả chi tiết</p>
            <input type="text" />
            <p>Danh mục</p>
            <select name="category_id">
                <option value="">-Thể loại-</option>
                <c:forEach var="cate" items="${categories}">
                    <option value="${cate.categoryId}">${cate.name}</option>
                </c:forEach>
            </select> 
            <p>Giá cả</p>
            <input type="text" />
            <p>Tình trạng</p>
            <input type="radio" name="status" value="available"/> Có sẵn
            <input type="radio" name="status" value="unavailable"/> Hết hàng
            <br>
            <input type="submit" value="Save" />
        </form>
    </body>
</html>
