<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Edit Ingredient | Pizza House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body { font-family:'Poppins',sans-serif; background:#fff8f3; margin:30px; }
.form-container { background:#fff; border-radius:12px; width:400px; margin:auto; padding:25px; box-shadow:0 4px 15px rgba(0,0,0,0.1);}
h2 { text-align:center; color:#e63946; font-weight:600; margin-bottom:15px;}
input, textarea { width:100%; padding:8px; margin:6px 0 12px 0; border-radius:6px; border:1px solid #ccc; }
button { width:100%; background:#00a8ff; color:white; border:none; padding:10px; border-radius:6px; cursor:pointer; transition:0.3s; }
button:hover { background:#0097e6; }
a { display:block; text-align:center; margin-top:10px; color:#e63946; text-decoration:none; font-weight:500;}
a:hover { text-decoration:underline; }
</style>
</head>
<body>
<div class="form-container">
<h2>✏ Edit Ingredient</h2>
<form action="ingredients" method="post">
    <input type="hidden" name="action" value="edit"/>
    <input type="hidden" name="id" value="${ingredient.ingredientId}"/>
    <label>Name</label>
    <input type="text" name="name" value="${ingredient.name}" required/>
    <label>Description</label>
    <textarea name="description" rows="3">${ingredient.description}</textarea>
    <label>Unit</label>
    <input type="text" name="unit" value="${ingredient.unit}" required/>
    <label>Quantity</label>
    <input type="number" step="0.01" name="quantity" value="${ingredient.quantity}" required/>
    <button type="submit">Update</button>
</form>
<a href="${pageContext.request.contextPath}/manager/ingredients">← Back to list</a>
</div>
</body>
</html>
