package controller;

import dal.IngredientDAO;
import jakarta.servlet.ServletException;

import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Ingredient;
import util.AuditLogger;


public class IngredientServlet extends HttpServlet {

    private final IngredientDAO dao = new IngredientDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Integer currentUserId = (Integer) session.getAttribute("userId");

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                req.getRequestDispatcher("/WEB-INF/View/admin/ingredients/add.jsp").forward(req, resp);
                break;

            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("ingredient", dao.getById(id));
                req.getRequestDispatcher("/WEB-INF/View/admin/ingredients/edit.jsp").forward(req, resp);
                break;

            case "toggle":
                handleToggle(req, resp, currentUserId);
                break;

            default:
                List<Ingredient> list = dao.getAll();
                req.setAttribute("list", list);
                req.getRequestDispatcher("/WEB-INF/View/admin/ingredients/list.jsp").forward(req, resp);
        }
    }

    private void handleToggle(HttpServletRequest req, HttpServletResponse resp, Integer currentUserId)
            throws IOException {
        int toggleId = Integer.parseInt(req.getParameter("id"));
        Ingredient target = dao.getById(toggleId);

        if (target == null) {
            resp.sendRedirect("ingredients?message=error");
            return;
        }

        boolean currentStatus = target.isStatus();
        boolean updated = dao.updateStatus(toggleId, !currentStatus);

        if (updated) {
            String actionType = currentStatus ? "DEACTIVATE" : "RESTORE";
            String desc = (currentStatus ? "Deactivated " : "Restored ") + "ingredient: " + target.getName();
            AuditLogger.log(currentUserId, actionType, "Ingredients", target.getIngredientId(), desc);

            resp.sendRedirect("ingredients?message=" + (currentStatus ? "deactivated" : "restored"));
        } else {
            resp.sendRedirect("ingredients?message=error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        Integer currentUserId = (Integer) session.getAttribute("userId");

        String action = req.getParameter("action");

        // 🧾 Lấy dữ liệu từ form
        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String unit = req.getParameter("unit");
        String quantityStr = req.getParameter("quantity");
        String statusStr = req.getParameter("status");

        String error = null;
        double quantity = 0;

        // 🔹 Validate input
        if (name == null || name.trim().isEmpty() || name.length() > 50) {
            error = "❌ Name must be between 1–50 characters.";
        } else if (description != null && description.length() > 200) {
            error = "❌ Description cannot exceed 200 characters.";
        } else if (unit == null || unit.trim().isEmpty() || unit.length() > 10) {
            error = "❌ Unit must be between 1–10 characters.";
        } else {
            try {
                quantity = Double.parseDouble(quantityStr);
                if (quantity < 0) error = "❌ Quantity must be positive.";
            } catch (NumberFormatException e) {
                error = "❌ Invalid quantity value.";
            }
        }

        if (error != null) {
            req.setAttribute("errorMessage", error);
            if ("edit".equals(action)) {
                int id = Integer.parseInt(idStr);
                req.setAttribute("ingredient", dao.getById(id));
                req.getRequestDispatcher("/WEB-INF/View/admin/ingredients/edit.jsp").forward(req, resp);
            } else {
                req.getRequestDispatcher("/WEB-INF/View/admin/ingredients/add.jsp").forward(req, resp);
            }
            return;
        }

        // 🔹 Tạo đối tượng ingredient
        Ingredient ing = new Ingredient();
        ing.setName(name.trim());
        ing.setDescription(description != null ? description.trim() : "");
        ing.setUnit(unit.trim());
        ing.setQuantity(quantity);

        if ("edit".equals(action)) {
            int id = Integer.parseInt(idStr);
            Ingredient existing = dao.getById(id);
            ing.setStatus(existing != null ? existing.isStatus() : true);
        } else {
            ing.setStatus(true);
        }

        // ➕ ADD
        if ("add".equals(action)) {
            if (dao.existsByName(name)) {
                req.setAttribute("errorMessage", "❌ Ingredient name already exists!");
                req.getRequestDispatcher("/WEB-INF/View/admin/ingredients/add.jsp").forward(req, resp);
                return;
            }

            int newId = dao.insert(ing);
            if (newId > 0) {
                AuditLogger.log(currentUserId, "ADD", "Ingredients", newId, "Added ingredient: " + name);
                resp.sendRedirect("ingredients?message=added");
            } else {
                req.setAttribute("errorMessage", "❌ Insert failed!");
                req.getRequestDispatcher("/WEB-INF/View/admin/ingredients/add.jsp").forward(req, resp);
            }

        // ✏️ EDIT
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(idStr);
            ing.setIngredientId(id);

            if (dao.existsByNameExceptId(name, id)) {
                req.setAttribute("errorMessage", "❌ Ingredient name already exists!");
                req.setAttribute("ingredient", dao.getById(id));
                req.getRequestDispatcher("/WEB-INF/View/admin/ingredients/edit.jsp").forward(req, resp);
                return;
            }

            if (dao.update(ing)) {
                AuditLogger.log(currentUserId, "UPDATE", "Ingredients", id, "Updated ingredient: " + name);
                resp.sendRedirect("ingredients?message=updated");
            } else {
                req.setAttribute("errorMessage", "❌ Update failed!");
                req.getRequestDispatcher("/WEB-INF/View/admin/ingredients/edit.jsp").forward(req, resp);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Ingredient management with audit logging (clean version)";
    }
}
