package controller;

import dal.AuditLogDAO;
import dal.IngredientDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.AuditLog;
import model.Ingredient;

@WebServlet("/chef-ingredients")
public class ChefIngredientServlet extends HttpServlet {

    private IngredientDAO dao = new IngredientDAO();
    private AuditLogDAO logDAO = new AuditLogDAO();

    private void writeLog(Integer userId, String action, String table, Integer targetId, String desc) {
        AuditLog log = new AuditLog();
        log.setUserId(userId);
        log.setActionType(action);
        log.setTargetTable(table);
        log.setTargetId(targetId);
        log.setDescription(desc);
        logDAO.insert(log);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Ingredient> list = dao.getAll();
        req.setAttribute("list", list);
        req.getRequestDispatcher("WEB-INF/View/Chef/chefview.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        Integer currentUserId = (Integer) session.getAttribute("userId");

        String action = req.getParameter("action");

        if ("updateQuantity".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                double newQuantity = Double.parseDouble(req.getParameter("quantity"));

                if (newQuantity < 0) {
                    resp.sendRedirect("chef-ingredients?message=invalidQuantity");
                    return;
                }

                boolean updated = dao.updateQuantity(id, newQuantity);
                if (updated) {
                    Ingredient ing = dao.getById(id);
                    writeLog(currentUserId, "UPDATE_QUANTITY", "Ingredients", id,
                            "Chef updated quantity of ingredient: " + ing.getName() + " → " + newQuantity);
                    resp.sendRedirect("chef-ingredients?message=quantityUpdated");
                } else {
                    resp.sendRedirect("chef-ingredients?message=error");
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect("chef-ingredients?message=error");
            }
        }
    }
}
