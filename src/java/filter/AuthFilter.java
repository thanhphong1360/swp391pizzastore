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
        if (uri.endsWith("login.jsp") || uri.endsWith("LoginServlet") || uri.contains("/assets/")) {
            chain.doFilter(request, response);
            return;
        }

        // Kiểm tra session
        if (session == null || session.getAttribute("role") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // Lấy role từ session
        String role = (String) session.getAttribute("role");

        // Kiểm tra quyền
        if (uri.contains("/admin/") && !"ADMIN".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/access-denied.jsp");
            return;
        }

        if (uri.contains("/user/") && !"USER".equals(role) && !"ADMIN".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/access-denied.jsp");
            return;
        }

        // Nếu hợp lệ → cho đi tiếp
        chain.doFilter(request, response);
    }
}
