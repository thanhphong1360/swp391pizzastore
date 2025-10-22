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
            request.setCharacterEncoding("UTF-8");

            String tableId = request.getParameter("tableId");

            // Nhận danh sách foodId và quantity
            String[] foodIds = request.getParameterValues("foodId");
            String[] quantities = request.getParameterValues("quantity");

            if (foodIds != null && quantities != null) {
                for (int i = 0; i < foodIds.length; i++) {
                    System.out.println("Food ID: " + foodIds[i] + ", Quantity: " + quantities[i]);
                    // TODO: lưu vào DB
                }
            }

            response.sendRedirect(request.getContextPath() + "/OrderSuccess.jsp");
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
