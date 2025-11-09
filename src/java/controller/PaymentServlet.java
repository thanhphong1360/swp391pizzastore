/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;

/**
 *
 * @author HP
 */
@WebServlet(name = "PaymentServlet", urlPatterns = {"/payment"})
public class PaymentServlet extends HttpServlet {

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
            out.println("<title>Servlet PaymentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaymentServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/WEB-INF/View/payment/checkout.jsp").forward(request, response);
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
        String method = request.getParameter("method");
        String orderIdStr = request.getParameter("orderId");
        String amountStr = request.getParameter("totalAmount"); // ← Đổi tên cho rõ
        String customerName = request.getParameter("customerName");
        String discountCode = request.getParameter("discountCode");

        // Validate
        if (orderIdStr == null || amountStr == null || method == null || customerName == null) {
            request.setAttribute("error", "Thiếu thông tin thanh toán. Vui lòng thử lại.");
            request.getRequestDispatcher("/WEB-INF/View/payment/checkout.jsp").forward(request, response);
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            BigDecimal totalAmount = new BigDecimal(amountStr);

            // Xử lý discount...
            BigDecimal finalAmount = totalAmount; // sau khi giảm

            // Forward với đầy đủ dữ liệu
            request.setAttribute("orderId", orderId);
            request.setAttribute("customerName", customerName);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("amount", finalAmount);
            request.setAttribute("gateway", method);

            String view = method.equalsIgnoreCase("VNPay")
                    ? "/WEB-INF/View/payment/vnpay.jsp"
                    : "/WEB-INF/View/payment/momo.jsp";

            request.getRequestDispatcher(view).forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Số tiền không hợp lệ.");
            request.getRequestDispatcher("/WEB-INF/View/payment/checkout.jsp").forward(request, response);
        }

    }

    private void setError(HttpServletRequest request, String msg) {
        request.setAttribute("error", msg);
    }

    private void forwardToCheckout(HttpServletRequest request, HttpServletResponse response,
            String orderId, String customer, String amount)
            throws ServletException, IOException {
        request.setAttribute("orderId", orderId);
        request.setAttribute("customerName", customer);
        request.setAttribute("totalAmount", amount);
        request.getRequestDispatcher("/WEB-INF/View/payment/checkout.jsp").forward(request, response);
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
