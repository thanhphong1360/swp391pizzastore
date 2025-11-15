/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DiscountDAO;
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
import java.util.List;
import model.Discount;
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
            
            invoice.setFinalPrice(price);
            invoice.setDicountId(0);
            double invoicePrice = price.doubleValue();
            List<Discount> discountList = DiscountDAO.getApplicableDiscounts(invoicePrice);

            request.setAttribute("discountList", discountList);

            //gui danh sach order len de xem
            request.setAttribute("invoice", invoice);
            request.setAttribute("orderList", orderList);
            request.getRequestDispatcher("/WEB-INF/View/Cashier/CashierInvoiceCheckoutForm.jsp").forward(request, response);
        } else if ("checkout".equals(action)) {
            int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
            
            String discountIdRaw = request.getParameter("discountId");
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
                BigDecimal price = BigDecimal.ZERO;
                Iterator<Order> iterator = orderList.iterator();
                while (iterator.hasNext()) {
                    Order order = iterator.next();
                    if ("rejected".equals(order.getStatus())) {
                        iterator.remove();
                        continue;
                    }
                    order.includeOrderFood();
                    order.includeTable();
                    for (OrderFood orderFood : order.getOrderFoodList()) {
                        orderFood.includeFood();
                    }
                    price = price.add(order.getPrice());
                }

                double invoicePrice = price.doubleValue();
                double finalPrice = invoicePrice; // mặc định chưa giảm
                double discountAmount = 0;
                int discountIdToSave = 0;

                // Viet: ÁP DỤNG DISCOUNT NẾU CÓ CHỌN
                if (discountIdRaw != null && !discountIdRaw.isEmpty()) {
                    try {
                        int discountId = Integer.parseInt(discountIdRaw);
                        DiscountDAO disDAO = new DiscountDAO();
                        Discount d = disDAO.getDiscountById(discountId);

                        if (d != null && d.isStatus()) { // status = true = active

                            // check đơn tối thiểu
                            if (invoicePrice >= d.getMinInvoicePrice()) {

                                if ("percentage".equalsIgnoreCase(d.getType())) {
                                    // giảm theo %
                                    discountAmount = invoicePrice * d.getValue() / 100.0;

                                    // nếu có giới hạn số tiền giảm tối đa
                                    if (d.getMaxDiscountAmount() > 0
                                            && discountAmount > d.getMaxDiscountAmount()) {
                                        discountAmount = d.getMaxDiscountAmount();
                                    }
                                } else {
                                    // giảm cố định
                                    discountAmount = d.getValue();
                                }

                                if (discountAmount > invoicePrice) {
                                    discountAmount = invoicePrice;
                                }

                                finalPrice = invoicePrice - discountAmount;
                                discountIdToSave = discountId;

                                // Nếu Invoice model có discountId thì set vào:
                                // invoice.setDiscountId(discountId);
                            }
                            // nếu không đủ minInvoicePrice thì không giảm, finalPrice vẫn = invoicePrice
                        }
                    } catch (NumberFormatException e) {
                        // discountId không hợp lệ -> bỏ qua, coi như không áp mã
                    }
                }
                //Viet
                //Viet Cập nhật giá hóa = giá sau giảm
                invoice.setPrice(price);
                invoice.setFinalPrice(BigDecimal.valueOf(finalPrice));
                invoice.setDicountId(discountIdToSave);
                
                invoice = InvoiceDAO.updateInvoicePriceFinalAndDiscount(invoice);
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
                
                double invoicePrice = price.doubleValue();
                List<Discount> discountList = DiscountDAO.getApplicableDiscounts(invoicePrice);
                request.setAttribute("discountList", discountList);

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
