<%-- 
    Document   : ListCate
    Created on : Oct 31, 2025, 4:01:43 AM
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
        <h1>Category</h1>
        <hr/>
        <form method="get" action="${pageContext.request.contextPath}/manager/AddCategoryServlet">
            <input type="submit" value="ADD CATEGORY FOR MENU" name="add_cate">
        </form>
        <hr />
        <table>
            <thead>
                <tr>
                    <th>Danh mục</th>
                    <th>Mô tả</th>
                    <th>Trạng thái</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${cateList}">
                    <tr>
                        <td>${c.name}</td>
                        <td>${c.description}</td>
                        <td>${c.status}</td>

                        <td>
                            <form method="get" action="${pageContext.request.contextPath}/manager/EditCategoryServlet">
                                <input type="hidden" name="id_edit_cate" value="${c.categoryId}"/>
                                <input type="submit" value="Edit" name="edit_cate">
                            </form>
                        </td>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
