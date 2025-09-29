<%-- 
    Document   : changepassword
    Created on : Sep 30, 2025, 3:14:31 AM
    Author     : Dystopia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f5f5;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }
            
            .container {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                padding: 40px;
                width: 100%;
                max-width: 450px;
            }
            
            .header {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }
            
            .profile-icon {
                width: 40px;
                height: 40px;
                background-color: #007bff;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 18px;
                font-weight: bold;
                margin-right: 15px;
            }
            
            .header h1 {
                color: #333;
                font-size: 24px;
                font-weight: 600;
            }
            
            .description {
                color: #666;
                font-size: 14px;
                line-height: 1.5;
                margin-bottom: 30px;
            }
            
            .form-group {
                margin-bottom: 20px;
                position: relative;
            }
            
            .form-group label {
                display: block;
                color: #333;
                font-weight: 500;
                margin-bottom: 8px;
                font-size: 14px;
            }
            
            .password-container {
                position: relative;
                display: flex;
                align-items: center;
            }
            
            .password-container input {
                width: 100%;
                padding: 12px 45px 12px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
                transition: border-color 0.3s;
            }
            
            .password-container input:focus {
                outline: none;
                border-color: #007bff;
                box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
            }
            
            .password-container input::placeholder {
                color: #999;
            }
            
            .toggle-password {
                position: absolute;
                right: 12px;
                background: none;
                border: none;
                cursor: pointer;
                color: #666;
                font-size: 16px;
                padding: 0;
                width: 24px;
                height: 24px;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .toggle-password:hover {
                color: #333;
            }
            
            .forgot-link {
                text-align: right;
                margin-top: -10px;
                margin-bottom: 20px;
            }
            
            .forgot-link a {
                color: #007bff;
                text-decoration: none;
                font-size: 14px;
            }
            
            .forgot-link a:hover {
                text-decoration: underline;
            }
            
            .change-btn {
                width: 100%;
                background-color: #007bff;
                color: white;
                border: none;
                padding: 12px;
                border-radius: 4px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            
            .change-btn:hover {
                background-color: #0056b3;
            }
            
            .error-message {
                background-color: #f8d7da;
                color: #721c24;
                padding: 12px;
                border-radius: 4px;
                margin-bottom: 20px;
                border: 1px solid #f5c6cb;
                font-size: 14px;
            }
            
            .back-link {
                text-align: center;
                margin-top: 20px;
            }
            
            .back-link a {
                color: #666;
                text-decoration: none;
                font-size: 14px;
            }
            
            .back-link a:hover {
                color: #333;
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <div class="profile-icon">👤</div>
                <h1>Change Password</h1>
            </div>
            
            <div class="description">
                To change your password, please fill in the fields below. Your password must contain at least 8 characters, it must also include at least one upper case letter, one lower case letter, one number and one special character.
            </div>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="changepassword" method="post">
                <div class="form-group">
                    <label for="currentPassword">Current password</label>
                    <div class="password-container">
                        <input type="password" id="currentPassword" name="currentPassword" 
                               placeholder="Current password" required>                 
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="newPassword">New password</label>
                    <div class="password-container">
                        <input type="password" id="newPassword" name="newPassword" 
                               placeholder="New password" required>
                        
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Confirm password</label>
                    <div class="password-container">
                        <input type="password" id="confirmPassword" name="confirmPassword" 
                               placeholder="Confirm password" required>
                        
                    </div>
                </div>
                
                <div class="forgot-link">
                    <a href="#" onclick="alert('Forgot password functionality not implemented yet')">Forgot password?</a>
                </div>
                
                <button type="submit" class="change-btn">Change Password</button>
            </form>
            
            <div class="back-link">
                <a href="#">← Back to Profile</a>
            </div>
        </div>
        
        <script>
            
            // Validate password strength
            document.getElementById('newPassword').addEventListener('input', function() {
                const password = this.value;
                const hasUpper = /[A-Z]/.test(password);
                const hasLower = /[a-z]/.test(password);
                const hasNumber = /\d/.test(password);
                const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(password);
                const hasLength = password.length >= 8;
                
                if (!hasLength || !hasUpper || !hasLower || !hasNumber || !hasSpecial) {
                    this.style.borderColor = '#dc3545';
                } else {
                    this.style.borderColor = '#28a745';
                }
            });
            
            // Confirm password validation
            document.getElementById('confirmPassword').addEventListener('input', function() {
                const newPassword = document.getElementById('newPassword').value;
                const confirmPassword = this.value;
                
                if (confirmPassword !== '' && newPassword !== confirmPassword) {
                    this.style.borderColor = '#dc3545';
                } else {
                    this.style.borderColor = '#28a745';
                }
            });
        </script>
    </body>
</html>