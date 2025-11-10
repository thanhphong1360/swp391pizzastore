package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import dal.UserDAO;
import jakarta.servlet.annotation.WebServlet;
import util.EmailUtility;
import util.TokenGenerator;
 @WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String token = TokenGenerator.generateToken(); // Tạo token ngẫu nhiên

        if (userDAO.existsEmail(email)) {
            // Lưu token vào DB để sau đối chiếu
            userDAO.saveResetToken(email, token);

            String appUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
String resetLink = appUrl + "/change-password?token=" + token;
            String subject = "Password Reset Request";
            String content = "Click this link to reset your password: " + resetLink;

            EmailUtility.sendEmail(email, subject, content);

            request.setAttribute("successMessage", "Reset link has been sent to your email!");
        } else {
            request.setAttribute("errorMessage", "Email not found!");
        }
        request.getRequestDispatcher("/view/client/pages/forgot_password.jsp").forward(request, response);

    }
}
