<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Edit Ingredient</title>
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                background: #f5f6fa;
                margin: 30px;
            }
            .form-container {
                background: #fff;
                border-radius: 12px;
                width: 400px;
                margin: auto;
                padding: 25px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            h2 {
                text-align: center;
                color: #273c75;
            }
            input, textarea {
                width: 100%;
                padding: 8px;
                margin-top: 6px;
                margin-bottom: 12px;
                border: 1px solid #ccc;
                border-radius: 6px;
            }
            button {
                width: 100%;
                background: #00a8ff;
                color: white;
                border: none;
                padding: 10px;
                border-radius: 6px;
                cursor: pointer;
            }
            button:hover {
                background: #0097e6;
            }
            a {
                display: block;
                margin-top: 10px;
                text-align: center;
                color: #0097e6;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Edit Ingredient</h2>
            <c:if test="${not empty successMessage}">
                <div style="background-color:#e6ffed; color:#006400;
                     border-left:5px solid #28a745; padding:10px;
                     border-radius:6px; margin-bottom:10px;">
                    ${successMessage}
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div style="background-color:#fff3cd; color:#856404;
                     border-left:5px solid #ffc107; padding:10px;
                     border-radius:6px; margin-bottom:10px;">
                    ${errorMessage}
                </div>
            </c:if>

            <form action="ingredients" method="post">
                <input type="hidden" name="action" value="edit" />
                <input type="hidden" name="id" value="${ingredient.ingredientId}" />

                <label>Name</label>
                <input type="text" name="name" value="${ingredient.name}" required />

                <label>Description</label>
                <textarea name="description" rows="3">${ingredient.description}</textarea>

                <label>Unit</label>
                <input type="text" name="unit" value="${ingredient.unit}" required />

                <label>Quantity</label>
                <input type="number" step="0.01" name="quantity" value="${ingredient.quantity}" required />

                <button type="submit">Update</button>
            </form>
            <a href="${pageContext.request.contextPath}/manager/ingredients">← Back to list</a>
        </div>
    </body>
</html>
