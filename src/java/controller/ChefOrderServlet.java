/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.FoodDAO;
import dal.FoodIngredientDAO;
import dal.OrderDAO;
import dal.OrderFoodDAO;
import dal.IngredientDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.ArrayList;
import model.Food;
import model.FoodIngredient;
import model.Order;
import model.OrderFood;
import model.Ingredient;

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
            if (status == null || status.isEmpty()) {
                status = "pending";
            }

            ArrayList<OrderFood> orderFoods = OrderFoodDAO.getOrderFoodsByStatus(status);
            if (orderFoods != null) {
                for (OrderFood orderFood : orderFoods) {
                    orderFood.includeFood();
                }
            }
            request.setAttribute("status", status);
            request.setAttribute("orderFoods", orderFoods);

            request.getRequestDispatcher("/WEB-INF/View/Chef/ChefOrderList.jsp").forward(request, response);

//        } else if ("detail".equals(action)) {
//            int orderId = Integer.parseInt(request.getParameter("orderId"));
//            Order order = OrderDAO.getOrderById(orderId);
//            ArrayList<OrderFood> orderFoodList = OrderFoodDAO.getOrderFoodsByOrderId(orderId);
//            for (OrderFood orderFood : orderFoodList) {
//                orderFood.includeFood();
//                orderFood.includeOrder();
//            }
//            order.includeTable();
//            order.includeWaiter();
//            order.includeChef();
//            request.setAttribute("order", order);
//            request.setAttribute("orderFoodList", orderFoodList);
//
//            //url tro lai list
//            String referer = request.getHeader("referer");
//            request.setAttribute("backUrl", referer);
//            request.getRequestDispatcher("/WEB-INF/View/Chef/ChefOrderDetail.jsp").forward(request, response);
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
        int orderFoodId = Integer.parseInt(request.getParameter("orderFoodId"));
        if ("approve".equals(action)) {
            //lay orderfood tu db
            OrderFood orderFood = OrderFoodDAO.getOrderFoodById(orderFoodId);
            Food food = FoodDAO.getFoodById(orderFood.getFoodId());
            //lay danh sach nguyen lieu
            ArrayList<FoodIngredient> foodIngredients = FoodIngredientDAO.getFoodIngredientsByFoodId(food.getFoodId());
            boolean enough = true;
            StringBuilder shortageMsg = new StringBuilder();

            IngredientDAO igd = new IngredientDAO();
            // 5. Kiểm tra từng nguyên liệu
            for (FoodIngredient fi : foodIngredients) {
                Ingredient ingredient = igd.getById(fi.getIngredientId());

                double requiredAmount = fi.getQuantity() * orderFood.getQuantity();
                double availableAmount = ingredient.getQuantity();

                if (availableAmount < requiredAmount) {
                    enough = false;
                    shortageMsg.append(ingredient.getName())
                            .append(" thiếu ")
                            .append("\n");
                }
            }

            if (!enough) {
                // 6. Nếu thiếu nguyên liệu
                request.setAttribute("error", "Không đủ nguyên liệu:\n" + shortageMsg.toString());

                ArrayList<OrderFood> orderFoods = OrderFoodDAO.getOrderFoodsByStatus("pending");
                if (orderFoods != null) {
                    for (OrderFood of : orderFoods) {
                        of.includeFood();
                    }
                }
                request.setAttribute("status", "pending");
                request.setAttribute("orderFoods", orderFoods);

                request.getRequestDispatcher("/WEB-INF/View/Chef/ChefOrderList.jsp").forward(request, response);
                return;
            }

            // 7. Nếu đủ nguyên liệu, trừ trong kho
            for (FoodIngredient fi : foodIngredients) {
                double requiredAmount = fi.getQuantity() * orderFood.getQuantity();
                double amount = igd.getQuantity(fi.getIngredientId());
                double newAmount = amount - requiredAmount;
                igd.updateQuantity(fi.getIngredientId(), newAmount);
            }

            // 8. Cập nhật trạng thái orderFood thành "accepted"
            OrderFoodDAO.updateOrderFoodStatus(orderFoodId, "doing");

            ArrayList<OrderFood> orderFoods = OrderFoodDAO.getOrderFoodsByStatus("pending");
            if (orderFoods != null) {
                for (OrderFood of : orderFoods) {
                    of.includeFood();
                }
            }
            request.setAttribute("status", "pending");
            request.setAttribute("orderFoods", orderFoods);

            request.getRequestDispatcher("/WEB-INF/View/Chef/ChefOrderList.jsp").forward(request, response);
        } else if ("reject".equals(action)) {
            OrderFoodDAO.updateOrderFoodStatus(orderFoodId, "rejected");
            ArrayList<OrderFood> orderFoods = OrderFoodDAO.getOrderFoodsByStatus("pending");
            if (orderFoods != null) {
                for (OrderFood orderFood : orderFoods) {
                    orderFood.includeFood();
                }
            }
            request.setAttribute("status", "pending");
            request.setAttribute("orderFoods", orderFoods);

            request.getRequestDispatcher("/WEB-INF/View/Chef/ChefOrderList.jsp").forward(request, response);
        } else if ("complete".equals(action)) {
            OrderFoodDAO.updateOrderFoodStatus(orderFoodId, "completed");
            ArrayList<OrderFood> orderFoods = OrderFoodDAO.getOrderFoodsByStatus("doing");
            if (orderFoods != null) {
                for (OrderFood orderFood : orderFoods) {
                    orderFood.includeFood();
                }
            }
            request.setAttribute("status", "doing");
            request.setAttribute("orderFoods", orderFoods);
            request.getRequestDispatcher("/WEB-INF/View/Chef/ChefOrderList.jsp").forward(request, response);

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
