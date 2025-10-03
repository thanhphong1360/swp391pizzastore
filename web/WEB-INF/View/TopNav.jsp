<%-- 
    Document   : TopNavyyyyyyyyyyyyyyyyyyyyyy
    Created on : Sep 29, 2025, 11:13:44 PM
    Author     : cungp
--%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    
.header-nav {
    display: flex;     
    align-items: center; 
    gap: 12px;       
}


.header-nav-link {
    display: flex;         
    align-items: center; 
    gap: 8px;             
    
    text-decoration: none; 
    padding: 9px 16px;     
    border-radius: 8px;   
    font-size: 15px;
    font-weight: 500;      
    
    border: 1px solid transparent; 
    transition: all 0.2s ease-in-out; 
}


.header-nav-link:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}


.btn-icon-home {
    background-color: #eef2ff; 
    color: #3b82f6;            
}

.btn-icon-home:hover {
    background-color: #dbeafe; 
    color: #2563eb;            
}

.btn-icon-logout {
    background-color: #fee2e2; 
    color: #ef4444;           
}

.btn-icon-logout:hover {
    background-color: #fecaca; 
    color: #dc2626;           
}
</style>
<nav class="header-nav">
    <a href="Home" class="header-nav-link btn-icon-home">
        <i class="fas fa-home"></i> Trang chủ
    </a>
    <a href="Logout" class="header-nav-link btn-icon-logout">
        <i class="fas fa-sign-out-alt"></i> Đăng xuất
    </a>
</nav>
