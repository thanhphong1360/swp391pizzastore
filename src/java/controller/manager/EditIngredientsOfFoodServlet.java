/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.FoodIngredientDAO;
import dal.MenuDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Ingredient;
import model.Menu;

/**
 *
 * @author Dystopia
 */
@WebServlet(name = "EditIngredientsOfFoodServlet", urlPatterns = {"/manager/EditIngredientsOfFoodServlet"})
public class EditIngredientsOfFoodServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditIngredientsOfFoodServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditIngredientsOfFoodServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("user") != null) {
            int ingredientId = Integer.parseInt(request.getParameter("ingredientId"));
        int foodId = Integer.parseInt(request.getParameter("foodId"));
        
        // Lấy thông tin nguyên liệu và số lượng từ bảng FoodIngredients
        Ingredient ingredient = FoodIngredientDAO.getIngredientByFoodIdAndIngredientId(foodId, ingredientId);
        Menu menu = MenuDAO.getFoodById(foodId);  // Lấy thông tin món ăn

        // Truyền dữ liệu vào request để gửi tới JSP
        request.setAttribute("ingredient", ingredient);
        request.setAttribute("menu", menu);

        // Chuyển hướng tới trang sửa nguyên liệu
        request.getRequestDispatcher("/WEB-INF/View/manager/EditIngredientsOfFood.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int foodId = Integer.parseInt(request.getParameter("foodId"));
        int ingredientId = Integer.parseInt(request.getParameter("ingredientId"));
        double quantity = Double.parseDouble(request.getParameter("quantity"));
        
        // Cập nhật số lượng trong bảng FoodIngredients
        try {
            FoodIngredientDAO.updateIngredientQuantity(foodId, ingredientId, quantity);
            // Nếu không xảy ra lỗi, chuyển hướng về trang hiển thị nguyên liệu của món ăn
            response.sendRedirect("ViewIngredientsOfFoodServlet?foodId=" + foodId);
        } catch (Exception e) {
            // Nếu có lỗi, thông báo lỗi cho người dùng
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật số lượng nguyên liệu!");
            request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
