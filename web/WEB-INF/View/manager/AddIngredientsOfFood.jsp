<%-- 
    Document   : AddIngredientsOfFood
    Created on : Nov 9, 2025, 8:28:40 PM
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
    <h1>Thêm Nguyên Liệu cho Món: ${menu.foodName}</h1>
    <form action="${pageContext.request.contextPath}/manager/AddIngredientsOfFoodServlet" method="post">
        <input type="hidden" name="foodId" value="${menu.foodId}" />

        <p><label for="ingredientId">Chọn Nguyên Liệu:</label></p>
        <select name="ingredientId" required>
            <c:forEach var="ingredient" items="${ingredients}">
                <option value="${ingredient.ingredientId}">${ingredient.name}</option>
            </c:forEach>
        </select><br><br>

        <p><label for="quantity">Số Lượng:</label></p>
        <input type="number" name="quantity" step="0.01" required /><br><br>

        <input type="submit" value="Thêm Nguyên Liệu" />
    </form>
</body>
</html>
