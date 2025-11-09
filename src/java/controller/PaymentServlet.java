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
        request.setAttribute("orderId", 3);
        request.setAttribute("customerName", "Test User");
        request.setAttribute("totalAmount", 447000.00);

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
        String amountStr = request.getParameter("amount");
        String discountCode = request.getParameter("discountCode");

        // Validate
        if (orderIdStr == null || amountStr == null || method == null) {
            setError(request, "Thiếu thông tin thanh toán.");
            forwardToCheckout(request, response, orderIdStr, "Khách hàng", amountStr);
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            BigDecimal totalAmount = new BigDecimal(amountStr);

            // Áp dụng mã giảm giá
            BigDecimal discountAmount = BigDecimal.ZERO;
            String discountMsg = null;

            if (discountCode != null && !discountCode.trim().isEmpty()) {
                if ("TEST10".equalsIgnoreCase(discountCode.trim())) {
                    discountAmount = totalAmount.multiply(new BigDecimal("0.1"));
                    discountMsg = "Giảm 10% thành công!";
                } else {
                    discountMsg = "Mã giảm giá không hợp lệ.";
                }
            }

            BigDecimal finalAmount = totalAmount.subtract(discountAmount);

            // Forward
            request.setAttribute("orderId", orderId);
            request.setAttribute("amount", finalAmount);
            request.setAttribute("gateway", method);
            request.setAttribute("discountMsg", discountMsg);
            request.setAttribute("originalAmount", totalAmount);

            String view = method.equalsIgnoreCase("VNPay")
                    ? "/WEB-INF/View/payment/vnpay.jsp"
                    : "/WEB-INF/View/payment/momo.jsp";

            request.getRequestDispatcher(view).forward(request, response);

        } catch (NumberFormatException e) {
            setError(request, "Số tiền không hợp lệ.");
            forwardToCheckout(request, response, orderIdStr, "Khách hàng", amountStr);
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
