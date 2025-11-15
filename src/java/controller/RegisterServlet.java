package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/register") 
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.getRequestDispatcher("WEB-INF/View/client/pages/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");

        String errorMessage = null;
        UserDAO userDAO = new UserDAO();

        if (name == null || name.trim().isEmpty()) {
            errorMessage = "Name is required!";
        } else if (email == null || email.trim().isEmpty()) {
            errorMessage = "Email is required!";
        } else if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errorMessage = "Invalid email format!";
        } else if (userDAO.checkEmailExists(email)) {
            errorMessage = "Email already registered!";
        } else if (password == null || password.length() < 6) {
            errorMessage = "Password must be at least 6 characters!";
        } else if (!password.equals(confirmPassword)) {
            errorMessage = "Passwords do not match!";
        }

        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
           
            request.getRequestDispatcher("WEB-INF/View/client/pages/register.jsp").forward(request, response);
            return;
        }

       
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
User newUser = new User(0, 5, email, hashedPassword, name, null);
        boolean success = userDAO.insertUser(newUser);

        if (success) {
            request.setAttribute("message", "Bạn đã đăng ký thành công!");
            request.getRequestDispatcher("WEB-INF/View/client/pages/register.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed, try again!");
            request.getRequestDispatcher("WEB-INF/View/client/pages/register.jsp").forward(request, response);
        }
    }
}
