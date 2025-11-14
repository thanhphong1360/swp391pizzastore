/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.OrderDAO;
import dal.PaymentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import model.Payment;
import java.sql.SQLException;

/**
 *
 * @author HP
 */
@WebServlet(name = "PaymentResultServlet", urlPatterns = {"/payment-result"})
public class PaymentResultServlet extends HttpServlet {

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
            out.println("<title>Servlet PaymentResultServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaymentResultServlet at " + request.getContextPath() + "</h1>");
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
    private final PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String gateway = request.getParameter("gateway");
        String status = request.getParameter("status");
        String orderIdStr = request.getParameter("orderId");
        String amountStr = request.getParameter("amount");

        // === 1. Validate input ===
        if (isEmpty(gateway) || isEmpty(status) || isEmpty(orderIdStr) || isEmpty(amountStr)) {
            forwardToFailed(request, response, orderIdStr, amountStr, gateway, "Dữ liệu không hợp lệ.");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr.trim());
            BigDecimal amount = new BigDecimal(amountStr.trim());

            // === 2. Kiểm tra thanh toán trùng ===
            if (paymentDAO.existsByOrderId(orderId)) {
                forwardToFailed(request, response, orderId, amount, gateway, "Đơn hàng đã được thanh toán trước đó!");
                return;
            }
            
            // === 3. Lưu thanh toán ===
            String paymentStatus = "Success".equalsIgnoreCase(status) ? "Success" : "Failed";
            Payment payment = new Payment(orderId, gateway, amount, paymentStatus);
            paymentDAO.insert(payment);

            // === 4. Chuyển hướng theo trạng thái ===
            if ("Success".equals(paymentStatus)) {
                forwardToSuccess(request, response, orderId, amount, gateway);
                // Cập nhật Orders
                OrderDAO orderDAO = new OrderDAO();
                orderDAO.updatePaymentStatus(orderId, payment.getPaymentId(), "Paid");
            } else {
                forwardToFailed(request, response, orderId, amount, gateway, "Thanh toán thất bại.");
            }

        } catch (NumberFormatException e) {
            forwardToFailed(request, response, orderIdStr, amountStr, gateway, "Số tiền hoặc mã đơn không hợp lệ.");
        } catch (SQLException e) {
            e.printStackTrace();
            forwardToFailed(request, response, orderIdStr, amountStr, gateway, "Lỗi hệ thống: " + e.getMessage());
        }
    }

    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }

    // === Chuyển đến trang thành công ===
    private void forwardToSuccess(HttpServletRequest request, HttpServletResponse response,
            int orderId, BigDecimal amount, String gateway)
            throws ServletException, IOException {
        request.setAttribute("orderId", orderId);
        request.setAttribute("amount", amount);
        request.setAttribute("gateway", gateway);
        request.getRequestDispatcher("/WEB-INF/View/payment/payment-success.jsp").forward(request, response);
    }

    // === Chuyển đến trang thất bại ===
    private void forwardToFailed(HttpServletRequest request, HttpServletResponse response,
            Object orderId, Object amount, Object gateway, String error)
            throws ServletException, IOException {
        request.setAttribute("orderId", orderId);
        request.setAttribute("amount", amount);
        request.setAttribute("gateway", gateway);
        request.setAttribute("error", error);
        request.getRequestDispatcher("/WEB-INF/View/payment/payment-failed.jsp").forward(request, response);
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
