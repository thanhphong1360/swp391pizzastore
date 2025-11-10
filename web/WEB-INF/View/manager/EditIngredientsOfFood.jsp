<%-- 
    Document   : EditIngredientsOfFood
    Created on : Nov 10, 2025, 11:03:50 AM
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
    <h1>Sửa Nguyên Liệu cho Món: ${menu.foodName}</h1>

    <!-- Form để sửa nguyên liệu -->
    <form action="${pageContext.request.contextPath}/manager/EditIngredientsOfFoodServlet" method="post">
        <!-- Truyền foodId và ingredientId vào form -->
        <input type="hidden" name="foodId" value="${menu.foodId}" />
        <input type="hidden" name="ingredientId" value="${ingredient.ingredientId}" />

        <p><label for="ingredientId">Nguyên Liệu:</label></p>
        <!-- Hiển thị tên nguyên liệu -->
        <input type="text" value="${ingredient.name}" disabled /><br><br>

        <p><label for="quantity">Số Lượng Hiện Tại:</label></p>
        <!-- Hiển thị số lượng nguyên liệu hiện tại -->
        <input type="number" name="quantity" value="${ingredient.quantity}" step="0.01" required /><br><br>

        <input type="submit" value="Cập Nhật Nguyên Liệu" />
    </form>
</body>
</html>
