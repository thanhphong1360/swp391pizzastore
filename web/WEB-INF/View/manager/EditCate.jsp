<%-- 
    Document   : EditCate
    Created on : Oct 31, 2025, 5:25:42 AM
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
    <body>
        <h1>Category Information</h1>
        <form action="${pageContext.request.contextPath}/manager/EditCategoryServlet" method="post">
            <input type="hidden" name="edit_cate_id" value="${c_edit.categoryId}">
            <p>Danh mục</p>
            <input type="text" name="edit_cate_name" value="${c_edit.name}"/>
            <p>Mô tả chi tiết</p>
            <input type="text" name="edit_cate_des" value="${c_edit.description}"/>
            <p>Tình trạng</p>

            <c:choose>
                <c:when test="${c_edit.status == 'available'}">
                    <input type="radio" name="edit_cate_status" value="available" checked> Có sẵn
                    <input type="radio" name="edit_cate_status" value="unavailable"> Không khả dụng
                </c:when>
                <c:otherwise>
                    <input type="radio" name="edit_cate_status" value="available"> Có sẵn
                    <input type="radio" name="edit_cate_status" value="unavailable" checked> Không khả dụng
                </c:otherwise>
            </c:choose>
            <br>
            <input type="submit" value="Lưu" />
        </form>
    </body>
</body>
</html>
