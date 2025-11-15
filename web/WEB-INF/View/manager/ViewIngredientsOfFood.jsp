<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Nguyên Liệu Món: ${menu.foodName}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <style>
            body {
                font-family:'Poppins',sans-serif;
                background:#fff8f3;
                padding:30px;
            }
            h2 {
                color:#e63946;
                font-weight:600;
                text-align:center;
                margin-bottom:30px;
            }
            .card {
                max-width:900px;
                margin:auto;
                padding:30px;
                box-shadow:0 4px 12px rgba(0,0,0,0.1);
                border-radius:12px;
                background:#fff;
            }
            table {
                width:100%;
                margin-top:15px;
                border-collapse:collapse;
            }
            th, td {
                padding:12px;
                text-align:center;
                border-bottom:1px solid #eee;
            }
            th {
                background:#e63946;
                color:white;
            }
            tr:hover {
                background:#fff1ee;
            }
            .btn-red {
                background:#e63946;
                color:white;
                border-radius:8px;
                padding:6px 12px;
                transition:0.3s;
                font-size:14px;
            }
            .btn-red:hover {
                background:#c72e3b;
            }
            .btn-green {
                background:#44bd32;
                color:white;
                border-radius:8px;
                padding:6px 12px;
                transition:0.3s;
                font-size:14px;
            }
            .btn-green:hover {
                background:#4cd137;
            }
            .btn-secondary {
                border-radius:8px;
                padding:6px 12px;
            }
            .action-form {
                display:inline-block;
                margin:0 2px;
            }
        </style>
    </head>
    <body>

        <div class="card">
            <h2>Nguyên Liệu Món: ${menu.foodName}</h2>

            <c:if test="${not empty message}">
                <div id="alertBox" class="alert
                     <c:choose>
                         <c:when test="${messageType == 'success'}">alert-success</c:when>
                         <c:otherwise>alert-error</c:otherwise>
                     </c:choose>">
                    ${message}
                </div>
            </c:if>
            <!-- Thêm nguyên liệu -->
            <div class="mb-3 text-end">
                <form method="get" action="${pageContext.request.contextPath}/manager/AddIngredientsOfFoodServlet">
                    <input type="hidden" name="foodId" value="${menu.foodId}">
                    <button type="submit" class="btn btn-green">➕ Thêm Nguyên Liệu</button>
                </form>
            </div>

            <c:if test="${empty ingredients}">
                <div class="alert alert-warning">Chưa có nguyên liệu nào cho món này.</div>
            </c:if>

            <c:if test="${not empty ingredients}">
                <table class="table table-striped">
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
                                    <form method="get" action="${pageContext.request.contextPath}/manager/EditIngredientsOfFoodServlet" class="action-form">
                                        <input type="hidden" name="ingredientId" value="${ing.ingredientId}">
                                        <input type="hidden" name="foodId" value="${menu.foodId}">
                                        <button type="submit" class="btn btn-red">Sửa</button>
                                    </form>

                                    <form method="post" action="${pageContext.request.contextPath}/manager/DeleteIngredientsOfFoodServlet" class="action-form" 
                                          onsubmit="return confirm('Bạn có chắc muốn xóa nguyên liệu ${ing.name}?');">
                                        <input type="hidden" name="ingredientId" value="${ing.ingredientId}">
                                        <input type="hidden" name="foodId" value="${menu.foodId}">
                                        <button type="submit" class="btn btn-secondary">Xóa</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/manager/ListMenuServlet" class="btn btn-secondary">⬅ Quay về danh sách món</a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                              var alertBox = document.getElementById('alertBox');
                                              if (alertBox) {
                                                  setTimeout(function () {
                                                      alertBox.style.display = 'none';
                                                  }, 3000);
                                              }
        </script>
    </body>
</html>
