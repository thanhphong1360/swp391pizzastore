<%-- 
    Document   : ViewIngredientsOfFood
    Created on : Nov 9, 2025, 6:31:20 PM
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
    <h1>Quản Lý Nguyên Liệu Món: ${menu.foodName}</h1>

    <!-- Hiển thị nguyên liệu -->
    <table border="1">
        <thead>
            <tr>
                <th>Tên Nguyên Liệu</th>
                <th>Số Lượng</th>
                <th>Đơn Vị</th>
                <th>Hành Động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="ing" items="${ingredients}">
                <tr>
                    <td>${ing.name}</td>
                    <td>${ing.quantity}</td>
                    <td>${ing.unit}</td>
                    <td>
                        <!-- Form để chỉnh sửa nguyên liệu -->
                        <form method="get" action="${pageContext.request.contextPath}/manager/EditIngredientsOfFoodServlet">
                            <input type="hidden" name="ingredientId" value="${ing.ingredientId}">
                            <input type="hidden" name="foodId" value="${menu.foodId}">
                            <input type="submit" value="Sửa">
                        </form>
                        <!-- Form để xóa nguyên liệu -->
                        <form method="post" action="${pageContext.request.contextPath}/manager/DeleteIngredientsOfFoodServlet">
                            <input type="hidden" name="ingredientId" value="${ing.ingredientId}">
                            <input type="hidden" name="foodId" value="${menu.foodId}">
                            <input type="submit" value="Xóa">
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Thêm nguyên liệu -->
    <form method="get" action="${pageContext.request.contextPath}/manager/AddIngredientsOfFoodServlet">
        <input type="hidden" name="foodId" value="${menu.foodId}">
        <input type="submit" value="Thêm Nguyên Liệu">
    </form>

</body>
</html>
