package controller;

import dal.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Lấy token và hai trường password
        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // ✅ Kiểm tra xem hai mật khẩu có khớp nhau không
        if (newPassword == null || confirmPassword == null || !newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match!");
            request.getRequestDispatcher("/view/client/pages/change_password.jsp").forward(request, response);
            return;
        }

        // ✅ Kiểm tra token có hợp lệ không
        String email = userDAO.getEmailByToken(token);
        if (email != null) {
            // ✅ Update mật khẩu
            userDAO.updatePassword(email, newPassword);

            // ✅ Xóa token sau khi đổi thành công (tùy bạn có muốn làm không)
            userDAO.clearResetToken(email);

            request.setAttribute("successMessage", "Password changed successfully!");
        } else {
            request.setAttribute("errorMessage", "Invalid or expired reset link!");
        }

        request.getRequestDispatcher("/view/client/pages/change_password.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/client/pages/change_password.jsp").forward(request, response);
    }
}
