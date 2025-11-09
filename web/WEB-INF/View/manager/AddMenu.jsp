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
    <h1>Thêm Món Mới</h1>
    <form action="${pageContext.request.contextPath}/manager/AddMenuServlet" method="post" enctype="multipart/form-data">
        <!-- Tên món -->
        <p><label for="foodName">Tên món:</label></p>
        <input type="text" id="foodName" name="foodName" required placeholder="Nhập tên món" /><br><br>

        <!-- Mô tả chi tiết -->
        <p><label for="description">Mô tả chi tiết:</label></p>
        <textarea id="description" name="description" required placeholder="Mô tả chi tiết món ăn" rows="4" cols="50"></textarea><br><br>

        <!-- Kích cỡ -->
        <p><label for="size">Kích cỡ:</label></p>
        <select name="size" id="size" required>
            <option value="">-- Chọn kích cỡ --</option>
            <option value="Small">Nhỏ</option>
            <option value="Medium">Vừa</option>
            <option value="Large">Lớn</option>
        </select><br><br>
        
        <!-- Danh mục -->
        <p><label for="category_id">Danh mục:</label></p>
        <select name="category_id" id="category_id" required>
            <option value="">-- Chọn thể loại --</option>
            <c:forEach var="cate" items="${categories}">
                <option value="${cate.categoryId}">${cate.name}</option>
            </c:forEach>
        </select><br><br>

        <!-- Giá -->
        <p><label for="price">Giá cả:</label></p>
        <input type="number" id="price" name="price" step="0.01" required placeholder="Nhập giá món ăn" /><br><br>

        <!-- Tình trạng -->
        <p>Tình trạng:</p>
        <input type="radio" name="status" value="available" required /> Có sẵn
        <input type="radio" name="status" value="unavailable" required /> Hết hàng<br><br>

        <!-- Hình ảnh -->
        <p><label for="imageUrl">Hình ảnh:</label></p>
        <input type="file" id="imageUrl" name="imageUrl" accept="image/*" /><br><br>

        <!-- Submit -->
        <input type="submit" value="Lưu Món" />
    </form>
</body>
</html>
