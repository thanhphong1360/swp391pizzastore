package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.User;

@WebServlet("/users")
public class UserServlet extends HttpServlet {

    private UserDAO dao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                req.getRequestDispatcher("WEB-INF/View/admin/users/add.jsp").forward(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("user", dao.getById(id));
                req.getRequestDispatcher("WEB-INF/View/admin/users/edit.jsp").forward(req, resp);
                break;
            case "toggle":
                int toggleId = Integer.parseInt(req.getParameter("id"));
                User target = dao.getById(toggleId);

                if (target == null) {
                    resp.sendRedirect("users?message=error");
                    break;
                }

                boolean currentStatus = target.isStatus();
                boolean updated = dao.updateStatus(toggleId, !currentStatus);

                if (updated) {
                    if (currentStatus) {
                        resp.sendRedirect("users?message=deactivated");
                    } else {
                        resp.sendRedirect("users?message=restored");
                    }
                } else {
                    resp.sendRedirect("users?message=error");
                }
                break;

            default:
                List<User> list = dao.getAll();
                req.setAttribute("list", list);
                req.getRequestDispatcher("WEB-INF/View/admin/users/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        String idStr = req.getParameter("userId");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        int roleId = Integer.parseInt(req.getParameter("roleId"));
        // --- Validate cơ bản ---
        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.length() < 4) {
            req.setAttribute("errorMessage", "⚠ Please fill all required fields (password ≥ 4 chars).");
            String page = "add".equals(action)
                    ? "WEB-INF/View/admin/users/add.jsp"
                    : "WEB-INF/View/admin/users/edit.jsp";
            req.getRequestDispatcher(page).forward(req, resp);
            return;
        }

        // --- Validate email định dạng ---
        if (!email.matches("^[\\w.%+-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {
            req.setAttribute("errorMessage", "⚠ Invalid email format.");
            String page = "add".equals(action)
                    ? "WEB-INF/View/admin/users/add.jsp"
                    : "WEB-INF/View/admin/users/edit.jsp";
            req.getRequestDispatcher(page).forward(req, resp);
            return;
        }

        User u = new User();
        u.setName(name);
        u.setEmail(email);
        u.setPassword(password);
        u.setRoleId(roleId);
        if ("add".equals(action)) {
            // --- Kiểm tra trùng email ---
            if (dao.existsByEmail(email)) {
                req.setAttribute("errorMessage", "⚠ Email already exists!");
                req.getRequestDispatcher("WEB-INF/View/admin/users/add.jsp").forward(req, resp);
                return;
            }

            if (dao.insert(u)) {
                resp.sendRedirect("users?message=added");
            } else {
                req.setAttribute("errorMessage", "❌ Insert failed. Please try again.");
                req.getRequestDispatcher("WEB-INF/View/admin/users/add.jsp").forward(req, resp);
            }

        } else if ("edit".equals(action)) {
            u.setUserId(Integer.parseInt(idStr));

            // --- Check trùng email khi update (trừ khi giữ nguyên email cũ) ---
            User old = dao.getById(u.getUserId());
            if (old != null && !old.getEmail().equalsIgnoreCase(email) && dao.existsByEmail(email)) {
                req.setAttribute("errorMessage", "⚠ This email is already used by another user!");
                req.getRequestDispatcher("WEB-INF/View/admin/users/edit.jsp").forward(req, resp);
                return;
            }

            if (dao.update(u)) {
                resp.sendRedirect("users?message=updated");
            } else {
                req.setAttribute("errorMessage", "❌ Update failed. Please try again.");
                req.getRequestDispatcher("WEB-INF/View/admin/users/edit.jsp").forward(req, resp);
            }
        }
    }
}
