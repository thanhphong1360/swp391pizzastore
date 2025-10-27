/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.OrderDAO;
import dal.OrderFoodDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Order;
import model.OrderFood;

/**
 *
 * @author cungp
 */
public class ChefOrderServlet extends HttpServlet {

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
            out.println("<title>Servlet ChefOrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChefOrderServlet at " + request.getContextPath() + "</h1>");
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
        if ("browse".equals(action)) {
            //lay danh sach order theo status
            String status = request.getParameter("status");
            if (status == null || "pending".equals(status)) {
                ArrayList<Order> pendingOrderList = OrderDAO.getOrdersByStatus("pending");
                for(Order order : pendingOrderList){
                    order.includeTable();
                }
                request.setAttribute("orderList", pendingOrderList);
                request.getRequestDispatcher("/WEB-INF/View/Chef/ChefOrderListPending.jsp").forward(request, response);
            }else if("doing".equals(status)){
                ArrayList<Order> doingOrderList = OrderDAO.getOrdersByStatus("doing");
                for(Order order : doingOrderList){
                    order.includeTable();
                }
                request.setAttribute("orderList", doingOrderList);
                request.getRequestDispatcher("/WEB-INF/View/Chef/ChefOrderListDoing.jsp").forward(request, response);
            }else if("completed".equals(status)){
                ArrayList<Order> completedOrderList = OrderDAO.getOrdersByStatus("completed");
                for(Order order : completedOrderList){
                    order.includeTable();
                }
                request.setAttribute("orderList", completedOrderList);
                request.getRequestDispatcher("/WEB-INF/View/Chef/ChefOrderListCompleted.jsp").forward(request, response);
            }else if("rejected".equals(status)){
                ArrayList<Order> rejectedOrderList = OrderDAO.getOrdersByStatus("rejected");
                for(Order order : rejectedOrderList){
                    order.includeTable();
                }
                request.setAttribute("orderList", rejectedOrderList);
                request.getRequestDispatcher("/WEB-INF/View/Chef/ChefOrderListRejected.jsp").forward(request, response);
            }
        }else if("detail".equals(action)){
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            Order order = OrderDAO.getOrderById(orderId);
            ArrayList<OrderFood> orderFoodList = OrderFoodDAO.getOrderFoodsByOrderId(orderId);
            for(OrderFood orderFood : orderFoodList){
                orderFood.includeFood();
                orderFood.includeOrder();
            }
            order.includeTable();
            order.includeWaiter();
            order.includeChef();
            request.setAttribute("order", order);
            request.setAttribute("orderFoodList", orderFoodList);
            
            //url tro lai list
            String referer = request.getHeader("referer");
            request.setAttribute("backUrl", referer);
            request.getRequestDispatcher("/WEB-INF/View/Chef/ChefOrderDetail.jsp").forward(request, response);
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
        if("approve".equals(action)){
            //change order status
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            Order order = OrderDAO.getOrderById(orderId);
            order.setStatus("doing");
            order = OrderDAO.updateOrderStatus(order);
            
            //view pending orders list
            ArrayList<Order> pendingOrderList = OrderDAO.getOrdersByStatus("pending");
                for(Order orderSample : pendingOrderList){
                    orderSample.includeTable();
                }
                request.setAttribute("orderList", pendingOrderList);
                request.getRequestDispatcher("/WEB-INF/View/Chef/ChefOrderListPending.jsp").forward(request, response);
        }else if("reject".equals(action)){
            //change order status
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            Order order = OrderDAO.getOrderById(orderId);
            order.setStatus("rejected");
            order = OrderDAO.updateOrderStatus(order);
            
            //add reject note
            String reason = request.getParameter("reason");
            order = OrderDAO.updateOrderNoteAppending(order, "Rejected: " + reason);
            
            //view pending or doing orders list
            String pageStatus = request.getParameter("pageStatus");
            if("pending".equals(pageStatus)){
                ArrayList<Order> pendingOrderList = OrderDAO.getOrdersByStatus("pending");
                for(Order orderSample : pendingOrderList){
                    orderSample.includeTable();
                }
                request.setAttribute("orderList", pendingOrderList);
                request.getRequestDispatcher("/WEB-INF/View/Chef/ChefOrderListPending.jsp").forward(request, response);
            }else{
                ArrayList<Order> pendingOrderList = OrderDAO.getOrdersByStatus("doing");
                for(Order orderSample : pendingOrderList){
                    orderSample.includeTable();
                }
                request.setAttribute("orderList", pendingOrderList);
                request.getRequestDispatcher("/WEB-INF/View/Chef/ChefOrderListDoing.jsp").forward(request, response);
            }
        }else if("complete".equals(action)){
            //change order status
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            Order order = OrderDAO.getOrderById(orderId);
            order.setStatus("completed");
            order = OrderDAO.updateOrderStatus(order);
            
            //view doing orders list
            ArrayList<Order> pendingOrderList = OrderDAO.getOrdersByStatus("doing");
                for(Order orderSample : pendingOrderList){
                    orderSample.includeTable();
                }
                request.setAttribute("orderList", pendingOrderList);
                request.getRequestDispatcher("/WEB-INF/View/Chef/ChefOrderListDoing.jsp").forward(request, response);
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
