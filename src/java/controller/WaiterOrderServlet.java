/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.TableDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Table;
import model.Food;
import dal.FoodDAO;
import dal.TableDAO;
import model.Order;
import dal.OrderDAO;
import model.Invoice;
import dal.InvoiceDAO;
import model.OrderFood;
import dal.OrderFoodDAO;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import model.User;

/**
 *
 * @author cungp
 */
public class WaiterOrderServlet extends HttpServlet {

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
            out.println("<title>Servlet WaiterOrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet WaiterOrderServlet at " + request.getContextPath() + "</h1>");
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
        if ("open".equals(action)) {
            //Lay tat ca ban
            ArrayList<Table> tableListOccupied = new ArrayList<>();
            ArrayList<Table> tableList = TableDAO.getAllTable();
            //Lay ban dang duoc mo
            for (Table table : tableList) {
                if ("occupied".equals(table.getStatus())) {
                    tableListOccupied.add(table);
                }
            }
            request.setAttribute("tableList", tableListOccupied);
            request.getRequestDispatcher("/WEB-INF/View/Waiter/WaiterTableListToOrder.jsp").forward(request, response);

        } else if ("order".equals(action)) {
            int tableId = Integer.parseInt(request.getParameter("tableId"));
            Table table = TableDAO.getTableById(tableId);
            String tableNumber = table.getTableNumber();
            request.setAttribute("tableId", tableId);
            request.setAttribute("tableNumber", tableNumber);
            ArrayList<Food> foodList = FoodDAO.getAllFood();
            ArrayList<Food> foodListAvailable = new ArrayList<>();
            for (Food food : foodList) {
                if ("available".equals(food.getStatus())) {
                    foodListAvailable.add(food);
                }
            }
            request.setAttribute("foodList", foodListAvailable);
            request.getRequestDispatcher("/WEB-INF/View/Waiter/WaiterOrderFood.jsp").forward(request, response);

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
        if ("sendOrder".equals(action)) {
            HttpSession session = request.getSession();
            User waiter = (User) session.getAttribute("user");
            request.setCharacterEncoding("UTF-8");
            //lay table id
            int tableId = Integer.parseInt(request.getParameter("tableId"));
            //lay invoice id
            Invoice invoice = InvoiceDAO.getPendingInvoiceByTableId(tableId);
            //tao order
            Order order = new Order();
            order.setInvoiceId(invoice.getInvoiceId());
            order.setWaiterId(waiter.getUserId());
            order.setTableId(tableId);
            order.setPrice(BigDecimal.valueOf(0));
            int orderId = OrderDAO.createOrder(order);
            // nhan danh sach food id va so luong
            String[] foodIds = request.getParameterValues("foodId");
            String[] quantities = request.getParameterValues("quantity");
            BigDecimal orderPrice = BigDecimal.ZERO;
            if (foodIds != null && quantities != null) {
                for (int i = 0; i < foodIds.length; i++) {
                    //tinh tien theo mon
                    BigDecimal quantity = new BigDecimal(quantities[i]);
                    BigDecimal foodPrice = FoodDAO.getFoodById(Integer.parseInt(foodIds[i])).getPrice();
                    BigDecimal price = foodPrice.multiply(quantity);
                    //tinh tien vao order
                    orderPrice = orderPrice.add(price);
                    OrderFood orderFood = new OrderFood(orderId,
                                                Integer.parseInt(foodIds[i]), 
                                                Integer.parseInt(quantities[i]), 
                                                price);
                    orderFood = OrderFoodDAO.createOrderFood(orderFood);
                }
            }
            order.setOrderId(orderId);
            order.setPrice(orderPrice);
            order = OrderDAO.updateOrderPrice(order);
            //tro ve
            //Lay tat ca ban
            ArrayList<Table> tableListOccupied = new ArrayList<>();
            ArrayList<Table> tableList = TableDAO.getAllTable();
            //Lay ban dang duoc mo
            for (Table table : tableList) {
                if ("occupied".equals(table.getStatus())) {
                    tableListOccupied.add(table);
                }
            }
            request.setAttribute("tableList", tableListOccupied);
            request.getRequestDispatcher("/WEB-INF/View/Waiter/WaiterTableListToOrder.jsp").forward(request, response);        }
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
