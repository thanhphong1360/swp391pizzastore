<%-- 
    Document   : login
    Created on : Sep 28, 2025, 11:35:21 PM
    Author     : HP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="login-container">
    <div class="container" id="container">
        <div class="form-container sign-in-container">
            <form action="${pageContext.request.contextPath}/Login" method="post">
                <h1>Sign in</h1>
                <input type="email" name="username" placeholder="Email" required />
                <input type="password" name="password" placeholder="Password" required />
                <button type="submit">Sign In</button>
                <c:if test="${alert != null}">
                    <p style="color: red;">"${alert}"</p>
                </c:if>
            </form>
        </div>
    </div>
</div>
<script>
    const signInButton = document.getElementById('signIn');
    const container = document.getElementById('container');

    signInButton.addEventListener('click', () => {
        container.classList.remove("right-panel-active");
    });
</script>


