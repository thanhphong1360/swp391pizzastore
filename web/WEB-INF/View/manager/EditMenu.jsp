<%-- 
    Document   : AddMenu
    Created on : Oct 21, 2025, 1:41:04 PM
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
    <h1>Chỉnh Sửa Món</h1>
    <form action="${pageContext.request.contextPath}/manager/EditMenuServlet" method="post" enctype="multipart/form-data">
        
        <input type="hidden" name="foodId" value="${menu.foodId}"/>

        <p><label for="foodName">Tên món:</label></p>
        <input type="text" id="foodName" name="foodName" value="${menu.foodName}" required/><br><br>

        <p><label for="description">Mô tả chi tiết:</label></p>
        <textarea id="description" name="description" required>${menu.description}</textarea><br><br>

        <p><label for="size">Kích cỡ:</label></p>
        <select name="size" id="size" required>
            <option value="Small" ${menu.size == 'Small' ? 'selected' : ''}>Nhỏ</option>
            <option value="Medium" ${menu.size == 'Medium' ? 'selected' : ''}>Vừa</option>
            <option value="Large" ${menu.size == 'Large' ? 'selected' : ''}>Lớn</option>
        </select><br><br>

        <p><label for="category_id">Danh mục:</label></p>
        <select name="category_id" id="category_id" required>
            <c:forEach var="cate" items="${categories}">
                <option value="${cate.categoryId}" ${menu.categoryId == cate.categoryId ? 'selected' : ''}>
                    ${cate.name}
                </option>
            </c:forEach>
        </select><br><br>

        <p><label for="price">Giá cả:</label></p>
        <input type="number" id="price" name="price" step="0.01" value="${menu.price}" required/><br><br>

        <p>Tình trạng:</p>
        <input type="radio" name="status" value="available" ${menu.status == 'available' ? 'checked' : ''}/> Có sẵn
        <input type="radio" name="status" value="unavailable" ${menu.status == 'unavailable' ? 'checked' : ''}/> Hết hàng<br><br>

        <p><label for="imageUrl">Hình ảnh:</label></p>
        
        <img src="${pageContext.request.contextPath}/${menu.imgURL}" alt="Current Image" width="80" height="80"><br><br>
        <input type="file" id="imageUrl" name="imageUrl" accept="image/*"/><br><br>

        <input type="submit" value="Lưu Món"/>
    </form>
</body>
</html>
