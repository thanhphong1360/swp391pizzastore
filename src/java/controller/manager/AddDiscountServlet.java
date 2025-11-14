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
            // Lấy dữ liệu
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            String type = request.getParameter("type");
            String valueStr = request.getParameter("value");
            String startDateStr = request.getParameter("start_date");
            String endDateStr = request.getParameter("end_date");
            String minInvoiceStr = request.getParameter("min_invoice_price");
            String maxDiscountStr = request.getParameter("max_discount_amount");
            String statusStr = request.getParameter("status");

            // Validate
            if (code == null || code.trim().isEmpty() || description == null || description.trim().isEmpty()
                    || type == null || valueStr == null || startDateStr == null || endDateStr == null
                    || minInvoiceStr == null || maxDiscountStr == null || statusStr == null) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin.");
                request.getRequestDispatcher("/WEB-INF/View/manager/discount/add-discount.jsp").forward(request, response);
                return;
            }

            double value = Double.parseDouble(valueStr);
            Date startDate = Date.valueOf(startDateStr);
            Date endDate = Date.valueOf(endDateStr);
            double minInvoice = Double.parseDouble(minInvoiceStr);
            double maxDiscount = Double.parseDouble(maxDiscountStr);
            boolean status = Boolean.parseBoolean(statusStr);

            if (value < 0 || minInvoice < 0 || maxDiscount < 0) {
                request.setAttribute("error", "Giá trị không được âm.");
                request.getRequestDispatcher("/WEB-INF/View/manager/discount/add-discount.jsp").forward(request, response);
                return;
            }

            if (!startDate.before(endDate)) {
                request.setAttribute("error", "Ngày bắt đầu phải trước ngày kết thúc.");
                request.setAttribute("code", code);
                request.setAttribute("description", description);
                request.setAttribute("type", type);
                request.setAttribute("value", valueStr);
                request.setAttribute("start_date", startDateStr);
                request.setAttribute("end_date", endDateStr);
                request.setAttribute("min_invoice_price", minInvoiceStr);
                request.setAttribute("max_discount_amount", maxDiscountStr);
                request.setAttribute("status", statusStr);
                request.getRequestDispatcher("/WEB-INF/View/manager/discount/add-discount.jsp").forward(request, response);
                return;
            }

            DiscountDAO dao = new DiscountDAO();
            if (dao.checkIfCodeExists(code)) {
                request.setAttribute("error", "Mã giảm giá đã tồn tại.");
                request.getRequestDispatcher("/WEB-INF/View/manager/discount/add-discount.jsp").forward(request, response);
                return;
            }

            Discount d = new Discount();
            d.setCode(code);
            d.setDescription(description);
            d.setType(type);
            d.setValue(value);
            d.setStartDate(startDate);
            d.setEndDate(endDate);
            d.setMinInvoicePrice(minInvoice);
            d.setMaxDiscountAmount(maxDiscount);
            d.setStatus(status);

            boolean success = dao.insert(d);
            response.sendRedirect(request.getContextPath() + "/manager/discount/list"
                    + (success ? "?msg=add_success" : "?error=add_failed"));

        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
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
