package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.User;
import util.AuditLogger;


public class UserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Integer currentUserId = (Integer) session.getAttribute("userId");

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                req.getRequestDispatcher("/WEB-INF/View/admin/users/add.jsp").forward(req, resp);
                break;

            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("user", userDAO.getById(id));
                req.getRequestDispatcher("/WEB-INF/View/admin/users/edit.jsp").forward(req, resp);
                break;

            case "toggle":
                handleToggle(req, resp, currentUserId);
                break;

            default:
                List<User> list = userDAO.getAll();
                req.setAttribute("list", list);
                req.getRequestDispatcher("/WEB-INF/View/admin/users/list.jsp").forward(req, resp);
        }
    }

    private void handleToggle(HttpServletRequest req, HttpServletResponse resp, Integer currentUserId)
            throws IOException {
        int toggleId = Integer.parseInt(req.getParameter("id"));
        User target = userDAO.getById(toggleId);

        if (target == null) {
            resp.sendRedirect("users?message=error");
            return;
        }

        boolean currentStatus = target.isStatus();
        boolean updated = userDAO.updateStatus(toggleId, !currentStatus);

        if (updated) {
            String actionType = currentStatus ? "DEACTIVATE" : "RESTORE";
            String desc = (currentStatus ? "Deactivated " : "Restored ") + "user: " + target.getEmail();
            AuditLogger.log(currentUserId, actionType, "Users", target.getUserId(), desc);

            resp.sendRedirect("users?message=" + (currentStatus ? "deactivated" : "restored"));
        } else {
            resp.sendRedirect("users?message=error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        Integer currentUserId = (Integer) session.getAttribute("userId");

        String action = req.getParameter("action");
        String idStr = req.getParameter("userId");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String roleStr = req.getParameter("roleId");

        // 🧾 Validate input
        if (name == null || name.trim().isEmpty() || name.length() > 20
                || email == null || email.trim().isEmpty()
                || password == null || password.length() < 4) {

            String errorMessage = "⚠ Please fill all required fields (password ≥ 4 chars).";
            if (name != null && name.length() > 20) {
                errorMessage = "⚠ Name must not exceed 20 characters.";
            }

            req.setAttribute("errorMessage", errorMessage);
            String page = "add".equals(action)
                    ? "/WEB-INF/View/admin/users/add.jsp"
                    : "/WEB-INF/View/admin/users/edit.jsp";
            req.getRequestDispatcher(page).forward(req, resp);
            return;
        }

        // Validate email format
        if (!email.matches("^[\\w.%+-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {
            req.setAttribute("errorMessage", "⚠ Invalid email format.");
            String page = "add".equals(action)
                    ? "/WEB-INF/View/admin/users/add.jsp"
                    : "/WEB-INF/View/admin/users/edit.jsp";
            req.getRequestDispatcher(page).forward(req, resp);
            return;
        }

        int roleId = Integer.parseInt(roleStr);
        User u = new User();
        u.setName(name);
        u.setEmail(email);
        u.setPassword(password);
        u.setRoleId(roleId);

        // ➕ ADD
        if ("add".equals(action)) {
            if (userDAO.existsByEmail(email)) {
                req.setAttribute("errorMessage", "⚠ Email already exists!");
                req.getRequestDispatcher("/WEB-INF/View/admin/users/add.jsp").forward(req, resp);
                return;
            }

            int newUserId = userDAO.insert(u);
            if (newUserId > 0) {
                AuditLogger.log(currentUserId, "ADD", "Users", newUserId, "Added new user: " + email);
                resp.sendRedirect("users?message=added");
            } else {
                req.setAttribute("errorMessage", "❌ Insert failed!");
                req.getRequestDispatcher("/WEB-INF/View/admin/users/add.jsp").forward(req, resp);
            }

        // ✏️ EDIT
        } else if ("edit".equals(action)) {
            int userId = Integer.parseInt(idStr);
            u.setUserId(userId);

            User old = userDAO.getById(userId);
            if (old != null && !old.getEmail().equalsIgnoreCase(email) && userDAO.existsByEmail(email)) {
                req.setAttribute("errorMessage", "⚠ This email is already used by another user!");
                req.getRequestDispatcher("/WEB-INF/View/admin/users/edit.jsp").forward(req, resp);
                return;
            }

            if (userDAO.update(u)) {
                AuditLogger.log(currentUserId, "UPDATE", "Users", userId, "Updated user: " + email);
                resp.sendRedirect("users?message=updated");
            } else {
                req.setAttribute("errorMessage", "❌ Update failed. Please try again.");
                req.getRequestDispatcher("/WEB-INF/View/admin/users/edit.jsp").forward(req, resp);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "User management with audit logging (clean version)";
    }
}
