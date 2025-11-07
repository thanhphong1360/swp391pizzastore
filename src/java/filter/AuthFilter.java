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
   
        if (uri.contains("login.jsp")
                || uri.contains("/Login")   
                || uri.contains("/Home")
                || uri.contains("register.jsp")
                || uri.endsWith("/register")
               || uri.contains("/view/client/pages/forgot_password.jsp")
|| uri.contains("/forgot-password")
                || uri.contains("/change-password")

                || uri.contains("/assets/")) {
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
        if (uri.contains("/manager/") && !"Manager".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/access-denied.jsp");
            return;
        }
        if (uri.contains("/cashier/") && !"Cashier".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/access-denied.jsp");
            return;
        }
        if (uri.contains("/chef/") && !"Chef".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/access-denied.jsp");
            return;
        }
        if (uri.contains("/waiter/") && !"Waiter".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/access-denied.jsp");
            return;
        }
        if (uri.contains("/deliverystaff/") && !"DeliveryStaff".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/access-denied.jsp");
            return;
        }
        if (uri.contains("/customer/") && !"Customer".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/access-denied.jsp");
            return;
        }


        // Nếu hợp lệ → cho đi tiếp
        chain.doFilter(request, response);
    }
}
