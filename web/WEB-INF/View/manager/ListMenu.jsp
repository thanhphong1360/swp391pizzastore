<%-- 
    Document   : RestaurentMenuManager
    Created on : Oct 17, 2025, 12:36:37 AM
    Author     : Dystopia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Menu</h1>
        <hr/>
        <form method="get" action="${pageContext.request.contextPath}/manager/AddMenuServlet">
            <input type="submit" value="ADD FOOD FOR MENU" name="add_food">
        </form>
        <hr />
        <table>
            <thead>
                <tr>
                    <th>Tên món</th>
                    <th>Danh mục</th>
                    <th>Mô tả</th>
                    <th>Giá</th>
                    <th>Trạng thái</th>

                </tr>
            </thead>
            <tbody>
                <c:forEach var="f" items="${menuList}">
                    <tr>
                        <td>${f.foodName}</td>
                        <td>${f.categoryName}</td>
                        <td>${f.description}</td>
                        <td><fmt:formatNumber value="${f.price}" type="number" maxFractionDigits="0"/> đ</td>
                        <td>${f.status}</td>
                        <td>
                            <form method="post" action="${pageContext.request.contextPath}/manager/EditMenuServlet">
                                <input type="submit" value="Edit" name="edit_food">
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
