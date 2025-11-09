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
                    <th>Kích cỡ</th>
                    <th>Giá</th>
                    <th>Trạng thái</th>
                    <th>Nguyên liệu</th>
                    <th>Hình ảnh</th>
                    <th>Hành động</th>

                </tr>
            </thead>
            <tbody>
                <c:forEach var="f" items="${menuList}">
                    <tr>
                        <td>${f.foodName}</td>
                        <td>${f.categoryName}</td>
                        <td>${f.description}</td>
                        <td>${f.size}</td>

                        <td><fmt:formatNumber value="${f.price}" type="number" maxFractionDigits="0"/> đ</td>
                        <td>${f.status}</td>
                        <td>
                            <c:forEach var="ing" items="${f.ingredients}">
                                ${ing.name} - ${ing.quantity} ${ing.unit}<br>
                            </c:forEach>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty f.imgURL}">
                                    <img src="${pageContext.request.contextPath}/${f.imgURL}" alt="${f.foodName}" width="80" height="80">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/images/no-image.png" alt="No image" width="80" height="80">
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <form method="get" action="${pageContext.request.contextPath}/manager/EditMenuServlet">
                                <input type="hidden" name="foodId" value="${f.foodId}">
                                <input type="submit" value="Edit" name="edit_food">
                            </form>
                            <!-- Nút xem công thức món -->
                            <form method="get" action="${pageContext.request.contextPath}/manager/ViewIngredientsOfFoodServlet">
                                <input type="hidden" name="foodId" value="${f.foodId}">
                                <input type="submit" value="Xem Công Thức">
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
