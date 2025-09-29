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
        <div class="form-container sign-up-container">
            <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
                <h1>Create Account</h1>
                <input type="text" name="name" placeholder="Name" pattern="(\S+\s){1,}\S+" title="Please enter at least two words separated by space" required/>
                <input type="email" name="email" placeholder="Email" required/>
                <input type="password" name="password" placeholder="Password" required/>
                <button>Sign Up</button>
            </form>
        </div>
        <div class="overlay-container">
            <div class="overlay">
                <div class="overlay-panel overlay-left">
                    <h1>Welcome Back!</h1>
                    <p>To keep connected with us please login with your personal info</p>
                    <button class="ghost" id="signIn">Sign In</button>
                </div>
                <div class="overlay-panel overlay-right">
                    <h1>Hello, Friend!</h1>
                    <p>Enter your personal details and start journey with us</p>
                    <button class="ghost" id="signUp">Sign Up</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    const signUpButton = document.getElementById('signUp');
    const signInButton = document.getElementById('signIn');
    const container = document.getElementById('container');

    signUpButton.addEventListener('click', () => {
        container.classList.add("right-panel-active");
    });

    signInButton.addEventListener('click', () => {
        container.classList.remove("right-panel-active");
    });
</script>


