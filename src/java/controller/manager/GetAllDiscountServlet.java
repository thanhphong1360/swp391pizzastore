/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.DiscountDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.PrintWriter;
import model.Discount;

/**
 *
 * @author HP
 */
@WebServlet(name = "GetAllDiscountServlet", urlPatterns = {"/manager/discount/list"})
public class GetAllDiscountServlet extends HttpServlet {

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
            out.println("<title>Servlet ListDiscountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListDiscountServlet at " + request.getContextPath() + "</h1>");
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
        DiscountDAO dao = new DiscountDAO();

        // 1. Cập nhật trạng thái hết hạn (trước khi phân trang)
        java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
        dao.updateExpiredDiscounts(currentDate);

        // 2. Xử lý tìm kiếm
        String search = request.getParameter("search");
        if (search != null && search.trim().isEmpty()) {
            search = null;
        }

        // 3. Phân trang
        int pageSize = 10;
        int currentPage = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageStr);
                if (currentPage < 1) {
                    currentPage = 1;
                }
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        List<Discount> discounts;
        int totalItems;

        if (search == null) {
            discounts = dao.getAll(currentPage, pageSize);
            totalItems = dao.getTotalCount();
        } else {
            discounts = dao.getBySearch(search, currentPage, pageSize);
            totalItems = dao.getTotalCountBySearch(search);
        }

        int totalPages = totalItems == 0 ? 1 : (int) Math.ceil((double) totalItems / pageSize);

        // Set attributes
        request.setAttribute("discounts", discounts);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("search", search);

        request.getRequestDispatcher("/WEB-INF/View/manager/discount/list-discount.jsp")
                .forward(request, response);
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
        processRequest(request, response);
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
