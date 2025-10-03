package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")  // Áp dụng cho tất cả URL
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        HttpSession session = req.getSession(false);

        // Cho phép vào trang login và resources tĩnh
        if (uri.endsWith("login.jsp") || uri.endsWith("Login") || uri.contains("/assets/")) {
            chain.doFilter(request, response);
            return;
        }
        
        if(uri.contains("login.jsp") || uri.contains("/Login") || uri.contains("/Home")){
            chain.doFilter(request, response);
            return;
        }

        // Kiểm tra session
        if (session == null || session.getAttribute("role") == null) {
            res.sendRedirect(req.getContextPath() + "/view/client/pages/login.jsp");
            return;
        }

        // Lấy role từ session
        String role = (String) session.getAttribute("role");

        // Kiểm tra quyền
        if (uri.contains("/Manager/") && !"Manager".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/AccessDenied.jsp");
            return;
        }
        if (uri.contains("/Cashier/") && !"Cashier".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/AccessDenied.jsp");
            return;
        }
        if (uri.contains("/Chef/") && !"Chef".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/AccessDenied.jsp");
            return;
        }
        if (uri.contains("/Waiter/") && !"Waiter".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/AccessDenied.jsp");
            return;
        }
        if (uri.contains("/Deliverystaff/") && !"DeliveryStaff".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/AccessDenied.jsp");
            return;
        }
        if (uri.contains("/Customer/") && !"Customer".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/AccessDenied.jsp");
            return;
        }


        // Nếu hợp lệ → cho đi tiếp
        chain.doFilter(request, response);
    }
}
