/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.InvoiceDAO;
import dal.InvoiceTableDAO;
import dal.OrderDAO;
import dal.OrderFoodDAO;
import dal.TableDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import model.Invoice;
import model.InvoiceTable;
import model.Order;
import model.OrderFood;

/**
 *
 * @author cungp
 */
public class CashierInvoiceServlet extends HttpServlet {

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
            out.println("<title>Servlet CashierInvoiceServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CashierInvoiceServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        if ("checkoutList".equals(action)) {
            String status = request.getParameter("status");
            if ("pending".equals(status) || status == null) {
                ArrayList<Invoice> pendingInvoiceList = InvoiceDAO.getInvoicesByStatusCashier("pending");
                request.setAttribute("invoiceList", pendingInvoiceList);
                request.getRequestDispatcher("/WEB-INF/View/Cashier/CashierInvoiceCheckoutList.jsp").forward(request, response);
            } else if ("paid".equals(status)) {
                ArrayList<Invoice> pendingInvoiceList = InvoiceDAO.getInvoicesByStatusCashier("paid");
                request.setAttribute("invoiceList", pendingInvoiceList);
                request.getRequestDispatcher("/WEB-INF/View/Cashier/CashierInvoiceCheckoutList.jsp").forward(request, response);
            } else if ("cancelled".equals(status)) {
                ArrayList<Invoice> pendingInvoiceList = InvoiceDAO.getInvoicesByStatusCashier("cancelled");
                request.setAttribute("invoiceList", pendingInvoiceList);
                request.getRequestDispatcher("/WEB-INF/View/Cashier/CashierInvoiceCheckoutList.jsp").forward(request, response);
            }
        } else if ("detail".equals(action)) {
            int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
            Invoice invoice = InvoiceDAO.getInvoiceById(invoiceId);
            //lay danh sach order trong invoice
            ArrayList<Order> orderList = OrderDAO.getOrdersByInvoiceId(invoiceId);
            //dung iterator de remove rejected order
            Iterator<Order> iterator = orderList.iterator();
            while (iterator.hasNext()) {
                Order order = iterator.next();
                if ("rejected".equals(order.getStatus())) {
                    iterator.remove(); // ✅ Hợp lệ
                    continue;          // bỏ qua order này
                }
                order.includeOrderFood();
                order.includeTable();
                if (order.getOrderFoodList() != null) {
                    for (OrderFood orderFood : order.getOrderFoodList()) {
                        orderFood.includeFood();
                    }
                }
            }
            request.setAttribute("invoice", invoice);
            request.setAttribute("orderList", orderList);
            request.getRequestDispatcher("/WEB-INF/View/Cashier/CashierInvoiceDetail.jsp").forward(request, response);

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
        String action = request.getParameter("action");
        if ("checkoutForm".equals(action)) {
            int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
            Invoice invoice = InvoiceDAO.getInvoiceById(invoiceId);
            //lay danh sach order trong invoice
            ArrayList<Order> orderList = OrderDAO.getOrdersByInvoiceId(invoiceId);

            //tinh price cho invoice
            BigDecimal price = BigDecimal.ZERO;

            //dung iterator de remove rejected order
            Iterator<Order> iterator = orderList.iterator();
            while (iterator.hasNext()) {
                Order order = iterator.next();
                if ("rejected".equals(order.getStatus())) {
                    iterator.remove(); // ✅ Hợp lệ
                    continue;          // bỏ qua order này
                }
                order.includeOrderFood();
                order.includeTable();
                if (order.getOrderFoodList() != null) {
                    for (OrderFood orderFood : order.getOrderFoodList()) {
                        orderFood.includeFood();
                    }
                }

                price = price.add(order.getPrice());
            }

            invoice.setPrice(price);
            invoice = InvoiceDAO.updateInvoicePrice(invoice);

            //gui danh sach order len de xem
            request.setAttribute("invoice", invoice);
            request.setAttribute("orderList", orderList);
            request.getRequestDispatcher("/WEB-INF/View/Cashier/CashierInvoiceCheckoutForm.jsp").forward(request, response);
        } else if ("checkout".equals(action)) {
            int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
            boolean canCheckout = true;
            Invoice invoice = InvoiceDAO.getInvoiceById(invoiceId);
            //lay danh sach order trong invoice
            ArrayList<Order> orderList = OrderDAO.getOrdersByInvoiceId(invoiceId);
            //kiem tra co order dang lam hay khong
            for (Order order : orderList) {
                ArrayList<OrderFood> orderFoodList = OrderFoodDAO.getOrderFoodsByOrderId(order.getOrderId());
                //kiem tra xem co order food khong, neu khong thi cancel invoice
                if (orderFoodList == null) {
                    //change invoice status
                    invoice = InvoiceDAO.updateInvoiceStatus(invoice, "cancelled");
                    //get tables lien quan toi invoice
                    ArrayList<InvoiceTable> invoiceTableList = InvoiceTableDAO.getTableIdsByInvoiceId(invoiceId);
                    //tra table ve available
                    for (InvoiceTable invoiceTable : invoiceTableList) {
                        TableDAO.updateTableStatus(TableDAO.getTableById(invoiceTable.getTableId()), "Available");
                    }
                    //view pending invoice list
                    ArrayList<Invoice> pendingInvoiceList = InvoiceDAO.getInvoicesByStatusCashier("pending");
                    request.setAttribute("invoiceList", pendingInvoiceList);
                    request.getRequestDispatcher("/WEB-INF/View/Cashier/CashierInvoiceCheckoutList.jsp").forward(request, response);
                    return;
                }
                for (OrderFood orderFood : orderFoodList) {
                    if (orderFood.getStatus().equals("pending") || orderFood.getStatus().equals("doing")) {
                        canCheckout = false;
                        break;
                    }
                }
            }
            if (canCheckout) {
                //change invoice status
                invoice = InvoiceDAO.updateInvoiceStatus(invoice, "paid");
                //get tables lien quan toi invoice
                ArrayList<InvoiceTable> invoiceTableList = InvoiceTableDAO.getTableIdsByInvoiceId(invoiceId);
                //tra table ve available
                for (InvoiceTable invoiceTable : invoiceTableList) {
                    TableDAO.updateTableStatus(TableDAO.getTableById(invoiceTable.getTableId()), "Available");
                }
                //view pending invoice list
                ArrayList<Invoice> pendingInvoiceList = InvoiceDAO.getInvoicesByStatusCashier("pending");
                request.setAttribute("invoiceList", pendingInvoiceList);
                request.getRequestDispatcher("/WEB-INF/View/Cashier/CashierInvoiceCheckoutList.jsp").forward(request, response);
            } else {
                //tinh price cho invoice
                BigDecimal price = BigDecimal.ZERO;
                Iterator<Order> iterator = orderList.iterator();
                while (iterator.hasNext()) {
                    Order order = iterator.next();
                    if ("rejected".equals(order.getStatus())) {
                        iterator.remove(); // ✅ Hợp lệ
                        continue;          // Không return, chỉ bỏ qua order này
                    }
                    order.includeOrderFood();
                    order.includeTable();
                    for (OrderFood orderFood : order.getOrderFoodList()) {
                        orderFood.includeFood();
                    }
                    price = price.add(order.getPrice());
                }

                invoice.setPrice(price);
                invoice = InvoiceDAO.updateInvoicePrice(invoice);

                //gui danh sach order len de xem
                request.setAttribute("invoice", invoice);
                request.setAttribute("orderList", orderList);

                String error = "Hóa đơn có order chưa hoàn thành, hãy hoàn thành tất cả order trong hóa đơn!";
                request.setAttribute("error", error);
                request.getRequestDispatcher("/WEB-INF/View/Cashier/CashierInvoiceCheckoutForm.jsp").forward(request, response);
            }
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
