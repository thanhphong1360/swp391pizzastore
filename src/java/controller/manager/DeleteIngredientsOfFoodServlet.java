/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.FoodIngredientDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Dystopia
 */
@WebServlet(name = "DeleteIngredientsOfFoodServlet", urlPatterns = {"/manager/DeleteIngredientsOfFoodServlet"})
public class DeleteIngredientsOfFoodServlet extends HttpServlet {

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
            out.println("<title>Servlet DeleteIngredientsOfFoodServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteIngredientsOfFoodServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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

        try {
            // Xóa nguyên liệu khỏi bảng FoodIngredients
            boolean deleted = FoodIngredientDAO.deleteIngredient(foodId, ingredientId);

            // Kiểm tra xem nguyên liệu có bị xóa thành công hay không
            if (deleted) {
                // Nếu xóa thành công, lưu thông báo thành công vào session
                HttpSession session = request.getSession();
                session.setAttribute("message", "Xóa nguyên liệu thành công.");
                session.setAttribute("messageType", "success");
            } else {
                // Nếu xóa thất bại, lưu thông báo thất bại vào session
                HttpSession session = request.getSession();
                session.setAttribute("message", "Không thể xóa nguyên liệu. Vui lòng thử lại.");
                session.setAttribute("messageType", "error");
            }

            // Chuyển hướng về trang quản lý nguyên liệu của món ăn
            response.sendRedirect(request.getContextPath() + "/manager/ViewIngredientsOfFoodServlet?foodId=" + foodId);
        } catch (Exception e) {
            e.printStackTrace();

            // Nếu có lỗi khi xóa, lưu thông báo lỗi vào session
            HttpSession session = request.getSession();
            session.setAttribute("message", "Có lỗi xảy ra khi xóa nguyên liệu.");
            session.setAttribute("messageType", "error");

            // Chuyển hướng về trang quản lý nguyên liệu của món ăn
            response.sendRedirect(request.getContextPath() + "/manager/ViewIngredientsOfFoodServlet?foodId=" + foodId);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
