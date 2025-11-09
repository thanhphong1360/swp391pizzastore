/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.DiscountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import model.Discount;

/**
 *
 * @author HP
 */
@WebServlet(name = "EditDiscountServlet", urlPatterns = {"/EditDiscountServlet"})
public class EditDiscountServlet extends HttpServlet {

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
            out.println("<title>Servlet EditDiscountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditDiscountServlet at " + request.getContextPath() + "</h1>");
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
        try {
            int id = Integer.parseInt(request.getParameter("discount_id"));
            DiscountDAO dao = new DiscountDAO();
            Discount d = dao.getDiscountById(id);

            if (d == null) {
                request.setAttribute("error", "Discount not found!");
                request.getRequestDispatcher("/WEB-INF/View/manager/discount/detail-discount.jsp").forward(request, response);
                return;
            }

            String code = request.getParameter("code");
            String description = request.getParameter("description");
            String type = request.getParameter("type");
            String valueStr = request.getParameter("value");
            String startDateStr = request.getParameter("start_date");
            String endDateStr = request.getParameter("end_date");
            String minInvoiceStr = request.getParameter("min_invoice_price");
            String maxDiscountStr = request.getParameter("max_discount_amount");
            String statusStr = request.getParameter("status");

            if (code == null || code.trim().isEmpty() ||
                description == null || description.trim().isEmpty() ||
                type == null || type.trim().isEmpty() ||
                valueStr == null || valueStr.trim().isEmpty() ||
                startDateStr == null || endDateStr == null ||
                minInvoiceStr == null || maxDiscountStr == null ||
                statusStr == null) {
                request.setAttribute("error", "Please fill out all required fields.");
                request.setAttribute("discount", d);
                request.getRequestDispatcher("/WEB-INF/View/manager/discount/detail-discount.jsp").forward(request, response);
                return;
            }

            double value = Double.parseDouble(valueStr);
            java.sql.Date startDate = Date.valueOf(startDateStr);
            java.sql.Date endDate = Date.valueOf(endDateStr);
            double minInvoicePrice = Double.parseDouble(minInvoiceStr);
            double maxDiscountAmount = Double.parseDouble(maxDiscountStr);
            boolean status = Boolean.parseBoolean(statusStr);

            // Check for negative values
            if (value < 0 || minInvoicePrice < 0 || maxDiscountAmount < 0) {
                request.setAttribute("error", "Value, Minimum Invoice Price, and Maximum Discount Amount must be non-negative.");
                request.setAttribute("discount", d);
                request.getRequestDispatcher("/WEB-INF/View/manager/discount/detail-discount.jsp").forward(request, response);
                return;
            }

            d.setCode(code);
            d.setDescription(description);
            d.setType(type);
            d.setValue(value);
            d.setStartDate(startDate);
            d.setEndDate(endDate);
            d.setMinInvoicePrice(minInvoicePrice);
            d.setMaxDiscountAmount(maxDiscountAmount);
            d.setStatus(status);

            dao.update(d);
            response.sendRedirect(request.getContextPath() + "/manager/discount/list");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Edit discount failed: " + e.getMessage());
            request.setAttribute("discount", new Discount()); // Placeholder to avoid null
            request.getRequestDispatcher("/WEB-INF/View/manager/discount/detail-discount.jsp").forward(request, response);
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
