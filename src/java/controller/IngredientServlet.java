/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.IngredientDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Ingredient;
import java.util.List;

@WebServlet("/ingredients")
public class IngredientServlet extends HttpServlet {

    private IngredientDAO dao = new IngredientDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                req.getRequestDispatcher("WEB-INF/View/admin/ingredients/add.jsp").forward(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("ingredient", dao.getById(id));
                req.getRequestDispatcher("WEB-INF/View/admin/ingredients/edit.jsp").forward(req, resp);
                break;

            case "toggle": {
                // Bọc trong block, đặt tên biến rõ ràng
                int toggleId = Integer.parseInt(req.getParameter("id"));
                Ingredient target = dao.getById(toggleId);

                if (target == null) {
                    // nếu không tìm thấy -> redirect với lỗi
                    resp.sendRedirect("ingredients?message=error");
                    break;
                }

                boolean currentStatus = target.isStatus();
                boolean updated = dao.updateStatus(toggleId, !currentStatus); // đảm bảo dao có method updateStatus

                if (updated) {
                    if (currentStatus) {
                        resp.sendRedirect("ingredients?message=deactivated");
                    } else {
                        resp.sendRedirect("ingredients?message=restored");
                    }
                } else {
                    resp.sendRedirect("ingredients?message=error");
                }
                break;
            }
            case "chef":
                List<Ingredient> listChef = dao.getAll();
                req.setAttribute("list", listChef);
                req.getRequestDispatcher("WEB-INF/View/admin/ingredients/chefview.jsp").forward(req, resp);
                break;

            default:
                List<Ingredient> list = dao.getAll();
                req.setAttribute("list", list);
                req.getRequestDispatcher("WEB-INF/View/admin/ingredients/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("updateQuantity".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                double newQuantity = Double.parseDouble(req.getParameter("quantity"));

                if (newQuantity < 0) {
                    resp.sendRedirect("ingredients?message=invalidQuantity");
                    return;
                }

                boolean updated = dao.updateQuantity(id, newQuantity);
                if (updated) {
                    resp.sendRedirect("ingredients?action=chef&message=quantityUpdated");
                } else {
                    resp.sendRedirect("ingredients?action=chef&message=error");
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect("ingredients?action=chef&message=error");
            }
            return; // ⚠️ Dừng lại, không cho chạy tiếp các phần add/edit
        }
        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String unit = req.getParameter("unit");
        String quantityStr = req.getParameter("quantity");
        String statusStr = req.getParameter("status"); // 🔹 thêm dòng này

        String error = null;
        double quantity = 0;

        if (name == null || name.trim().isEmpty() || name.length() > 50) {
            error = "❌ Name must be between 1–50 characters.";
        } else if (description != null && description.length() > 200) {
            error = "❌ Description cannot exceed 200 characters.";
        } else if (unit == null || unit.trim().isEmpty() || unit.length() > 10) {
            error = "❌ Unit must be between 1–10 characters.";
        } else {
            try {
                quantity = Double.parseDouble(quantityStr);
                if (quantity < 0) {
                    error = "❌ Quantity must be a positive number.";
                }
            } catch (NumberFormatException e) {
                error = "❌ Invalid quantity value.";
            }
        }

        if (error != null) {
            req.setAttribute("errorMessage", error);
            if ("edit".equals(action)) {
                int id = Integer.parseInt(idStr);
                req.setAttribute("ingredient", dao.getById(id));
                req.getRequestDispatcher("WEB-INF/View/admin/ingredients/edit.jsp").forward(req, resp);
            } else {
                req.getRequestDispatcher("WEB-INF/View/admin/ingredients/add.jsp").forward(req, resp);
            }
            return;
        }

        // 🔹 Xử lý object Ingredient
        Ingredient ing = new Ingredient();
        ing.setName(name.trim());
        ing.setDescription(description != null ? description.trim() : "");
        ing.setUnit(unit.trim());
        ing.setQuantity(quantity);
        // Nếu đang edit, giữ lại status hiện có trong DB khi form không gửi status
        if ("edit".equals(action)) {
            int id = Integer.parseInt(idStr);
            Ingredient existing = dao.getById(id);
            boolean keepStatus = (statusStr == null); // true nếu form không gửi status
            if (existing != null) {
                if (keepStatus) {
                    ing.setStatus(existing.isStatus()); // giữ nguyên
                } else {
                    ing.setStatus("1".equals(statusStr));
                }
            } else {
                // fallback: nếu không tìm thấy existing thì mặc định active
                ing.setStatus("1".equals(statusStr));
            }
        } else {
            // add case: nếu không có status field, mặc định active
            if (statusStr == null) {
                ing.setStatus(true);
            } else {
                ing.setStatus("1".equals(statusStr));
            }
        }

        // 🔸 Thêm mới
        if ("add".equals(action)) {

            if (dao.existsByName(name)) {
                req.setAttribute("errorMessage", "❌ Ingredient name already exists!");
                req.getRequestDispatcher("WEB-INF/View/admin/ingredients/add.jsp").forward(req, resp);
                return;
            }

            dao.insert(ing);
            resp.sendRedirect("ingredients?message=added");

            // 🔸 Sửa
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(idStr);
            ing.setIngredientId(id);

            if (dao.existsByNameExceptId(name, id)) {
                req.setAttribute("errorMessage", "❌ Ingredient name already exists!");
                req.setAttribute("ingredient", dao.getById(id));
                req.getRequestDispatcher("WEB-INF/View/admin/ingredients/edit.jsp").forward(req, resp);
                return;
            }

            dao.update(ing);
            resp.sendRedirect("ingredients?message=updated");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
