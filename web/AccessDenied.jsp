<%-- 
    Document   : AccessDenied
    Created on : Sep 29, 2025, 8:05:05 PM
    Author     : cungp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Access Denied</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #fffbea;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
                text-align: center;
            }

            h1 {
                color: #d97706; /* vàng đậm */
                background-color: #fef3c7; /* vàng nhạt */
                padding: 20px 30px;
                border: 2px solid #facc15;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            a {
                text-decoration: none;
                color: #fff;
                background-color: #facc15;
                padding: 10px 20px;
                border-radius: 6px;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }

            a:hover {
                background-color: #eab308; /* vàng đậm hơn khi hover */
            }
        </style>
    </head>
    <body>
        <h1>Bạn không có quyền truy cập vào mục này!</h1>
        <a href="${pageContext.request.contextPath}/Home">Về trang chủ</a>
    </body>
</html>
