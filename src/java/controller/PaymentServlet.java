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
        // TEST DATA - XÓA KHI GHÉP VÀO HỆ THỐNG THẬT
        //khach1@gmail.com
        //khach123
        request.setAttribute("orderId", 11);
        request.setAttribute("customerName", "Nguyễn Văn B");
        request.setAttribute("totalAmount", new BigDecimal("178000"));
        request.setAttribute("discountCode", "");
        request.setAttribute("discountAmount", BigDecimal.ZERO);
        request.setAttribute("finalAmount", new BigDecimal("178000"));

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
        String amountStr = request.getParameter("totalAmount");

        if (isEmpty(method) || isEmpty(orderIdStr) || isEmpty(amountStr)) {
            request.setAttribute("error", "Thiếu thông tin thanh toán.");
            forwardToCheckout(request, response);
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            BigDecimal amount = new BigDecimal(amountStr);

            // Lưu vào request để momo.jsp / vnpay.jsp dùng
            request.setAttribute("orderId", orderId);
            request.setAttribute("amount", amount);
            request.setAttribute("gateway", method); // MoMo hoặc VNPay

            String view = "Momo".equalsIgnoreCase(method)
                    ? "/WEB-INF/View/payment/momo.jsp"
                    : "/WEB-INF/View/payment/vnpay.jsp";

            request.getRequestDispatcher(view).forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Số tiền không hợp lệ.");
            forwardToCheckout(request, response);
        }
    }

    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }

    private void setError(HttpServletRequest request, String msg) {
        request.setAttribute("error", msg);
    }

    private void forwardToCheckout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
