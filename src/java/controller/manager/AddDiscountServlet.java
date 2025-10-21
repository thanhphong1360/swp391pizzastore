/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.DiscountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.Date;
import model.Discount;

/**
 *
 * @author HP
 */
@WebServlet(name = "AddDiscountServlet", urlPatterns = {"/manager/discount/add-discount"})
public class AddDiscountServlet extends HttpServlet {

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
            out.println("<title>Servlet AddDiscountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddDiscountServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/WEB-INF/View/manager/discount/add-discount.jsp").forward(request, response);
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
        try {
            Discount d = new Discount();
            d.setCode(request.getParameter("code"));
            d.setDescription(request.getParameter("description"));
            d.setType(request.getParameter("type"));
            d.setValue(Double.parseDouble(request.getParameter("value")));
            d.setStartDate(Date.valueOf(request.getParameter("start_date")));
            d.setEndDate(Date.valueOf(request.getParameter("end_date")));
            d.setMinInvoicePrice(Double.parseDouble(request.getParameter("min_invoice_price")));
            d.setMaxDiscountAmount(Double.parseDouble(request.getParameter("max_discount_amount")));
            d.setStatus(Boolean.parseBoolean(request.getParameter("status")));

            DiscountDAO dao = new DiscountDAO();
            dao.insert(d);
            response.sendRedirect(request.getContextPath() + "/manager/discount/list");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Add discount failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/View/manager/discount/add-discount.jsp").forward(request, response);
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
