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
        if (action == null) action = "list";

        switch (action) {
            case "add":
                req.getRequestDispatcher("/view/admin/ingredients/add.jsp").forward(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("ingredients", dao.getById(id));
                req.getRequestDispatcher("/view/admin/ingredients/edit.jsp").forward(req, resp);
                break;
            case "delete":
                dao.delete(Integer.parseInt(req.getParameter("id")));
                resp.sendRedirect("ingredients");
                break;
            default:
                List<Ingredient> list = dao.getAll();
                req.setAttribute("list", list);
                req.getRequestDispatcher("/view/admin/ingredients/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            Ingredient ing = new Ingredient();
            ing.setName(req.getParameter("name"));
            ing.setDescription(req.getParameter("description"));
            ing.setUnit(req.getParameter("unit"));
            ing.setQuantity(Double.parseDouble(req.getParameter("quantity")));
            dao.insert(ing);
            resp.sendRedirect("ingredients");
        } else if ("edit".equals(action)) {
            Ingredient ing = new Ingredient();
            ing.setIngredientId(Integer.parseInt(req.getParameter("id")));
            ing.setName(req.getParameter("name"));
            ing.setDescription(req.getParameter("description"));
            ing.setUnit(req.getParameter("unit"));
            ing.setQuantity(Double.parseDouble(req.getParameter("quantity")));
            dao.update(ing);
            resp.sendRedirect("ingredients");
        }
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
