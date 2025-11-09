<%-- 
    Document   : AddCate
    Created on : Oct 31, 2025, 4:16:56 AM
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
        <h1>Category Information</h1>
        <form action="${pageContext.request.contextPath}/manager/AddCategoryServlet" method="post">
            <p>Danh mục</p>
            <input type="text" name="add_cate_name"/>
            <p>Mô tả chi tiết</p>
            <input type="text" name="add_cate_des"/>
            <p>Tình trạng</p>
            <input type="radio" name="add_cate_status" value="available"/> Có sẵn
            <input type="radio" name="add_cate_status" value="unavailable"/> Không khả dụng
            <br>
            <input type="submit" value="Save" />
        </form>
    </body>
</html>
